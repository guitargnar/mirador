// Wait for DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    // Initialize all functionality
    initSmoothScrolling();
    initNavbar();
    initAnimations();
    initFormHandling();
    initInteractiveElements();
});

// Smooth scrolling functionality
function initSmoothScrolling() {
    // Handle navigation links
    const navLinks = document.querySelectorAll('.navbar__link');
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href').substring(1);
            scrollToSection(targetId);
        });
    });
}

// Global scroll to section function
function scrollToSection(sectionId) {
    const section = document.getElementById(sectionId);
    if (section) {
        const navbar = document.querySelector('.navbar');
        const navbarHeight = navbar ? navbar.offsetHeight : 0;
        const targetPosition = section.offsetTop - navbarHeight - 20;
        
        window.scrollTo({
            top: targetPosition,
            behavior: 'smooth'
        });
    }
}

// Navbar functionality
function initNavbar() {
    const navbar = document.querySelector('.navbar');
    let lastScrollTop = 0;
    
    // Handle scroll effects
    window.addEventListener('scroll', function() {
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        
        // Add/remove scrolled class for styling
        if (scrollTop > 100) {
            navbar.classList.add('navbar--scrolled');
        } else {
            navbar.classList.remove('navbar--scrolled');
        }
        
        // Update active navigation link
        updateActiveNavLink();
        
        lastScrollTop = scrollTop;
    });
}

// Update active navigation link based on scroll position
function updateActiveNavLink() {
    const sections = document.querySelectorAll('section[id]');
    const navLinks = document.querySelectorAll('.navbar__link');
    const navbar = document.querySelector('.navbar');
    const navbarHeight = navbar ? navbar.offsetHeight : 0;
    
    let currentSection = '';
    
    sections.forEach(section => {
        const sectionTop = section.offsetTop - navbarHeight - 100;
        const sectionHeight = section.offsetHeight;
        const scrollPosition = window.pageYOffset;
        
        if (scrollPosition >= sectionTop && scrollPosition < sectionTop + sectionHeight) {
            currentSection = section.getAttribute('id');
        }
    });
    
    // Update active link
    navLinks.forEach(link => {
        link.classList.remove('navbar__link--active');
        if (link.getAttribute('href') === `#${currentSection}`) {
            link.classList.add('navbar__link--active');
        }
    });
}

// Animation functionality
function initAnimations() {
    // Intersection Observer for scroll animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-in');
                
                // Handle staggered animations for grids
                if (entry.target.classList.contains('journey-grid') ||
                    entry.target.classList.contains('achievements-grid') ||
                    entry.target.classList.contains('value-grid') ||
                    entry.target.classList.contains('methodology-grid') ||
                    entry.target.classList.contains('impact-grid') ||
                    entry.target.classList.contains('skills-grid')) {
                    animateGridItems(entry.target);
                }
                
                // Handle skill bar animations
                if (entry.target.classList.contains('skills-grid')) {
                    animateSkillBars();
                }
            }
        });
    }, observerOptions);
    
    // Observe elements for animation
    const animateElements = document.querySelectorAll('.section, .journey-grid, .achievements-grid, .value-grid, .methodology-grid, .impact-grid, .skills-grid, .metrics-grid');
    animateElements.forEach(el => observer.observe(el));
}

// Animate grid items with stagger effect
function animateGridItems(grid) {
    const items = grid.children;
    Array.from(items).forEach((item, index) => {
        setTimeout(() => {
            item.classList.add('animate-item');
        }, index * 100);
    });
}

// Animate skill bars
function animateSkillBars() {
    const skillBars = document.querySelectorAll('.skill-bar');
    skillBars.forEach((bar, index) => {
        setTimeout(() => {
            const width = bar.style.width;
            bar.style.width = '0%';
            setTimeout(() => {
                bar.style.width = width;
            }, 100);
        }, index * 200);
    });
}

// Form handling
function initFormHandling() {
    const contactForm = document.querySelector('.form');
    if (contactForm) {
        contactForm.addEventListener('submit', handleFormSubmit);
    }
}

