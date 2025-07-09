#!/usr/bin/env python3
"""
Mirador Configuration Generator
Generates optimized configuration files for consolidated model set
"""

import json
import yaml
from pathlib import Path
from typing import Dict, List
from datetime import datetime

class MiradorConfigGenerator:
    """Generates optimized Mirador configurations"""
    
    def __init__(self, output_dir: str = "./optimized_configs"):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(exist_ok=True)
        
        # Optimized model configurations based on analysis
        self.consolidated_models = {
            'core_models': {
                'matthew_context_provider_v2': {
                    'base_model': 'llama3.2_balanced',
                    'category': 'context_provider',
                    'temperature': 0.5,
                    'context_window': 3072,
                    'role': 'Personal context and preference provider',
                    'priority': 'high',
                    'parameters': {
                        'temperature': '0.5',
                        'top_p': '0.9',
                        'repeat_penalty': '1.1'
                    }
                },
                'decision_simplifier_v2': {
                    'base_model': 'llama3.2_balanced',
                    'category': 'decision_support',
                    'temperature': 0.4,
                    'context_window': 2048,
                    'role': 'Final synthesis and action-oriented recommendations',
                    'priority': 'high',
                    'parameters': {
                        'temperature': '0.4',
                        'top_p': '0.8',
                        'repeat_penalty': '1.1'
                    }
                }
            },
            'domain_specialists': {
                'financial_planning_expert_v6': {
                    'base_model': 'llama3.2_balanced',
                    'category': 'financial_planning',
                    'temperature': 0.4,
                    'context_window': 2048,
                    'role': 'Comprehensive financial analysis and planning',
                    'priority': 'high',
                    'parameters': {
                        'temperature': '0.4',
                        'top_p': '0.8',
                        'repeat_penalty': '1.1'
                    }
                },
                'financial_planning_expert_fast': {
                    'base_model': 'llama3.2_balanced',
                    'category': 'financial_planning',
                    'temperature': 0.5,
                    'context_window': 1536,
                    'role': 'Quick financial queries and calculations',
                    'priority': 'medium',
                    'parameters': {
                        'temperature': '0.5',
                        'top_p': '0.9',
                        'repeat_penalty': '1.0'
                    }
                },
                'louisville_expert_v3': {
                    'base_model': 'llama3.2_balanced',
                    'category': 'local_expert',
                    'temperature': 0.6,
                    'context_window': 2048,
                    'role': 'Louisville-specific context and opportunities',
                    'priority': 'high',
                    'parameters': {
                        'temperature': '0.6',
                        'top_p': '0.9',
                        'repeat_penalty': '1.1'
                    }
                }
            },
            'quality_assurance': {
                'enhanced_agent_enforcer_v2': {
                    'base_model': 'llama3.2_balanced',
                    'category': 'enhanced_agent',
                    'temperature': 0.3,
                    'context_window': 2048,
                    'role': 'Quality validation and consistency checking',
                    'priority': 'high',
                    'parameters': {
                        'temperature': '0.3',
                        'top_p': '0.8',
                        'repeat_penalty': '1.2'
                    }
                },
                'enhanced_agent_fast_v6': {
                    'base_model': 'llama3.2_balanced',
                    'category': 'enhanced_agent',
                    'temperature': 0.4,
                    'context_window': 1536,
                    'role': 'Quick validation and error checking',
                    'priority': 'medium',
                    'parameters': {
                        'temperature': '0.4',
                        'top_p': '0.8',
                        'repeat_penalty': '1.1'
                    }
                }
            },
            'system_optimization': {
                'mirador_system_specialist_v2': {
                    'base_model': 'llama3.2_balanced',
                    'category': 'system_specialist',
                    'temperature': 0.5,
                    'context_window': 2048,
                    'role': 'Meta-analysis and system optimization',
                    'priority': 'medium',
                    'parameters': {
                        'temperature': '0.5',
                        'top_p': '0.9',
                        'repeat_penalty': '1.1'
                    }
                }
            },
            'content_specialists': {
                'linkedin_content_expert': {
                    'base_model': 'llama3.2_balanced',
                    'category': 'content_creation',
                    'temperature': 0.7,
                    'context_window': 2048,
                    'role': 'Professional content creation and communication',
                    'priority': 'medium',
                    'parameters': {
                        'temperature': '0.7',
                        'top_p': '0.9',
                        'repeat_penalty': '1.0'
                    }
                },
                'real_estate_analyzer': {
                    'base_model': 'llama3.2_balanced',
                    'category': 'domain_specialist',
                    'temperature': 0.4,
                    'context_window': 2048,
                    'role': 'Real estate analysis and investment evaluation',
                    'priority': 'low',
                    'parameters': {
                        'temperature': '0.4',
                        'top_p': '0.8',
                        'repeat_penalty': '1.1'
                    }
                },
                'health_wellness_optimizer': {
                    'base_model': 'llama3.2_balanced',
                    'category': 'domain_specialist',
                    'temperature': 0.5,
                    'context_window': 2048,
                    'role': 'Health and wellness optimization guidance',
                    'priority': 'low',
                    'parameters': {
                        'temperature': '0.5',
                        'top_p': '0.9',
                        'repeat_penalty': '1.1'
                    }
                },
                'productivity_optimizer': {
                    'base_model': 'llama3.2_balanced',
                    'category': 'domain_specialist',
                    'temperature': 0.5,
                    'context_window': 2048,
                    'role': 'Productivity and efficiency enhancement',
                    'priority': 'low',
                    'parameters': {
                        'temperature': '0.5',
                        'top_p': '0.9',
                        'repeat_penalty': '1.1'
                    }
                }
            }
        }
        
        # Optimized chain configurations
        self.chain_configurations = {
            'quick_chains': {
                'financial_quick': ['matthew_context_provider_v2', 'financial_planning_expert_fast', 'decision_simplifier_v2'],
                'decision_quick': ['matthew_context_provider_v2', 'decision_simplifier_v2'],
                'local_quick': ['matthew_context_provider_v2', 'louisville_expert_v3', 'decision_simplifier_v2']
            },
            'balanced_chains': {
                'financial_balanced': ['matthew_context_provider_v2', 'financial_planning_expert_v6', 'enhanced_agent_fast_v6', 'decision_simplifier_v2'],
                'comprehensive_analysis': ['matthew_context_provider_v2', 'financial_planning_expert_v6', 'louisville_expert_v3', 'decision_simplifier_v2'],
                'quality_assured': ['matthew_context_provider_v2', 'mirador_system_specialist_v2', 'enhanced_agent_enforcer_v2', 'decision_simplifier_v2']
            },
            'comprehensive_chains': {
                'strategic_planning': ['matthew_context_provider_v2', 'financial_planning_expert_v6', 'louisville_expert_v3', 'enhanced_agent_enforcer_v2', 'mirador_system_specialist_v2', 'decision_simplifier_v2'],
                'life_optimization': ['matthew_context_provider_v2', 'financial_planning_expert_v6', 'health_wellness_optimizer', 'productivity_optimizer', 'enhanced_agent_enforcer_v2', 'decision_simplifier_v2']
            }
        }

    def generate_modelfiles(self):
        """Generate optimized .modelfile configurations"""
        modelfiles_dir = self.output_dir / "modelfiles"
        modelfiles_dir.mkdir(exist_ok=True)
        
        all_models = {}
        for category_models in self.consolidated_models.values():
            all_models.update(category_models)
        
        for model_name, config in all_models.items():
            modelfile_path = modelfiles_dir / f"{model_name}.modelfile"
            
            with open(modelfile_path, 'w') as f:
                f.write(f"# {model_name} - Optimized Configuration\n")
                f.write(f"# Generated: {datetime.now().isoformat()}\n")
                f.write(f"# Role: {config['role']}\n")
                f.write(f"# Category: {config['category']}\n")
                f.write(f"# Priority: {config['priority']}\n\n")
                
                f.write(f"FROM {config['base_model']}\n\n")
                
                # Parameters
                for param, value in config['parameters'].items():
                    f.write(f"PARAMETER {param} {value}\n")
                f.write("\n")
                
                # System prompt based on category
                system_prompt = self._generate_system_prompt(model_name, config)
                f.write(f'SYSTEM """{system_prompt}"""\n')
        
        print(f"Generated {len(all_models)} optimized modelfiles in {modelfiles_dir}")

    def _generate_system_prompt(self, model_name: str, config: Dict) -> str:
        """Generate optimized system prompt for each model"""
        base_prompt = f"""You are {model_name}, a specialized AI assistant in the Mirador multi-agent orchestration system.

Role: {config['role']}
Category: {config['category']}

Core Responsibilities:
"""
        
        if config['category'] == 'context_provider':
            base_prompt += """- Provide comprehensive personal context about Matthew's situation, goals, and preferences
- Maintain consistency with established personal information
- Highlight relevant constraints and priorities for decision-making
- Ensure all recommendations align with personal values and circumstances"""
            
        elif config['category'] == 'financial_planning':
            base_prompt += """- Provide detailed financial analysis and planning recommendations
- Include specific numbers, percentages, and actionable steps
- Consider tax implications, risk tolerance, and time horizons
- Generate comprehensive budget frameworks and investment strategies"""
            
        elif config['category'] == 'decision_support':
            base_prompt += """- Synthesize input from other specialists into clear, actionable recommendations
- Provide structured decision frameworks with pros/cons analysis
- Focus on specific, measurable, time-bound action items
- Ensure recommendations are practical and implementable"""
            
        elif config['category'] == 'local_expert':
            base_prompt += """- Provide Louisville-specific context, opportunities, and resources
- Include current local market conditions, events, and networking opportunities
- Reference specific neighborhoods, venues, and local organizations
- Integrate local economic factors into recommendations"""
            
        elif config['category'] == 'enhanced_agent':
            base_prompt += """- Validate accuracy and consistency of analysis and recommendations
- Check for logical errors, missing considerations, and potential risks
- Ensure recommendations are realistic and achievable
- Provide quality assurance for multi-agent outputs"""
            
        elif config['category'] == 'system_specialist':
            base_prompt += """- Analyze system performance and optimization opportunities
- Provide meta-analysis of decision-making processes
- Identify patterns and trends across multiple analysis sessions
- Recommend system improvements and efficiency enhancements"""
        
        base_prompt += f"""

Output Guidelines:
- Be specific and actionable in all recommendations
- Include relevant data, calculations, and supporting evidence
- Maintain professional tone while being accessible
- Structure responses clearly with headers and bullet points when appropriate
- Always consider the broader context provided by other specialists in the chain

Temperature Setting: {config['temperature']} (optimized for {config['category']} tasks)"""
        
        return base_prompt

    def generate_orchestrator_config(self):
        """Generate optimized orchestrator configuration"""
        config = {
            'mirador_config': {
                'version': '2.0_optimized',
                'generated': datetime.now().isoformat(),
                'description': 'Optimized Mirador configuration with consolidated model set',
                
                'models': self.consolidated_models,
                'chains': self.chain_configurations,
                
                'execution_settings': {
                    'default_timeout': 45,
                    'max_retries': 2,
                    'parallel_execution': True,
                    'context_optimization': True,
                    'quality_validation': True
                },
                
                'performance_settings': {
                    'cache_responses': True,
                    'cache_ttl_minutes': 30,
                    'max_concurrent_models': 3,
                    'memory_limit_mb': 4096,
                    'response_streaming': True
                },
                
                'chain_routing': {
                    'financial': {
                        'quick': 'financial_quick',
                        'balanced': 'financial_balanced',
                        'comprehensive': 'strategic_planning'
                    },
                    'decision': {
                        'quick': 'decision_quick',
                        'balanced': 'comprehensive_analysis',
                        'comprehensive': 'quality_assured'
                    },
                    'local': {
                        'quick': 'local_quick',
                        'balanced': 'comprehensive_analysis',
                        'comprehensive': 'life_optimization'
                    }
                },
                
                'quality_assurance': {
                    'enabled': True,
                    'validation_model': 'enhanced_agent_enforcer_v2',
                    'consistency_checks': True,
                    'fact_checking': True,
                    'actionability_scoring': True
                }
            }
        }
        
        # Save as YAML
        yaml_path = self.output_dir / "mirador_config.yaml"
        with open(yaml_path, 'w') as f:
            yaml.dump(config, f, default_flow_style=False, indent=2)
        
        # Save as JSON
        json_path = self.output_dir / "mirador_config.json"
        with open(json_path, 'w') as f:
            json.dump(config, f, indent=2)
        
        print(f"Generated orchestrator configuration: {yaml_path}, {json_path}")

    def generate_migration_scripts(self):
        """Generate scripts to migrate to optimized configuration"""
        scripts_dir = self.output_dir / "migration_scripts"
        scripts_dir.mkdir(exist_ok=True)
        
        # Update modelfiles script
        update_script = scripts_dir / "update_modelfiles.sh"
        with open(update_script, 'w') as f:
            f.write("#!/bin/bash\n")
            f.write("# Mirador Model Configuration Update Script\n")
            f.write("# Updates all models to use llama3.2_balanced base model\n\n")
            f.write("set -e\n\n")
            f.write("echo \"🔄 Updating Mirador model configurations...\"\n\n")
            
            all_models = {}
            for category_models in self.consolidated_models.values():
                all_models.update(category_models)
            
            for model_name in all_models.keys():
                f.write(f"echo \"Updating {model_name}...\"\n")
                f.write(f"if [ -f \"../modelfiles/{model_name}.modelfile\" ]; then\n")
                f.write(f"    cp \"../modelfiles/{model_name}.modelfile\" \"./{model_name}.modelfile\"\n")
                f.write(f"    ollama create {model_name} -f \"./{model_name}.modelfile\"\n")
                f.write(f"    echo \"✅ Updated {model_name}\"\n")
                f.write("else\n")
                f.write(f"    echo \"⚠️  Modelfile not found for {model_name}\"\n")
                f.write("fi\n\n")
            
            f.write("echo \"🎉 Model configuration update complete!\"\n")
        
        # Make executable
        update_script.chmod(0o755)
        
        # Validation script
        validate_script = scripts_dir / "validate_models.sh"
        with open(validate_script, 'w') as f:
            f.write("#!/bin/bash\n")
            f.write("# Mirador Model Validation Script\n")
            f.write("# Tests all consolidated models for basic functionality\n\n")
            f.write("echo \"🧪 Validating Mirador models...\"\n\n")
            
            all_models = {}
            for category_models in self.consolidated_models.values():
                all_models.update(category_models)
            
            for model_name in all_models.keys():
                f.write(f"echo \"Testing {model_name}...\"\n")
                f.write(f"if ollama run {model_name} \"Hello, please confirm you are working correctly.\" > /dev/null 2>&1; then\n")
                f.write(f"    echo \"✅ {model_name} is working\"\n")
                f.write("else\n")
                f.write(f"    echo \"❌ {model_name} failed validation\"\n")
                f.write("fi\n\n")
            
            f.write("echo \"🎉 Model validation complete!\"\n")
        
        # Make executable
        validate_script.chmod(0o755)
        
        print(f"Generated migration scripts in {scripts_dir}")

    def generate_documentation(self):
        """Generate comprehensive documentation for optimized configuration"""
        docs_dir = self.output_dir / "documentation"
        docs_dir.mkdir(exist_ok=True)
        
        # Model reference guide
        model_guide_path = docs_dir / "model_reference.md"
        with open(model_guide_path, 'w') as f:
            f.write("# Mirador Optimized Model Reference\n\n")
            f.write(f"**Generated:** {datetime.now().isoformat()}\n\n")
            f.write("This document provides a comprehensive reference for the optimized Mirador model set.\n\n")
            
            f.write("## Model Categories\n\n")
            
            for category_name, models in self.consolidated_models.items():
                f.write(f"### {category_name.replace('_', ' ').title()}\n\n")
                
                for model_name, config in models.items():
                    f.write(f"#### {model_name}\n\n")
                    f.write(f"- **Role:** {config['role']}\n")
                    f.write(f"- **Base Model:** {config['base_model']}\n")
                    f.write(f"- **Temperature:** {config['temperature']}\n")
                    f.write(f"- **Context Window:** {config['context_window']}\n")
                    f.write(f"- **Priority:** {config['priority']}\n")
                    f.write("- **Parameters:**\n")
                    for param, value in config['parameters'].items():
                        f.write(f"  - {param}: {value}\n")
                    f.write("\n")
        
        # Chain configuration guide
        chain_guide_path = docs_dir / "chain_reference.md"
        with open(chain_guide_path, 'w') as f:
            f.write("# Mirador Optimized Chain Reference\n\n")
            f.write(f"**Generated:** {datetime.now().isoformat()}\n\n")
            f.write("This document provides guidance on using optimized Mirador chains.\n\n")
            
            for chain_type, chains in self.chain_configurations.items():
                f.write(f"## {chain_type.replace('_', ' ').title()}\n\n")
                
                for chain_name, models in chains.items():
                    f.write(f"### {chain_name}\n\n")
                    f.write("**Models in sequence:**\n")
                    for i, model in enumerate(models, 1):
                        f.write(f"{i}. {model}\n")
                    f.write("\n")
                    
                    # Add usage recommendations
                    if 'quick' in chain_name:
                        f.write("**Best for:** Fast queries requiring immediate responses (< 30 seconds)\n\n")
                    elif 'balanced' in chain_name:
                        f.write("**Best for:** Standard analysis requiring good depth and reasonable speed (30-60 seconds)\n\n")
                    elif 'comprehensive' in chain_name:
                        f.write("**Best for:** Complex strategic analysis requiring maximum depth (60+ seconds)\n\n")
        
        print(f"Generated documentation in {docs_dir}")

def main():
    """Main execution function"""
    print("⚙️  Mirador Configuration Generator")
    print("=" * 40)
    
    generator = MiradorConfigGenerator()
    
    print("📝 Generating optimized modelfiles...")
    generator.generate_modelfiles()
    
    print("🔧 Generating orchestrator configuration...")
    generator.generate_orchestrator_config()
    
    print("🚀 Generating migration scripts...")
    generator.generate_migration_scripts()
    
    print("📚 Generating documentation...")
    generator.generate_documentation()
    
    print("\n✅ Configuration generation complete!")
    print(f"📁 All files generated in: {generator.output_dir}")
    print("\n📋 Next Steps:")
    print("1. Review generated configurations")
    print("2. Run migration scripts to update models")
    print("3. Test with validation scripts")
    print("4. Update your Mirador orchestrator to use new config")

if __name__ == "__main__":
    main()

