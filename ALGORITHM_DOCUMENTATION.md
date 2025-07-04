# Mirador Core Algorithms

## 1. Chain Selection Algorithm

### Overview
The chain selection algorithm determines the optimal sequence of models based on query analysis, historical performance, and context requirements.

```python
import numpy as np
from typing import List, Dict, Tuple
from dataclasses import dataclass
import networkx as nx
from sklearn.metrics.pairwise import cosine_similarity

@dataclass
class ModelNode:
    name: str
    embedding: np.ndarray
    avg_response_time: float
    success_rate: float
    specialties: List[str]
    context_requirements: List[str]

class ChainSelectionAlgorithm:
    def __init__(self, model_registry: Dict[str, ModelNode]):
        self.models = model_registry
        self.performance_history = PerformanceHistory()
        self.embedder = SentenceTransformer('all-MiniLM-L6-v2')
        
    def select_optimal_chain(self, 
                           query: str, 
                           max_models: int = 4,
                           target_time: float = 45.0) -> List[str]:
        """
        Main algorithm for chain selection using graph-based optimization
        """
        # Step 1: Analyze query
        query_features = self._analyze_query(query)
        
        # Step 2: Score all models
        model_scores = self._score_models(query_features)
        
        # Step 3: Build dependency graph
        graph = self._build_dependency_graph(model_scores)
        
        # Step 4: Find optimal path
        optimal_chain = self._find_optimal_path(
            graph, 
            query_features,
            max_models,
            target_time
        )
        
        return optimal_chain
    
    def _analyze_query(self, query: str) -> Dict:
        """Extract features from query for model matching"""
        # Generate embedding
        query_embedding = self.embedder.encode(query)
        
        # Detect domains
        domains = []
        domain_keywords = {
            'financial': ['budget', 'money', 'income', 'investment', '401k'],
            'music': ['guitar', 'practice', 'touring', 'performance'],
            'career': ['job', 'transition', 'ai', 'portfolio'],
            'family': ['aurora', 'daughter', 'parenting', 'time']
        }
        
        query_lower = query.lower()
        for domain, keywords in domain_keywords.items():
            if any(kw in query_lower for kw in keywords):
                domains.append(domain)
        
        # Assess complexity
        complexity = self._assess_complexity(query)
        
        return {
            'embedding': query_embedding,
            'domains': domains,
            'complexity': complexity,
            'length': len(query.split()),
            'has_numbers': any(char.isdigit() for char in query),
            'is_question': query.strip().endswith('?')
        }
    
    def _assess_complexity(self, query: str) -> float:
        """
        Assess query complexity on scale 0-1
        Based on multiple factors
        """
        factors = {
            'length': min(len(query.split()) / 50, 1.0),
            'domains': min(len(self._detect_domains(query)) / 3, 1.0),
            'conditionals': query.lower().count('if') * 0.2,
            'comparisons': query.lower().count('vs') * 0.3,
            'temporal': any(word in query.lower() 
                          for word in ['timeline', 'schedule', 'plan']) * 0.3
        }
        
        return min(sum(factors.values()), 1.0)
    
    def _score_models(self, query_features: Dict) -> Dict[str, float]:
        """
        Score each model based on relevance to query
        """
        scores = {}
        query_embedding = query_features['embedding']
        
        for model_name, model in self.models.items():
            # Semantic similarity
            similarity = cosine_similarity(
                [query_embedding], 
                [model.embedding]
            )[0][0]
            
            # Domain match bonus
            domain_bonus = 0
            for domain in query_features['domains']:
                if domain in model.specialties:
                    domain_bonus += 0.2
            
            # Historical performance
            perf_score = self.performance_history.get_model_score(
                model_name,
                query_features['domains']
            )
            
            # Complexity match
            complexity_match = 1 - abs(
                query_features['complexity'] - 
                self._get_model_complexity_rating(model_name)
            )
            
            # Weighted final score
            scores[model_name] = (
                0.4 * similarity +
                0.3 * perf_score +
                0.2 * domain_bonus +
                0.1 * complexity_match
            )
        
        return scores
    
    def _build_dependency_graph(self, 
                               model_scores: Dict[str, float]) -> nx.DiGraph:
        """
        Build directed graph of model dependencies and transitions
        """
        G = nx.DiGraph()
        
        # Add nodes with scores
        for model, score in model_scores.items():
            G.add_node(model, score=score)
        
        # Add edges based on successful historical transitions
        transitions = self.performance_history.get_transition_matrix()
        
        for source in G.nodes():
            for target in G.nodes():
                if source != target:
                    # Get historical transition probability
                    trans_prob = transitions.get(source, {}).get(target, 0)
                    
                    # Add edge if transition is viable
                    if trans_prob > 0.1 or self._is_valid_transition(source, target):
                        weight = trans_prob * model_scores[target]
                        G.add_edge(source, target, weight=weight)
        
        return G
    
    def _is_valid_transition(self, source: str, target: str) -> bool:
        """
        Determine if transition between models is logically valid
        """
        # Define transition rules
        rules = {
            'context_provider': ['domain_expert', 'synthesizer'],
            'domain_expert': ['domain_expert', 'decision_maker', 'synthesizer'],
            'synthesizer': ['decision_maker', 'validator'],
            'decision_maker': ['validator'],
            'validator': []
        }
        
        source_type = self._get_model_type(source)
        target_type = self._get_model_type(target)
        
        return target_type in rules.get(source_type, [])
    
    def _find_optimal_path(self,
                          graph: nx.DiGraph,
                          query_features: Dict,
                          max_models: int,
                          target_time: float) -> List[str]:
        """
        Find optimal path through model graph using modified A* algorithm
        """
        # Identify start nodes (usually context providers)
        start_nodes = [n for n in graph.nodes() 
                      if 'context' in n or graph.in_degree(n) == 0]
        
        # Identify end nodes (usually decision makers or synthesizers)
        end_nodes = [n for n in graph.nodes()
                    if 'decision' in n or 'synthesizer' in n]
        
        best_path = []
        best_score = -1
        
        for start in start_nodes:
            for end in end_nodes:
                try:
                    # Find paths using modified A* with constraints
                    paths = list(nx.all_simple_paths(
                        graph, start, end, 
                        cutoff=max_models
                    ))
                    
                    for path in paths:
                        score = self._evaluate_path(
                            path, graph, query_features, target_time
                        )
                        if score > best_score:
                            best_score = score
                            best_path = path
                            
                except nx.NetworkXNoPath:
                    continue
        
        # If no path found, use top-scoring models
        if not best_path:
            sorted_models = sorted(
                graph.nodes(),
                key=lambda x: graph.nodes[x]['score'],
                reverse=True
            )
            best_path = sorted_models[:min(3, max_models)]
        
        return best_path
    
    def _evaluate_path(self,
                      path: List[str],
                      graph: nx.DiGraph,
                      query_features: Dict,
                      target_time: float) -> float:
        """
        Evaluate quality of a model chain path
        """
        # Calculate total response time
        total_time = sum(self.models[m].avg_response_time for m in path)
        
        # Time penalty if exceeds target
        time_penalty = max(0, (total_time - target_time) / target_time)
        
        # Calculate path score
        path_score = 0
        for i, model in enumerate(path):
            # Node score
            path_score += graph.nodes[model]['score']
            
            # Edge score (transition quality)
            if i > 0:
                edge_weight = graph.edges[path[i-1], model].get('weight', 0)
                path_score += edge_weight
        
        # Diversity bonus (different model types)
        model_types = [self._get_model_type(m) for m in path]
        diversity_bonus = len(set(model_types)) * 0.1
        
        # Final score with penalties/bonuses
        final_score = path_score + diversity_bonus - time_penalty
        
        return final_score
```