// Handle contact form submission
function handleFormSubmit(e) {
    e.preventDefault();
    
    const form = e.target;
    const formData = new FormData(form);
    const submitButton = form.querySelector('button[type="submit"]');
    
    // Get form values
    const name = form.querySelector('#name').value.trim();
    const email = form.querySelector('#email').value.trim();
    const company = form.querySelector('#company')?.value.trim() || '';
    const message = form.querySelector('#message').value.trim();
    
    // Basic validation
    if (!name || !email || !message) {
        showNotification('Please fill in all required fields', 'error');
        return;
    }
    
    if (!isValidEmail(email)) {
        showNotification('Please enter a valid email address', 'error');
        return;
    }
    
    // Show loading state
    const originalText = submitButton.textContent;
    submitButton.textContent = 'Sending...';
    submitButton.disabled = true;
    form.classList.add('loading');
    
    // Simulate form submission (replace with actual API call)
    setTimeout(() => {
        // Reset form
        form.reset();
        submitButton.textContent = originalText;
        submitButton.disabled = false;
        form.classList.remove('loading');
        
        // Show success message
        showNotification('Thank you! Your message has been sent successfully. I\'ll get back to you soon.', 'success');
        
        // Track form submission (you can add analytics here)
        console.log('Form submitted:', { name, email, company, message });
    }, 2000);
}

// Email validation
function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

// Show notification
function showNotification(message, type = 'info') {
    // Remove existing notifications
    const existingNotifications = document.querySelectorAll('.notification');
    existingNotifications.forEach(notification => notification.remove());
    
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `notification notification--${type}`;
    notification.textContent = message;
    
    // Add styles for notification
    Object.assign(notification.style, {
        position: 'fixed',
        top: '20px',
        right: '20px',
        padding: '16px 24px',
        borderRadius: '8px',
        color: 'white',
        fontWeight: '500',
        zIndex: '9999',
        transform: 'translateX(100%)',
        transition: 'transform 0.3s ease-out',
        maxWidth: '400px',
        wordWrap: 'break-word',
        boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)'
    });
    
    // Set background color based on type
    switch (type) {
        case 'success':
            notification.style.backgroundColor = '#21804d';
            break;
        case 'error':
            notification.style.backgroundColor = '#c0152f';
            break;
        default:
            notification.style.backgroundColor = '#21808d';
    }
    
    // Add to DOM
    document.body.appendChild(notification);
    
    // Animate in
    setTimeout(() => {
        notification.style.transform = 'translateX(0)';
    }, 100);
    
    // Auto remove after 5 seconds
    setTimeout(() => {
        notification.style.transform = 'translateX(100%)';
        setTimeout(() => {
            if (notification.parentNode) {
                notification.parentNode.removeChild(notification);
            }
        }, 300);
    }, 5000);
}

// Interactive elements
function initInteractiveElements() {
    // Add click handlers for metric cards
    const metricCards = document.querySelectorAll('.metric-card');
    metricCards.forEach(card => {
        card.addEventListener('click', function() {
            animateMetricCard(this);
        });
    });
    
    // Add click handlers for achievement cards
    const achievementCards = document.querySelectorAll('.achievement-card');
    achievementCards.forEach(card => {
        card.addEventListener('click', function() {
            expandCard(this);
        });
    });
    
    // Add click handlers for journey cards
    const journeyCards = document.querySelectorAll('.journey-card');
    journeyCards.forEach(card => {
        card.addEventListener('click', function() {
            highlightJourneyCard(this);
        });
    });
    
    // Add click handlers for value cards
    const valueCards = document.querySelectorAll('.value-card');
    valueCards.forEach(card => {
        card.addEventListener('click', function() {
            pulseCard(this);
        });
    });
    
    // Add click handlers for methodology steps
    const methodologySteps = document.querySelectorAll('.methodology-step');
    methodologySteps.forEach(step => {
        step.addEventListener('click', function() {
            highlightMethodologyStep(this);
        });
    });
    
    // Add click handlers for impact cards
    const impactCards = document.querySelectorAll('.impact-card');
    impactCards.forEach(card => {
        card.addEventListener('click', function() {
            animateImpactCard(this);
        });
    });
    
    // Add parallax effect for hero background
    initParallaxEffect();
    
    // Add typing effect for hero tagline
    initTypingEffect();
}

// Animate metric card on click
function animateMetricCard(card) {
    card.style.transform = 'scale(1.05)';
    card.style.transition = 'transform 0.2s ease-out';
    setTimeout(() => {
        card.style.transform = '';
    }, 200);
}

// Expand achievement card with more details
function expandCard(card) {
    const isExpanded = card.classList.contains('expanded');
    
    // Reset all cards
    document.querySelectorAll('.achievement-card').forEach(c => {
        c.classList.remove('expanded');
        c.style.transform = '';
        const expandedContent = c.querySelector('.expanded-content');
        if (expandedContent) {
            expandedContent.remove();
        }
    });
    
    if (!isExpanded) {
        card.classList.add('expanded');
        card.style.transform = 'scale(1.02)';
        
        // Add expanded content
        const expandedContent = document.createElement('div');
        expandedContent.className = 'expanded-content';
        expandedContent.innerHTML = '<p style="margin-top: 16px; font-size: 14px; color: var(--color-primary); font-weight: 500;">✓ Click again to collapse</p>';
        card.appendChild(expandedContent);
    }
}

