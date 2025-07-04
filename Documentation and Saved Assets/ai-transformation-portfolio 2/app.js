// Smooth scrolling function
function scrollToSection(sectionId) {
    const section = document.getElementById(sectionId);
    if (section) {
        section.scrollIntoView({ 
            behavior: 'smooth',
            block: 'start'
        });
    }
}

// Download resume function
function downloadResume() {
    // Create a temporary link element for download
    const link = document.createElement('a');
    link.href = 'data:text/plain;charset=utf-8,' + encodeURIComponent(generateResumeText());
    link.download = 'Matthew_Scott_AI_Resume.txt';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

// Generate resume text content
function generateResumeText() {
    return `MATTHEW SCOTT - AI INNOVATION STRATEGIST

CONTACT INFORMATION
Email: contact@matthewscott.ai
LinkedIn: linkedin.com/in/matthewscott
GitHub: github.com/matthewscott

EXECUTIVE SUMMARY
Transformed from Medicare compliance professional to AI implementation strategist in 8 weeks through systematic self-directed learning. Created 89+ specialized AI models with privacy-first architecture, achieving production-grade reliability while maintaining 100% data privacy compliance.

KEY ACHIEVEMENTS
• Deployed complete local LLM infrastructure using Ollama
• Built 89+ specialized AI models across 6 life domains
• Achieved 95% implementation speed advantage over traditional solutions
• Maintained 100% privacy compliance for regulated industries
• Integrated cross-platform AI capabilities (Claude, ChatGPT, Perplexity)
• Developed transferable framework for organizational AI adoption

TECHNICAL SKILLS
• Local LLM Deployment (Ollama)
• AI Model Development & Orchestration
• Privacy-First Architecture Design
• Cross-Platform Integration
• Production-Grade System Implementation
• Automated Workflow Development

TRANSFORMATION TIMELINE
Phase 1 (Weeks 1-2): Foundation - Infrastructure setup, VS Code mastery, basic model creation
Phase 2 (Weeks 3-4): Specialization - Domain-specific advisors, prompt engineering mastery
Phase 3 (Weeks 5-6): Production - 89+ models created, production-grade reliability
Phase 4 (Weeks 7-8): Scale - Purpose-driven focus, career integration, strategic alignment

AI ECOSYSTEM CATEGORIES
• Personal Development: matthew_advisor, life_optimizer, goal_tracker
• Professional Skills: linkedin_strategist, career_advisor, technical_writer
• Creative Pursuits: guitar_instructor, music_networker, creative_assistant
• Financial Management: budget_optimizer, investment_advisor, financial_planner
• Health & Wellness: fitness_coach, meal_planner, wellness_tracker
• Local Intelligence: louisville_guide, event_finder, community_connector

BUSINESS VALUE PROPOSITION
• 8-week implementation vs 6-12 months traditional
• Zero vendor lock-in with complete infrastructure control
• 100% data privacy with local processing
• Unlimited scalability with specialized models
• Cost efficiency with self-contained system

METHODOLOGY
1. Systematic Learning Approach
2. Privacy-First Design
3. Purpose-Driven Development
4. Cross-Platform Mastery
5. Production-Ready Implementation
6. Transferable Framework

Available for consulting opportunities in AI implementation, privacy-first solutions, and organizational transformation.`;
}

// Add scroll-based animations
function initScrollAnimations() {
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-in');
            }
        });
    }, observerOptions);

    // Observe all cards and sections
    const elementsToAnimate = document.querySelectorAll(
        '.phase-card, .category-card, .achievement-card, .highlight-card, .step-card, .demo-card, .contact-item'
    );
    
    elementsToAnimate.forEach(el => {
        observer.observe(el);
    });
}

// Add CSS for animations
function addAnimationStyles() {
    const style = document.createElement('style');
    style.textContent = `
        .phase-card,
        .category-card,
        .achievement-card,
        .highlight-card,
        .step-card,
        .demo-card,
        .contact-item {
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 0.6s ease, transform 0.6s ease;
        }
        
        .animate-in {
            opacity: 1 !important;
            transform: translateY(0) !important;
        }
        
        .proficiency-fill {
            width: 0 !important;
            transition: width 1s ease 0.5s;
        }
        
        .phase-card.animate-in .proficiency-fill[style*="15%"] {
            width: 15% !important;
        }
        
        .phase-card.animate-in .proficiency-fill[style*="40%"] {
            width: 40% !important;
        }
        
        .phase-card.animate-in .proficiency-fill[style*="75%"] {
            width: 75% !important;
        }
        
        .phase-card.animate-in .proficiency-fill[style*="95%"] {
            width: 95% !important;
        }
    `;
    document.head.appendChild(style);
}

// Add interactive hover effects for model tags
function initModelTagInteractions() {
    const modelTags = document.querySelectorAll('.model-tag');
    
    modelTags.forEach(tag => {
        tag.addEventListener('mouseenter', function() {
            this.style.transform = 'scale(1.05)';
            this.style.transition = 'transform 0.2s ease';
        });
        
        tag.addEventListener('mouseleave', function() {
            this.style.transform = 'scale(1)';
        });
        
        // Add click interaction to show model details
        tag.addEventListener('click', function() {
            const modelName = this.textContent;
            showModelDetails(modelName);
        });
    });
}