## 2. Context Propagation Algorithm

### Overview
Ensures semantic continuity between models by extracting and propagating key insights.

```python
import re
from typing import List, Dict, Set, Tuple
import spacy
from transformers import pipeline

class ContextPropagationAlgorithm:
    def __init__(self):
        self.nlp = spacy.load("en_core_web_sm")
        self.summarizer = pipeline("summarization", model="facebook/bart-large-cnn")
        self.key_patterns = self._compile_patterns()
        
    def propagate_context(self,
                         previous_output: str,
                         next_model: str,
                         chain_context: Dict,
                         max_tokens: int = 1024) -> str:
        """
        Main context propagation algorithm
        """
        # Step 1: Extract structured information
        extracted = self._extract_structured_info(previous_output)
        
        # Step 2: Identify key insights
        key_insights = self._identify_key_insights(
            previous_output, 
            extracted
        )
        
        # Step 3: Get model requirements
        requirements = self._get_model_requirements(next_model)
        
        # Step 4: Build context prompt
        context_prompt = self._build_context_prompt(
            key_insights,
            requirements,
            chain_context,
            max_tokens
        )
        
        return context_prompt
    
    def _extract_structured_info(self, text: str) -> Dict:
        """
        Extract structured information from text
        """
        extracted = {
            'entities': [],
            'numbers': [],
            'dates': [],
            'recommendations': [],
            'constraints': [],
            'priorities': []
        }
        
        # Parse with spaCy
        doc = self.nlp(text)
        
        # Extract entities
        for ent in doc.ents:
            if ent.label_ in ['PERSON', 'ORG', 'MONEY', 'DATE', 'TIME']:
                extracted['entities'].append({
                    'text': ent.text,
                    'type': ent.label_,
                    'context': ent.sent.text
                })
        
        # Extract recommendations (pattern matching)
        rec_patterns = [
            r'(?:recommend|suggest|should|could|would)\s+(.+?)(?:\.|,|;)',
            r'(?:best|optimal|ideal)\s+(?:approach|strategy|option)\s+(?:is|would be)\s+(.+?)(?:\.|,|;)'
        ]
        
        for pattern in rec_patterns:
            matches = re.finditer(pattern, text, re.IGNORECASE)
            for match in matches:
                extracted['recommendations'].append(match.group(1).strip())
        
        # Extract priorities
        priority_patterns = [
            r'(?:top|highest|main)\s+(?:priority|priorities):\s*(.+?)(?:\.|;|\n)',
            r'(?:focus on|prioritize)\s+(.+?)(?:\.|,|;)'
        ]
        
        for pattern in priority_patterns:
            matches = re.finditer(pattern, text, re.IGNORECASE)
            for match in matches:
                extracted['priorities'].append(match.group(1).strip())
        
        # Extract constraints
        constraint_patterns = [
            r'(?:constraint|limitation|restriction):\s*(.+?)(?:\.|;|\n)',
            r'(?:cannot|must not|should not)\s+(.+?)(?:\.|,|;)'
        ]
        
        for pattern in constraint_patterns:
            matches = re.finditer(pattern, text, re.IGNORECASE)
            for match in matches:
                extracted['constraints'].append(match.group(1).strip())
        
        return extracted
    
    def _identify_key_insights(self, 
                              text: str, 
                              extracted: Dict) -> Dict:
        """
        Identify the most important insights to propagate
        """
        insights = {
            'summary': '',
            'key_points': [],
            'decisions': [],
            'metrics': {},
            'context_items': []
        }
        
        # Generate summary if text is long
        if len(text.split()) > 200:
            insights['summary'] = self._generate_summary(text)
        
        # Extract key points using TF-IDF
        key_points = self._extract_key_points(text)
        insights['key_points'] = key_points[:5]  # Top 5
        
        # Extract decisions
        decision_patterns = [
            r'(?:decided|chosen|selected)\s+(?:to\s+)?(.+?)(?:\.|,|;)',
            r'(?:will|going to|plan to)\s+(.+?)(?:\.|,|;)'
        ]
        
        for pattern in decision_patterns:
            matches = re.finditer(pattern, text, re.IGNORECASE)
            for match in matches:
                insights['decisions'].append(match.group(1).strip())
        
        # Extract metrics
        metric_pattern = r'(\$?\d+(?:,\d+)*(?:\.\d+)?)\s*(?:%|dollars?|months?|years?|hours?)'
        matches = re.finditer(metric_pattern, text, re.IGNORECASE)
        for match in matches:
            insights['metrics'][match.group(0)] = match.group(1)
        
        # Add high-value extracted items
        insights['context_items'].extend(extracted['recommendations'][:3])
        insights['context_items'].extend(extracted['priorities'][:2])
        
        return insights
    
    def _generate_summary(self, text: str, max_length: int = 150) -> str:
        """
        Generate concise summary of text
        """
        try:
            # Use BART for summarization
            summary = self.summarizer(
                text, 
                max_length=max_length, 
                min_length=50, 
                do_sample=False
            )
            return summary[0]['summary_text']
        except:
            # Fallback to simple extraction
            sentences = text.split('.')
            return '. '.join(sentences[:3]) + '.'
    
    def _extract_key_points(self, text: str, num_points: int = 5) -> List[str]:
        """
        Extract key points using TF-IDF scoring
        """
        from sklearn.feature_extraction.text import TfidfVectorizer
        from sklearn.metrics.pairwise import cosine_similarity
        
        # Split into sentences
        sentences = [s.strip() for s in text.split('.') if len(s.strip()) > 10]
        
        if len(sentences) <= num_points:
            return sentences
        
        # Calculate TF-IDF
        vectorizer = TfidfVectorizer(
            max_features=100,
            stop_words='english'
        )
        tfidf_matrix = vectorizer.fit_transform(sentences)
        
        # Calculate sentence scores
        scores = []
        for i, sentence in enumerate(sentences):
            # Score based on similarity to document
            doc_vector = tfidf_matrix.mean(axis=0)
            sent_vector = tfidf_matrix[i]
            similarity = cosine_similarity(sent_vector, doc_vector)[0][0]
            scores.append((similarity, sentence))
        
        # Return top sentences
        scores.sort(reverse=True)
        return [s[1] for s in scores[:num_points]]
    
    def _build_context_prompt(self,
                             insights: Dict,
                             requirements: List[str],
                             chain_context: Dict,
                             max_tokens: int) -> str:
        """
        Build the context prompt for next model
        """
        prompt_parts = []
        
        # Add summary if available
        if insights['summary']:
            prompt_parts.append(f"Previous Analysis Summary:\n{insights['summary']}\n")
        
        # Add key insights
        if insights['key_points']:
            prompt_parts.append("Key Points from Previous Analysis:")
            for point in insights['key_points']:
                prompt_parts.append(f"• {point}")
            prompt_parts.append("")
        
        # Add decisions if any
        if insights['decisions']:
            prompt_parts.append("Decisions/Actions Identified:")
            for decision in insights['decisions']:
                prompt_parts.append(f"• {decision}")
            prompt_parts.append("")
        
        # Add metrics
        if insights['metrics']:
            prompt_parts.append("Key Metrics:")
            for metric, value in insights['metrics'].items():
                prompt_parts.append(f"• {metric}")
            prompt_parts.append("")
        
        # Add required context fields
        if requirements:
            prompt_parts.append("Context Information:")
            for req in requirements:
                if req in chain_context:
                    prompt_parts.append(f"• {req}: {chain_context[req]}")
            prompt_parts.append("")
        
        # Add instruction for next model
        prompt_parts.append("Building on the above analysis, please continue with your specialized perspective.")
        
        # Join and trim to token limit
        full_prompt = "\n".join(prompt_parts)
        
        # Simple token estimation (avg 4 chars per token)
        estimated_tokens = len(full_prompt) // 4
        if estimated_tokens > max_tokens:
            # Trim from the middle sections
            return self._trim_to_token_limit(full_prompt, max_tokens)
        
        return full_prompt
    
    def _trim_to_token_limit(self, text: str, max_tokens: int) -> str:
        """
        Intelligently trim text to fit token limit
        """
        # Priority order for sections to keep
        sections = text.split('\n\n')
        priority_sections = []
        
        # Always keep first and last sections
        if sections:
            priority_sections.append(sections[0])
            if len(sections) > 1:
                priority_sections.append(sections[-1])
        
        # Add middle sections by importance
        for section in sections[1:-1]:
            if any(keyword in section.lower() 
                  for keyword in ['decision', 'key', 'important', 'critical']):
                priority_sections.insert(-1, section)
        
        # Build trimmed version
        result = []
        current_tokens = 0
        
        for section in priority_sections:
            section_tokens = len(section) // 4
            if current_tokens + section_tokens <= max_tokens:
                result.append(section)
                current_tokens += section_tokens
            else:
                break
        
        return '\n\n'.join(result)
```