// Highlight journey card
function highlightJourneyCard(card) {
    // Remove highlight from all cards
    document.querySelectorAll('.journey-card').forEach(c => {
        c.classList.remove('highlighted');
    });
    
    // Add highlight to clicked card
    card.classList.add('highlighted');
    
    // Remove highlight after 3 seconds
    setTimeout(() => {
        card.classList.remove('highlighted');
    }, 3000);
}

// Pulse value card
function pulseCard(card) {
    card.style.animation = 'pulse 0.6s ease-in-out';
    setTimeout(() => {
        card.style.animation = '';
    }, 600);
}

// Highlight methodology step
function highlightMethodologyStep(step) {
    // Remove highlight from all steps
    document.querySelectorAll('.methodology-step').forEach(s => {
        s.style.borderColor = '';
        s.style.boxShadow = '';
    });
    
    // Highlight clicked step
    step.style.borderColor = 'var(--color-primary)';
    step.style.boxShadow = '0 0 20px rgba(33, 128, 141, 0.3)';
    
    // Remove highlight after 3 seconds
    setTimeout(() => {
        step.style.borderColor = '';
        step.style.boxShadow = '';
    }, 3000);
}

// Animate impact card
function animateImpactCard(card) {
    const metric = card.querySelector('.impact-card__metric');
    const originalText = metric.textContent;
    
    // Create counting animation
    if (originalText.includes('x') || originalText.includes('%')) {
        const number = parseInt(originalText);
        if (!isNaN(number)) {
            let current = 0;
            const increment = number / 20;
            const timer = setInterval(() => {
                current += increment;
                if (current >= number) {
                    current = number;
                    clearInterval(timer);
                }
                metric.textContent = Math.floor(current) + originalText.replace(number.toString(), '');
            }, 50);
        }
    }
}

// Parallax effect for hero section
function initParallaxEffect() {
    const hero = document.querySelector('.hero');
    if (!hero) return;
    
    window.addEventListener('scroll', function() {
        const scrolled = window.pageYOffset;
        const rate = scrolled * -0.3;
        if (scrolled < window.innerHeight) {
            hero.style.transform = `translateY(${rate}px)`;
        }
    });
}

// Typing effect for hero tagline
function initTypingEffect() {
    const tagline = document.querySelector('.hero__tagline');
    if (!tagline) return;
    
    const text = tagline.textContent;
    tagline.textContent = '';
    tagline.style.borderRight = '2px solid var(--color-primary)';
    tagline.style.minHeight = '1.2em';
    
    let i = 0;
    const typeTimer = setInterval(() => {
        if (i < text.length) {
            tagline.textContent += text.charAt(i);
            i++;
        } else {
            clearInterval(typeTimer);
            // Remove cursor after typing is complete
            setTimeout(() => {
                tagline.style.borderRight = 'none';
            }, 1000);
        }
    }, 50);
}

// Utility function to debounce scroll events
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// Performance optimized scroll handler
const optimizedScrollHandler = debounce(function() {
    updateActiveNavLink();
}, 10);

// Add optimized scroll listener
window.addEventListener('scroll', optimizedScrollHandler);

// Handle page visibility changes
document.addEventListener('visibilitychange', function() {
    if (document.visibilityState === 'visible') {
        // Page is visible again, refresh any time-sensitive content
        console.log('Page is now visible');
    }
});

// Handle window resize
window.addEventListener('resize', debounce(function() {
    // Handle any responsive adjustments
    console.log('Window resized');
}, 250));

