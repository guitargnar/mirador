// Demo data for AI responses
const demoData = {
  financial: {
    question: "Should I use my home equity for real estate investment?",
    generic: "Real estate can be a good investment. Consider your risk tolerance and market conditions before making decisions.",
    personal: "Given your $91k home equity and $1,650 take-home pay due to 401k loans, I'd recommend paying off those loans first. They're costing you monthly cash flow that limits your investment options. Once cleared, your take-home increases significantly, giving you more flexibility for real estate ventures in Louisville's affordable market."
  },
  career: {
    question: "How should I transition from risk management to AI?",
    generic: "Consider taking courses in AI and machine learning. Build a portfolio and network with professionals in the field.",
    personal: "Your 10+ years in risk management at Humana gives you unique domain expertise. Instead of starting over, position yourself as an AI-for-compliance specialist. Your recent 8-week project building 89 AI models proves rapid learning ability. Target roles that need both regulatory knowledge AND AI implementation skills—you're uniquely qualified for this intersection."
  },
  technical: {
    question: "What's my next technical learning priority?",
    generic: "Focus on popular technologies like cloud platforms, frameworks, and programming languages based on job market demand.",
    personal: "You've mastered local LLM deployment and Python automation. Next, focus on enterprise-grade orchestration—Kubernetes for model scaling, API development for business integration, and monitoring systems. These bridge your proven local AI capability to enterprise readiness, making you invaluable for organizations wanting AI without vendor lock-in."
  }
};

// Smooth scrolling function
function scrollToSection(sectionId) {
  const element = document.getElementById(sectionId);
  if (element) {
    element.scrollIntoView({ 
      behavior: 'smooth',
      block: 'start'
    });
  }
}

// Demo functionality
function initializeDemo() {
  const personaBtns = document.querySelectorAll('.persona-btn');
  const questionElement = document.getElementById('current-question');
  const genericResponse = document.getElementById('generic-response');
  const personalResponse = document.getElementById('personal-response');

  // Add click event listeners to persona buttons
  personaBtns.forEach(btn => {
    btn.addEventListener('click', function() {
      // Remove active class from all buttons
      personaBtns.forEach(b => b.classList.remove('active'));
      
      // Add active class to clicked button
      this.classList.add('active');
      
      // Get the persona type
      const persona = this.dataset.persona;
      
      // Update the demo content
      updateDemoContent(persona, questionElement, genericResponse, personalResponse);
    });
  });
}

// Update demo content based on selected persona
function updateDemoContent(persona, questionEl, genericEl, personalEl) {
  const data = demoData[persona];
  
  if (data) {
    // Add fade out effect
    questionEl.style.opacity = '0.5';
    genericEl.style.opacity = '0.5';
    personalEl.style.opacity = '0.5';
    
    // Update content after brief delay for smooth transition
    setTimeout(() => {
      questionEl.textContent = data.question;
      genericEl.textContent = data.generic;
      personalEl.textContent = data.personal;
      
      // Fade back in
      questionEl.style.opacity = '1';
      genericEl.style.opacity = '1';
      personalEl.style.opacity = '1';
    }, 200);
  }
}

// Intersection Observer for animations
function initializeAnimations() {
  const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
  };

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.style.opacity = '1';
        entry.target.style.transform = 'translateY(0)';
      }
    });
  }, observerOptions);

  // Observe elements that should animate on scroll
  const animatedElements = document.querySelectorAll('.metric-card, .tech-card, .value-card, .timeline-item, .contact-card');
  
  animatedElements.forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(20px)';
    el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    observer.observe(el);
  });
}

// Initialize scroll progress indicator
function initializeScrollProgress() {
  const progressBar = document.createElement('div');
  progressBar.style.cssText = `
    position: fixed;
    top: 0;
    left: 0;
    width: 0%;
    height: 3px;
    background: var(--color-primary);
    z-index: 1000;
    transition: width 0.3s ease;
  `;
  document.body.appendChild(progressBar);

  window.addEventListener('scroll', () => {
    const scrollTop = window.pageYOffset;
    const docHeight = document.body.offsetHeight - window.innerHeight;
    const scrollPercent = (scrollTop / docHeight) * 100;
    progressBar.style.width = scrollPercent + '%';
  });
}