## 3. Response Synthesis Algorithm

### Overview
Combines outputs from multiple models into coherent, actionable responses.

```python
from typing import List, Dict, Tuple
import numpy as np
from collections import defaultdict

class ResponseSynthesisAlgorithm:
    def __init__(self):
        self.conflict_resolver = ConflictResolver()
        self.quality_scorer = QualityScorer()
        self.formatter = ResponseFormatter()
        
    def synthesize_response(self,
                           model_outputs: List[Dict],
                           query: str,
                           chain_metadata: Dict) -> str:
        """
        Main synthesis algorithm
        """
        # Step 1: Extract and categorize insights
        categorized = self._categorize_insights(model_outputs)
        
        # Step 2: Resolve conflicts
        resolved = self._resolve_conflicts(categorized)
        
        # Step 3: Prioritize recommendations
        prioritized = self._prioritize_recommendations(resolved, query)
        
        # Step 4: Build structured response
        structured = self._build_structured_response(
            prioritized,
            chain_metadata
        )
        
        # Step 5: Format for output
        formatted = self.formatter.format_response(structured)
        
        return formatted
    
    def _categorize_insights(self, 
                            model_outputs: List[Dict]) -> Dict[str, List]:
        """
        Categorize insights from multiple models
        """
        categories = defaultdict(list)
        
        for output in model_outputs:
            model_name = output['model']
            content = output['content']
            
            # Extract different types of insights
            insights = {
                'recommendations': self._extract_recommendations(content),
                'risks': self._extract_risks(content),
                'opportunities': self._extract_opportunities(content),
                'constraints': self._extract_constraints(content),
                'metrics': self._extract_metrics(content),
                'timelines': self._extract_timelines(content)
            }
            
            # Add to categories with source attribution
            for category, items in insights.items():
                for item in items:
                    categories[category].append({
                        'content': item,
                        'source': model_name,
                        'confidence': output.get('confidence', 0.8)
                    })
        
        return dict(categories)
    
    def _resolve_conflicts(self, 
                          categorized: Dict[str, List]) -> Dict[str, List]:
        """
        Resolve conflicts between different model recommendations
        """
        resolved = {}
        
        for category, items in categorized.items():
            if category == 'recommendations':
                # Special handling for recommendations
                resolved[category] = self._resolve_recommendation_conflicts(items)
            elif category == 'metrics':
                # Average numeric conflicts
                resolved[category] = self._resolve_metric_conflicts(items)
            else:
                # Default: keep all non-conflicting items
                resolved[category] = self._deduplicate_items(items)
        
        return resolved
    
    def _resolve_recommendation_conflicts(self, 
                                        recommendations: List[Dict]) -> List[Dict]:
        """
        Resolve conflicting recommendations using weighted voting
        """
        # Group similar recommendations
        groups = self._group_similar_items(recommendations)
        
        resolved = []
        for group in groups:
            if len(group) == 1:
                resolved.append(group[0])
            else:
                # Multiple similar recommendations - resolve conflict
                # Check for direct contradictions
                if self._has_contradiction(group):
                    # Use confidence-weighted selection
                    best = max(group, key=lambda x: x['confidence'])
                    best['note'] = 'Selected from conflicting recommendations'
                    resolved.append(best)
                else:
                    # Merge complementary recommendations
                    merged = self._merge_recommendations(group)
                    resolved.append(merged)
        
        return resolved
    
    def _has_contradiction(self, items: List[Dict]) -> bool:
        """
        Detect if items contain contradictory advice
        """
        contradiction_pairs = [
            ('increase', 'decrease'),
            ('buy', 'sell'),
            ('wait', 'act now'),
            ('risky', 'safe'),
            ('long-term', 'short-term')
        ]
        
        texts = [item['content'].lower() for item in items]
        
        for text1 in texts:
            for text2 in texts:
                if text1 != text2:
                    for word1, word2 in contradiction_pairs:
                        if word1 in text1 and word2 in text2:
                            return True
        
        return False
    
    def _merge_recommendations(self, items: List[Dict]) -> Dict:
        """
        Merge complementary recommendations
        """
        # Combine content
        contents = [item['content'] for item in items]
        sources = list(set(item['source'] for item in items))
        avg_confidence = np.mean([item['confidence'] for item in items])
        
        # Create merged recommendation
        merged_content = self._combine_texts(contents)
        
        return {
            'content': merged_content,
            'source': sources,
            'confidence': avg_confidence,
            'type': 'merged'
        }
    
    def _prioritize_recommendations(self,
                                   resolved: Dict[str, List],
                                   query: str) -> Dict[str, List]:
        """
        Prioritize recommendations based on relevance and impact
        """
        if 'recommendations' not in resolved:
            return resolved
        
        recommendations = resolved['recommendations']
        
        # Score each recommendation
        scored = []
        for rec in recommendations:
            score = self._score_recommendation(rec, query, resolved)
            scored.append((score, rec))
        
        # Sort by score
        scored.sort(reverse=True, key=lambda x: x[0])
        
        # Add priority levels
        prioritized_recs = []
        for i, (score, rec) in enumerate(scored):
            rec['priority'] = 'high' if i < 3 else 'medium' if i < 6 else 'low'
            rec['impact_score'] = score
            prioritized_recs.append(rec)
        
        resolved['recommendations'] = prioritized_recs
        return resolved
    
    def _score_recommendation(self,
                             rec: Dict,
                             query: str,
                             context: Dict) -> float:
        """
        Score recommendation based on multiple factors
        """
        score = 0.0
        
        # Relevance to query
        relevance = self._calculate_relevance(rec['content'], query)
        score += relevance * 0.3
        
        # Source confidence
        score += rec['confidence'] * 0.2
        
        # Actionability
        actionability = self._assess_actionability(rec['content'])
        score += actionability * 0.2
        
        # Alignment with constraints
        if 'constraints' in context:
            alignment = self._check_constraint_alignment(
                rec['content'], 
                context['constraints']
            )
            score += alignment * 0.15
        
        # Urgency/Timeline factors
        urgency = self._assess_urgency(rec['content'])
        score += urgency * 0.15
        
        return score
    
    def _build_structured_response(self,
                                  prioritized: Dict[str, List],
                                  metadata: Dict) -> Dict:
        """
        Build structured response from prioritized insights
        """
        response = {
            'summary': self._generate_executive_summary(prioritized),
            'recommendations': [],
            'risks': [],
            'opportunities': [],
            'metrics': {},
            'timeline': [],
            'next_steps': [],
            'metadata': metadata
        }
        
        # Add prioritized recommendations
        if 'recommendations' in prioritized:
            for rec in prioritized['recommendations']:
                if rec['priority'] == 'high':
                    response['recommendations'].append({
                        'action': rec['content'],
                        'priority': rec['priority'],
                        'source': rec['source'],
                        'rationale': self._generate_rationale(rec, prioritized)
                    })
        
        # Add risks with mitigation strategies
        if 'risks' in prioritized:
            for risk in prioritized['risks'][:5]:  # Top 5 risks
                response['risks'].append({
                    'description': risk['content'],
                    'mitigation': self._suggest_mitigation(risk, prioritized)
                })
        
        # Add opportunities
        if 'opportunities' in prioritized:
            response['opportunities'] = [
                opp['content'] for opp in prioritized['opportunities'][:5]
            ]
        
        # Consolidate metrics
        if 'metrics' in prioritized:
            response['metrics'] = self._consolidate_metrics(prioritized['metrics'])
        
        # Build timeline
        if 'timelines' in prioritized:
            response['timeline'] = self._build_consolidated_timeline(
                prioritized['timelines']
            )
        
        # Generate next steps
        response['next_steps'] = self._generate_next_steps(response)
        
        return response
    
    def _generate_executive_summary(self, insights: Dict) -> str:
        """
        Generate concise executive summary
        """
        summary_parts = []
        
        # Key recommendation
        if 'recommendations' in insights and insights['recommendations']:
            top_rec = insights['recommendations'][0]
            summary_parts.append(
                f"Primary recommendation: {top_rec['content']}"
            )
        
        # Key metrics
        if 'metrics' in insights:
            key_metrics = self._extract_key_metrics(insights['metrics'])
            if key_metrics:
                summary_parts.append(
                    f"Key metrics: {', '.join(key_metrics)}"
                )
        
        # Timeline
        if 'timelines' in insights:
            timeline_summary = self._summarize_timeline(insights['timelines'])
            if timeline_summary:
                summary_parts.append(timeline_summary)
        
        return " ".join(summary_parts)
```

