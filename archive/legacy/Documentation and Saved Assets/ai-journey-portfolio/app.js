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
        const sectionTop = section.offsetTop - navbarHeight - 50;
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
                    entry.target.classList.contains('impact-grid')) {
                    animateGridItems(entry.target);
                }
            }
        });
    }, observerOptions);
    
    // Observe elements for animation
    const animateElements = document.querySelectorAll('.section, .journey-grid, .achievements-grid, .value-grid, .methodology-grid, .impact-grid, .metrics-grid');
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
    const message = form.querySelector('#message').value.trim();
    
    // Basic validation
    if (!name || !email || !message) {
        showNotification('Please fill in all fields', 'error');
        return;
    }
    
    if (!isValidEmail(email)) {
        showNotification('Please enter a valid email address', 'error');
        return;
    }
    
    // Show loading state
    submitButton.textContent = 'Sending...';
    submitButton.disabled = true;
    form.classList.add('loading');
    
    // Simulate form submission (replace with actual API call)
    setTimeout(() => {
        // Reset form
        form.reset();
        submitButton.textContent = 'Send Message';
        submitButton.disabled = false;
        form.classList.remove('loading');
        
        // Show success message
        showNotification('Thank you! Your message has been sent successfully.', 'success');
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
        wordWrap: 'break-word'
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
    
    // Add parallax effect for hero background
    initParallaxEffect();
    
    // Add typing effect for hero tagline
    initTypingEffect();
}

// Animate metric card on click
function animateMetricCard(card) {
    card.style.transform = 'scale(1.05)';
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
    });
    
    if (!isExpanded) {
        card.classList.add('expanded');
        card.style.transform = 'scale(1.02)';
        
        // Add expanded content if not exists
        if (!card.querySelector('.expanded-content')) {
            const expandedContent = document.createElement('div');
            expandedContent.className = 'expanded-content';
            expandedContent.innerHTML = '<p style="margin-top: 16px; font-size: 14px; color: var(--color-text-secondary);">Click to collapse</p>';
            card.appendChild(expandedContent);
        }
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

// Parallax effect for hero section
function initParallaxEffect() {
    const hero = document.querySelector('.hero');
    if (!hero) return;
    
    window.addEventListener('scroll', function() {
        const scrolled = window.pageYOffset;
        const rate = scrolled * -0.5;
        hero.style.transform = `translateY(${rate}px)`;
    });
}

// Typing effect for hero tagline
function initTypingEffect() {
    const tagline = document.querySelector('.hero__tagline');
    if (!tagline) return;
    
    const text = tagline.textContent;
    tagline.textContent = '';
    tagline.style.borderRight = '2px solid var(--color-primary)';
    
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
    }
    
    .journey-card.highlighted {
        border-color: var(--color-primary);
        box-shadow: 0 0 20px rgba(33, 128, 141, 0.3);
    }
    
    .achievement-card.expanded {
        border-color: var(--color-primary);
    }
    
    .expanded-content {
        animation: fadeIn 0.3s ease-out forwards;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
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
    
    @media (prefers-color-scheme: dark) {
        .navbar--scrolled {
            background: rgba(38, 40, 40, 0.98);
        }
    }
`;

document.head.appendChild(style);