// Add typing effect to hero tagline
function initializeTypingEffect() {
  const tagline = document.querySelector('.hero__tagline');
  if (tagline) {
    const originalText = tagline.textContent;
    tagline.textContent = '';
    
    let i = 0;
    const typeSpeed = 50;
    
    function typeWriter() {
      if (i < originalText.length) {
        tagline.textContent += originalText.charAt(i);
        i++;
        setTimeout(typeWriter, typeSpeed);
      }
    }
    
    // Start typing effect after a brief delay
    setTimeout(typeWriter, 1000);
  }
}

// Add hover effects to metric cards
function initializeMetricCards() {
  const metricCards = document.querySelectorAll('.metric-card');
  
  metricCards.forEach(card => {
    card.addEventListener('mouseenter', function() {
      this.style.transform = 'translateY(-5px) scale(1.05)';
      this.style.boxShadow = '0 10px 25px rgba(33, 128, 141, 0.3)';
    });
    
    card.addEventListener('mouseleave', function() {
      this.style.transform = 'translateY(0) scale(1)';
      this.style.boxShadow = 'none';
    });
  });
}

// Add click tracking for analytics (placeholder)
function initializeAnalytics() {
  // Track button clicks
  const buttons = document.querySelectorAll('.btn');
  buttons.forEach(btn => {
    btn.addEventListener('click', function() {
      const action = this.textContent.trim();
      const section = this.closest('section')?.className || 'unknown';
      
      // In a real implementation, you would send this data to your analytics service
      console.log(`Button clicked: ${action} in ${section}`);
    });
  });
  
  // Track persona selections
  const personaBtns = document.querySelectorAll('.persona-btn');
  personaBtns.forEach(btn => {
    btn.addEventListener('click', function() {
      const persona = this.dataset.persona;
      console.log(`Persona selected: ${persona}`);
    });
  });
}

// Add loading state to email links
function initializeEmailLinks() {
  const emailLinks = document.querySelectorAll('a[href^="mailto:"]');
  
  emailLinks.forEach(link => {
    link.addEventListener('click', function() {
      const originalText = this.textContent;
      this.textContent = 'Opening email client...';
      this.style.opacity = '0.7';
      
      // Reset after 2 seconds
      setTimeout(() => {
        this.textContent = originalText;
        this.style.opacity = '1';
      }, 2000);
    });
  });
}

// Initialize all functionality when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
  // Initialize core functionality
  initializeDemo();
  initializeAnimations();
  initializeScrollProgress();
  initializeTypingEffect();
  initializeMetricCards();
  initializeAnalytics();
  initializeEmailLinks();
  
  // Add smooth CSS transitions
  document.body.style.cssText += `
    transition: opacity 0.3s ease;
  `;
  
  // Ensure page is visible
  document.body.style.opacity = '1';
});

// Handle window resize for responsive adjustments
window.addEventListener('resize', function() {
  // Recalculate any layout-dependent animations
  const timelineItems = document.querySelectorAll('.timeline-item');
  timelineItems.forEach(item => {
    // Reset any transforms that might be affected by screen size changes
    if (window.innerWidth <= 768) {
      item.style.transform = 'none';
    }
  });
});

// Preload images for better performance
function preloadImages() {
  const images = [
    'https://pplx-res.cloudinary.com/image/upload/v1748565481/pplx_project_search_images/090688eda458bb0f2cd35a4f966bec4c9d709f94.jpg',
    'https://pplx-res.cloudinary.com/image/upload/v1750547652/pplx_project_search_images/e7ee4ba35c90051dbb88873e8eb7a1f5c26fafcb.jpg'
  ];
  
  images.forEach(src => {
    const img = new Image();
    img.src = src;
  });
}

// Initialize image preloading
preloadImages();

// Export functions for testing or external use
window.portfolioApp = {
  scrollToSection,
  updateDemoContent,
  demoData
};