// Show model details in a tooltip-like popup
function showModelDetails(modelName) {
    const modelDescriptions = {
        'matthew_advisor': 'Personal AI advisor with deep context about your goals, challenges, and aspirations',
        'life_optimizer': 'Holistic life optimization assistant focusing on balance and growth',
        'goal_tracker': 'Systematic goal setting and progress tracking with personalized recommendations',
        'linkedin_strategist': 'Professional networking and LinkedIn content optimization specialist',
        'career_advisor': 'Career development guidance based on your skills and industry trends',
        'technical_writer': 'Technical documentation and communication assistance',
        'guitar_instructor': 'Personalized guitar lessons and music theory guidance',
        'music_networker': 'Music industry networking and collaboration opportunities',
        'creative_assistant': 'Creative project ideation and execution support',
        'budget_optimizer': 'Personal finance optimization and spending analysis',
        'investment_advisor': 'Investment strategy and portfolio management guidance',
        'financial_planner': 'Long-term financial planning and wealth building strategies',
        'fitness_coach': 'Personalized workout plans and fitness goal tracking',
        'meal_planner': 'Nutrition optimization and meal planning assistance',
        'wellness_tracker': 'Holistic health and wellness monitoring and recommendations',
        'louisville_guide': 'Local Louisville events, activities, and community insights',
        'event_finder': 'Personalized event discovery and recommendation system',
        'community_connector': 'Local networking and community involvement opportunities'
    };
    
    const description = modelDescriptions[modelName] || 'Specialized AI model designed for specific tasks and personalized assistance';
    
    // Create tooltip
    const tooltip = document.createElement('div');
    tooltip.className = 'model-tooltip';
    tooltip.innerHTML = `
        <div class="tooltip-content">
            <h4>${modelName}</h4>
            <p>${description}</p>
            <button onclick="this.parentElement.parentElement.remove()" class="tooltip-close">×</button>
        </div>
    `;
    
    // Add tooltip styles
    tooltip.style.cssText = `
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: var(--color-surface);
        border: 1px solid var(--color-card-border);
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow-lg);
        z-index: 1000;
        max-width: 400px;
        animation: fadeIn 0.3s ease;
    `;
    
    const tooltipContent = tooltip.querySelector('.tooltip-content');
    tooltipContent.style.cssText = `
        padding: var(--space-24);
        position: relative;
    `;
    
    const tooltipClose = tooltip.querySelector('.tooltip-close');
    tooltipClose.style.cssText = `
        position: absolute;
        top: var(--space-8);
        right: var(--space-8);
        background: none;
        border: none;
        font-size: var(--font-size-xl);
        color: var(--color-text-secondary);
        cursor: pointer;
        width: 24px;
        height: 24px;
        display: flex;
        align-items: center;
        justify-content: center;
    `;
    
    // Add fadeIn animation
    const fadeInStyle = document.createElement('style');
    fadeInStyle.textContent = `
        @keyframes fadeIn {
            from { opacity: 0; transform: translate(-50%, -50%) scale(0.9); }
            to { opacity: 1; transform: translate(-50%, -50%) scale(1); }
        }
    `;
    document.head.appendChild(fadeInStyle);
    
    document.body.appendChild(tooltip);
    
    // Remove tooltip when clicking outside
    setTimeout(() => {
        document.addEventListener('click', function removeTooltip(e) {
            if (!tooltip.contains(e.target)) {
                tooltip.remove();
                document.removeEventListener('click', removeTooltip);
            }
        });
    }, 100);
}

// Add typing effect to hero headline
function initTypingEffect() {
    const headline = document.querySelector('.hero-headline');
    if (!headline) return;
    
    const text = headline.textContent;
    headline.textContent = '';
    headline.style.borderRight = '2px solid var(--color-btn-primary-text)';
    
    let i = 0;
    const typeWriter = () => {
        if (i < text.length) {
            headline.textContent += text.charAt(i);
            i++;
            setTimeout(typeWriter, 50);
        } else {
            // Remove cursor after typing is complete
            setTimeout(() => {
                headline.style.borderRight = 'none';
            }, 1000);
        }
    };
    
    // Start typing effect after a short delay
    setTimeout(typeWriter, 500);
}

// Initialize all features when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    addAnimationStyles();
    initScrollAnimations();
    initModelTagInteractions();
    initTypingEffect();
    
    // Add smooth scrolling to all internal links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const targetId = this.getAttribute('href').substring(1);
            scrollToSection(targetId);
        });
    });
});

// Add window scroll event for navbar-like behavior (if needed)
window.addEventListener('scroll', function() {
    const scrolled = window.pageYOffset;
    const rate = scrolled * -0.5;
    
    // Add parallax effect to hero section
    const hero = document.querySelector('.hero-section');
    if (hero) {
        hero.style.transform = `translate3d(0, ${rate}px, 0)`;
    }
});

// Export functions for global access
window.scrollToSection = scrollToSection;
window.downloadResume = downloadResume;