// Add custom CSS for dynamic animations
const style = document.createElement('style');
style.textContent = `
    .animate-in {
        animation: fadeInUp 0.8s ease-out forwards;
    }
    
    .animate-item {
        animation: fadeInUp 0.6s ease-out forwards;
        opacity: 0;
        animation-fill-mode: forwards;
    }
    
    .journey-card.highlighted {
        border-color: var(--color-primary);
        box-shadow: 0 0 20px rgba(33, 128, 141, 0.3);
        transform: translateY(-4px);
    }
    
    .achievement-card.expanded {
        border-color: var(--color-primary);
    }
    
    .expanded-content {
        animation: fadeIn 0.3s ease-out forwards;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    @keyframes pulse {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.05); }
    }
    
    .navbar--scrolled {
        background: rgba(255, 255, 255, 0.98);
        box-shadow: var(--shadow-sm);
    }
    
    .navbar__link--active {
        color: var(--color-primary);
    }
    
    .navbar__link--active::after {
        transform: scaleX(1);
    }
    
    /* Staggered animation delays */
    .animate-item:nth-child(1) { animation-delay: 0.1s; }
    .animate-item:nth-child(2) { animation-delay: 0.2s; }
    .animate-item:nth-child(3) { animation-delay: 0.3s; }
    .animate-item:nth-child(4) { animation-delay: 0.4s; }
    .animate-item:nth-child(5) { animation-delay: 0.5s; }
    .animate-item:nth-child(6) { animation-delay: 0.6s; }
    
    /* Loading state for forms */
    .loading {
        opacity: 0.7;
        pointer-events: none;
    }
    
    .loading button {
        background: var(--color-text-secondary) !important;
        cursor: not-allowed !important;
    }
    
    /* Hover effects for interactive elements */
    .metric-card:hover,
    .journey-card:hover,
    .achievement-card:hover,
    .value-card:hover,
    .methodology-step:hover,
    .impact-card:hover {
        cursor: pointer;
    }
    
    /* Focus states for accessibility */
    .metric-card:focus,
    .journey-card:focus,
    .achievement-card:focus,
    .value-card:focus,
    .methodology-step:focus,
    .impact-card:focus {
        outline: 2px solid var(--color-primary);
        outline-offset: 2px;
    }
    
    @media (prefers-color-scheme: dark) {
        .navbar--scrolled {
            background: rgba(38, 40, 40, 0.98);
        }
    }
    
    /* Reduced motion preferences */
    @media (prefers-reduced-motion: reduce) {
        .animate-in,
        .animate-item,
        .skill-bar,
        * {
            animation-duration: 0.01ms !important;
            animation-iteration-count: 1 !important;
            transition-duration: 0.01ms !important;
        }
    }
`;

document.head.appendChild(style);

// Initialize keyboard navigation
document.addEventListener('keydown', function(e) {
    // Handle Enter key on interactive elements
    if (e.key === 'Enter') {
        const focused = document.activeElement;
        if (focused.classList.contains('metric-card')) {
            animateMetricCard(focused);
        } else if (focused.classList.contains('achievement-card')) {
            expandCard(focused);
        } else if (focused.classList.contains('journey-card')) {
            highlightJourneyCard(focused);
        } else if (focused.classList.contains('value-card')) {
            pulseCard(focused);
        } else if (focused.classList.contains('methodology-step')) {
            highlightMethodologyStep(focused);
        } else if (focused.classList.contains('impact-card')) {
            animateImpactCard(focused);
        }
    }
});

// Add tabindex to interactive elements for keyboard navigation
document.addEventListener('DOMContentLoaded', function() {
    const interactiveElements = document.querySelectorAll('.metric-card, .journey-card, .achievement-card, .value-card, .methodology-step, .impact-card');
    interactiveElements.forEach(element => {
        element.setAttribute('tabindex', '0');
        element.setAttribute('role', 'button');
        element.setAttribute('aria-label', 'Interactive element - press Enter to activate');
    });
});

// Analytics tracking (placeholder - replace with your analytics service)
function trackEvent(eventName, properties = {}) {
    console.log('Analytics Event:', eventName, properties);
    // Example: gtag('event', eventName, properties);
    // Example: analytics.track(eventName, properties);
}

// Track page interactions
document.addEventListener('click', function(e) {
    const target = e.target.closest('[data-track]');
    if (target) {
        const eventName = target.getAttribute('data-track');
        trackEvent(eventName, {
            element: target.tagName,
            text: target.textContent.trim()
        });
    }
});

// Add tracking attributes to key elements
document.addEventListener('DOMContentLoaded', function() {
    // Add tracking to CTA buttons
    const ctaButtons = document.querySelectorAll('.hero__actions .btn');
    ctaButtons.forEach((btn, index) => {
        btn.setAttribute('data-track', `hero_cta_${index === 0 ? 'primary' : 'secondary'}`);
    });
    
    // Add tracking to contact actions
    const contactButtons = document.querySelectorAll('.contact-actions .btn');
    contactButtons.forEach((btn, index) => {
        btn.setAttribute('data-track', `contact_${index === 0 ? 'linkedin' : 'email'}`);
    });
});

console.log('AI Innovation Portfolio loaded successfully! 🚀');