## 4. Performance Optimization Algorithm

### Overview
Dynamically optimizes model performance based on real-time metrics.

```python
import time
from collections import deque
from typing import Dict, List, Tuple, Optional
import threading
import json

class PerformanceOptimizationAlgorithm:
    def __init__(self, config_path: str):
        self.config_path = config_path
        self.metrics_window = deque(maxlen=100)  # Last 100 executions
        self.model_stats = defaultdict(lambda: {
            'total_time': 0,
            'executions': 0,
            'failures': 0,
            'tokens_processed': 0
        })
        self.optimization_thread = None
        self.running = True
        
    def track_execution(self,
                       model: str,
                       start_time: float,
                       end_time: float,
                       tokens: int,
                       success: bool) -> None:
        """
        Track model execution metrics
        """
        execution_time = end_time - start_time
        
        # Update model stats
        self.model_stats[model]['total_time'] += execution_time
        self.model_stats[model]['executions'] += 1
        self.model_stats[model]['tokens_processed'] += tokens
        if not success:
            self.model_stats[model]['failures'] += 1
        
        # Add to metrics window
        self.metrics_window.append({
            'model': model,
            'time': execution_time,
            'tokens': tokens,
            'success': success,
            'timestamp': end_time,
            'tokens_per_second': tokens / execution_time if execution_time > 0 else 0
        })
        
        # Trigger optimization check
        if len(self.metrics_window) >= 10:
            self._check_optimization_needed()
    
    def _check_optimization_needed(self) -> None:
        """
        Check if optimization is needed based on recent performance
        """
        recent_metrics = list(self.metrics_window)[-20:]
        
        # Calculate recent performance indicators
        avg_time = np.mean([m['time'] for m in recent_metrics])
        failure_rate = sum(1 for m in recent_metrics if not m['success']) / len(recent_metrics)
        avg_tps = np.mean([m['tokens_per_second'] for m in recent_metrics])
        
        # Check optimization triggers
        triggers = {
            'slow_response': avg_time > 45,
            'high_failure': failure_rate > 0.05,
            'low_throughput': avg_tps < 100
        }
        
        if any(triggers.values()):
            self._trigger_optimization(triggers)
    
    def _trigger_optimization(self, triggers: Dict[str, bool]) -> None:
        """
        Trigger optimization based on performance triggers
        """
        if self.optimization_thread and self.optimization_thread.is_alive():
            return  # Optimization already running
        
        self.optimization_thread = threading.Thread(
            target=self._optimize_models,
            args=(triggers,)
        )
        self.optimization_thread.start()
    
    def _optimize_models(self, triggers: Dict[str, bool]) -> None:
        """
        Main optimization algorithm
        """
        optimizations = []
        
        # Analyze each model's performance
        for model, stats in self.model_stats.items():
            if stats['executions'] < 5:
                continue  # Not enough data
            
            avg_time = stats['total_time'] / stats['executions']
            failure_rate = stats['failures'] / stats['executions']
            avg_tokens = stats['tokens_processed'] / stats['executions']
            
            # Generate optimization recommendations
            model_opts = self._generate_model_optimizations(
                model, avg_time, failure_rate, avg_tokens, triggers
            )
            
            if model_opts:
                optimizations.extend(model_opts)
        
        # Apply optimizations
        if optimizations:
            self._apply_optimizations(optimizations)
    
    def _generate_model_optimizations(self,
                                     model: str,
                                     avg_time: float,
                                     failure_rate: float,
                                     avg_tokens: float,
                                     triggers: Dict) -> List[Dict]:
        """
        Generate specific optimizations for a model
        """
        optimizations = []
        
        # Load current model config
        config = self._load_model_config(model)
        
        # Optimization 1: Context window adjustment
        if triggers['slow_response'] and avg_tokens < config['num_ctx'] * 0.3:
            # Model using less than 30% of context window
            new_ctx = max(2048, int(avg_tokens * 3))
            optimizations.append({
                'model': model,
                'type': 'context_reduction',
                'param': 'num_ctx',
                'old_value': config['num_ctx'],
                'new_value': new_ctx,
                'reason': f'Reducing context from {config["num_ctx"]} to {new_ctx} (avg usage: {int(avg_tokens)})'
            })
        
        # Optimization 2: Temperature adjustment for consistency
        if failure_rate > 0.05 and config.get('temperature', 0.7) > 0.3:
            new_temp = max(0.1, config.get('temperature', 0.7) - 0.2)
            optimizations.append({
                'model': model,
                'type': 'temperature_reduction',
                'param': 'temperature',
                'old_value': config.get('temperature', 0.7),
                'new_value': new_temp,
                'reason': f'Reducing temperature for consistency (failure rate: {failure_rate:.1%})'
            })
        
        # Optimization 3: Batch size for throughput
        if triggers['low_throughput']:
            current_batch = config.get('num_batch', 512)
            new_batch = min(2048, current_batch * 2)
            optimizations.append({
                'model': model,
                'type': 'batch_increase',
                'param': 'num_batch',
                'old_value': current_batch,
                'new_value': new_batch,
                'reason': 'Increasing batch size for better throughput'
            })
        
        # Optimization 4: GPU layers adjustment
        if avg_time > 30 and config.get('num_gpu', 1) < 2:
            optimizations.append({
                'model': model,
                'type': 'gpu_increase',
                'param': 'num_gpu',
                'old_value': config.get('num_gpu', 1),
                'new_value': 2,
                'reason': 'Increasing GPU layers for faster inference'
            })
        
        return optimizations
    
    def _apply_optimizations(self, optimizations: List[Dict]) -> None:
        """
        Apply optimizations to model configurations
        """
        # Group by model
        by_model = defaultdict(list)
        for opt in optimizations:
            by_model[opt['model']].append(opt)
        
        # Apply optimizations for each model
        for model, opts in by_model.items():
            try:
                # Create optimized model variant
                self._create_optimized_variant(model, opts)
                
                # Log optimizations
                self._log_optimization(model, opts)
                
                # Schedule gradual rollout
                self._schedule_rollout(model, opts)
                
            except Exception as e:
                print(f"Failed to optimize {model}: {e}")
    
    def _create_optimized_variant(self, 
                                 model: str, 
                                 optimizations: List[Dict]) -> str:
        """
        Create optimized model variant
        """
        # Generate optimized modelfile
        base_config = self._load_model_config(model)
        optimized_name = f"{model}_opt_{int(time.time())}"
        
        # Apply optimizations
        for opt in optimizations:
            base_config[opt['param']] = opt['new_value']
        
        # Create new modelfile
        modelfile_content = self._generate_modelfile(base_config)
        
        # Create model in Ollama
        import subprocess
        with tempfile.NamedTemporaryFile(mode='w', suffix='.modelfile') as f:
            f.write(modelfile_content)
            f.flush()
            
            result = subprocess.run(
                ['ollama', 'create', optimized_name, '-f', f.name],
                capture_output=True,
                text=True
            )
            
            if result.returncode != 0:
                raise Exception(f"Failed to create model: {result.stderr}")
        
        return optimized_name
    
    def _schedule_rollout(self, model: str, optimizations: List[Dict]) -> None:
        """
        Schedule gradual rollout of optimized model
        """
        # Implement A/B testing logic
        rollout_config = {
            'original_model': model,
            'optimized_model': f"{model}_opt_{int(time.time())}",
            'rollout_percentage': 10,  # Start with 10%
            'start_time': time.time(),
            'optimizations': optimizations,
            'metrics': {
                'original': {'executions': 0, 'total_time': 0},
                'optimized': {'executions': 0, 'total_time': 0}
            }
        }
        
        # Save rollout config
        with open(f'rollouts/{model}_rollout.json', 'w') as f:
            json.dump(rollout_config, f)
        
        # Schedule incremental rollout
        self._schedule_rollout_increase(model, rollout_config)
```

These algorithms form the core of Mirador's intelligent orchestration system, enabling:
- Optimal model selection based on query analysis
- Seamless context propagation between models
- Intelligent synthesis of multiple perspectives
- Continuous performance optimization

Each algorithm is designed to work together, creating a cohesive system that delivers high-quality results while maintaining performance.