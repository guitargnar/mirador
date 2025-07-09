class PresentationController {
    constructor() {
        this.currentSlide = 1;
        this.totalSlides = 9;
        this.isAutoPlaying = false;
        this.autoPlayInterval = null;
        this.autoPlayDelay = 8000; // 8 seconds per slide
        
        this.init();
    }
    
    init() {
        this.bindEvents();
        this.updateUI();
        this.handleInitialHash();
    }
    
    bindEvents() {
        // Navigation buttons
        document.getElementById('prev-btn').addEventListener('click', () => this.previousSlide());
        document.getElementById('next-btn').addEventListener('click', () => this.nextSlide());
        
        // Auto-play button
        document.getElementById('auto-play-btn').addEventListener('click', () => this.toggleAutoPlay());
        
        // Keyboard navigation
        document.addEventListener('keydown', (e) => this.handleKeydown(e));
        
        // Touch/swipe support
        this.bindTouchEvents();
        
        // Contact buttons
        this.bindContactButtons();
        
        // Window resize for responsive adjustments
        window.addEventListener('resize', () => this.handleResize());
        
        // Hash change for direct slide access
        window.addEventListener('hashchange', () => this.handleHashChange());
    }
    
    bindTouchEvents() {
        let startX = 0;
        let startY = 0;
        let threshold = 50; // Minimum distance for swipe
        
        document.addEventListener('touchstart', (e) => {
            startX = e.touches[0].clientX;
            startY = e.touches[0].clientY;
        }, { passive: true });
        
        document.addEventListener('touchend', (e) => {
            if (!startX || !startY) return;
            
            const endX = e.changedTouches[0].clientX;
            const endY = e.changedTouches[0].clientY;
            
            const diffX = startX - endX;
            const diffY = startY - endY;
            
            // Only handle horizontal swipes
            if (Math.abs(diffX) > Math.abs(diffY) && Math.abs(diffX) > threshold) {
                if (diffX > 0) {
                    this.nextSlide();
                } else {
                    this.previousSlide();
                }
            }
            
            startX = 0;
            startY = 0;
        }, { passive: true });
    }
    
    bindContactButtons() {
        const contactButtons = document.querySelectorAll('.contact-btn');
        contactButtons.forEach(button => {
            button.addEventListener('click', (e) => {
                const buttonText = button.textContent.trim();
                this.handleContactAction(buttonText);
            });
        });
    }
    
    handleContactAction(action) {
        if (action.includes('LinkedIn')) {
            // In a real implementation, this would open LinkedIn
            this.showNotification('LinkedIn profile would open in a new tab');
        } else if (action.includes('Implement')) {
            // In a real implementation, this would open email client
            this.showNotification('Email client would open for contact');
        } else if (action.includes('GitHub')) {
            // In a real implementation, this would open GitHub
            this.showNotification('GitHub repository would open in a new tab');
        }
    }
    
    showNotification(message) {
        // Create a simple notification
        const notification = document.createElement('div');
        notification.className = 'notification';
        notification.textContent = message;
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(50, 184, 198, 0.9);
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            z-index: 10000;
            font-size: 14px;
            backdrop-filter: blur(10px);
            animation: slideDown 0.3s ease;
        `;
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            notification.style.animation = 'slideUp 0.3s ease forwards';
            setTimeout(() => {
                document.body.removeChild(notification);
            }, 300);
        }, 3000);
    }
    
    handleKeydown(e) {
        switch(e.key) {
            case 'ArrowRight':
            case ' ':
                e.preventDefault();
                this.nextSlide();
                break;
            case 'ArrowLeft':
                e.preventDefault();
                this.previousSlide();
                break;
            case 'Home':
                e.preventDefault();
                this.goToSlide(1);
                break;
            case 'End':
                e.preventDefault();
                this.goToSlide(this.totalSlides);
                break;
            case 'Escape':
                e.preventDefault();
                if (this.isAutoPlaying) {
                    this.stopAutoPlay();
                }
                break;
        }
    }
    
    handleInitialHash() {
        const hash = window.location.hash;
        if (hash) {
            const slideNumber = parseInt(hash.replace('#slide-', ''));
            if (slideNumber >= 1 && slideNumber <= this.totalSlides) {
                this.goToSlide(slideNumber);
            }
        }
    }
    
    handleHashChange() {
        const hash = window.location.hash;
        if (hash) {
            const slideNumber = parseInt(hash.replace('#slide-', ''));
            if (slideNumber >= 1 && slideNumber <= this.totalSlides && slideNumber !== this.currentSlide) {
                this.goToSlide(slideNumber);
            }
        }
    }
    
    handleResize() {
        // Handle any responsive adjustments if needed
        this.updateUI();
    }
    
    nextSlide() {
        if (this.currentSlide < this.totalSlides) {
            this.goToSlide(this.currentSlide + 1);
        }
    }
    
    previousSlide() {
        if (this.currentSlide > 1) {
            this.goToSlide(this.currentSlide - 1);
        }
    }
    
    goToSlide(slideNumber) {
        if (slideNumber < 1 || slideNumber > this.totalSlides || slideNumber === this.currentSlide) {
            return;
        }
        
        const currentSlideElement = document.getElementById(`slide-${this.currentSlide}`);
        const targetSlideElement = document.getElementById(`slide-${slideNumber}`);
        
        // Determine slide direction for animation
        const isNext = slideNumber > this.currentSlide;
        
        // Remove active class from current slide
        currentSlideElement.classList.remove('active');
        
        // Add appropriate transition classes
        if (isNext) {
            currentSlideElement.classList.add('prev');
            targetSlideElement.classList.remove('prev');
            targetSlideElement.classList.add('slide-in-right');
        } else {
            currentSlideElement.classList.remove('prev');
            targetSlideElement.classList.add('slide-in-left');
        }
        
        // Activate target slide
        setTimeout(() => {
            targetSlideElement.classList.add('active');
            targetSlideElement.classList.remove('slide-in-right', 'slide-in-left');
        }, 50);
        
        this.currentSlide = slideNumber;
        this.updateUI();
        this.updateHash();
    }
    
    updateUI() {
        // Update slide counter
        document.getElementById('current-slide').textContent = this.currentSlide;
        document.getElementById('total-slides').textContent = this.totalSlides;
        
        // Update progress bar
        const progressPercentage = (this.currentSlide / this.totalSlides) * 100;
        document.getElementById('progress-fill').style.width = `${progressPercentage}%`;
        
        // Update navigation buttons
        const prevBtn = document.getElementById('prev-btn');
        const nextBtn = document.getElementById('next-btn');
        
        prevBtn.disabled = this.currentSlide === 1;
        nextBtn.disabled = this.currentSlide === this.totalSlides;
        
        // Update auto-play button
        const autoPlayBtn = document.getElementById('auto-play-btn');
        if (this.isAutoPlaying) {
            autoPlayBtn.classList.add('playing');
            autoPlayBtn.innerHTML = '<i class="fas fa-pause"></i>';
        } else {
            autoPlayBtn.classList.remove('playing');
            autoPlayBtn.innerHTML = '<i class="fas fa-play"></i>';
        }
    }
    
    updateHash() {
        history.replaceState(null, null, `#slide-${this.currentSlide}`);
    }
    
    toggleAutoPlay() {
        if (this.isAutoPlaying) {
            this.stopAutoPlay();
        } else {
            this.startAutoPlay();
        }
    }
    
    startAutoPlay() {
        this.isAutoPlaying = true;
        this.autoPlayInterval = setInterval(() => {
            if (this.currentSlide < this.totalSlides) {
                this.nextSlide();
            } else {
                // Loop back to first slide or stop
                this.goToSlide(1);
            }
        }, this.autoPlayDelay);
        this.updateUI();
    }
    
    stopAutoPlay() {
        this.isAutoPlaying = false;
        if (this.autoPlayInterval) {
            clearInterval(this.autoPlayInterval);
            this.autoPlayInterval = null;
        }
        this.updateUI();
    }
    
    // Public methods for external control
    getCurrentSlide() {
        return this.currentSlide;
    }
    
    getTotalSlides() {
        return this.totalSlides;
    }
    
    isPlaying() {
        return this.isAutoPlaying;
    }
}

// Utility functions for enhanced user experience
class PresentationUtils {
    static addAnimationStyles() {
        const styles = `
            @keyframes slideDown {
                from {
                    transform: translate(-50%, -100%);
                    opacity: 0;
                }
                to {
                    transform: translate(-50%, 0);
                    opacity: 1;
                }
            }
            
            @keyframes slideUp {
                from {
                    transform: translate(-50%, 0);
                    opacity: 1;
                }
                to {
                    transform: translate(-50%, -100%);
                    opacity: 0;
                }
            }
            
            .notification {
                animation: slideDown 0.3s ease;
            }
        `;
        
        const styleSheet = document.createElement('style');
        styleSheet.textContent = styles;
        document.head.appendChild(styleSheet);
    }
    
    static preloadImages() {
        const images = [
            'https://pplx-res.cloudinary.com/image/upload/v1750547652/pplx_project_search_images/e7ee4ba35c90051dbb88873e8eb7a1f5c26fafcb.jpg'
        ];
        
        images.forEach(src => {
            const img = new Image();
            img.src = src;
        });
    }
    
    static addKeyboardHelp() {
        let helpVisible = false;
        
        document.addEventListener('keydown', (e) => {
            if (e.key === '?' || e.key === 'h') {
                e.preventDefault();
                if (helpVisible) {
                    PresentationUtils.hideKeyboardHelp();
                } else {
                    PresentationUtils.showKeyboardHelp();
                }
                helpVisible = !helpVisible;
            } else if (e.key === 'Escape' && helpVisible) {
                PresentationUtils.hideKeyboardHelp();
                helpVisible = false;
            }
        });
    }
    
    static showKeyboardHelp() {
        const helpOverlay = document.createElement('div');
        helpOverlay.id = 'keyboard-help';
        helpOverlay.style.cssText = `
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10000;
            backdrop-filter: blur(5px);
        `;
        
        const helpContent = document.createElement('div');
        helpContent.style.cssText = `
            background: rgba(26, 35, 50, 0.95);
            padding: 32px;
            border-radius: 16px;
            border: 1px solid rgba(50, 184, 198, 0.3);
            color: white;
            max-width: 500px;
            backdrop-filter: blur(10px);
        `;
        
        helpContent.innerHTML = `
            <h3 style="color: #32b8c6; margin-bottom: 20px; text-align: center;">Keyboard Shortcuts</h3>
            <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 12px; font-size: 14px;">
                <strong>→ / Space</strong><span>Next slide</span>
                <strong>←</strong><span>Previous slide</span>
                <strong>Home</strong><span>First slide</span>
                <strong>End</strong><span>Last slide</span>
                <strong>Escape</strong><span>Stop auto-play</span>
                <strong>? / H</strong><span>Toggle this help</span>
            </div>
            <p style="text-align: center; margin-top: 20px; color: #a0aec0; font-size: 12px;">
                Click anywhere or press Escape to close
            </p>
        `;
        
        helpOverlay.appendChild(helpContent);
        document.body.appendChild(helpOverlay);
        
        helpOverlay.addEventListener('click', () => {
            PresentationUtils.hideKeyboardHelp();
        });
    }
    
    static hideKeyboardHelp() {
        const helpOverlay = document.getElementById('keyboard-help');
        if (helpOverlay) {
            document.body.removeChild(helpOverlay);
        }
    }
}

// Initialize presentation when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    // Add utility styles and features
    PresentationUtils.addAnimationStyles();
    PresentationUtils.preloadImages();
    PresentationUtils.addKeyboardHelp();
    
    // Initialize the main presentation controller
    window.presentation = new PresentationController();
    
    // Add loading fade-in effect
    document.body.style.opacity = '0';
    document.body.style.transition = 'opacity 0.5s ease';
    
    setTimeout(() => {
        document.body.style.opacity = '1';
    }, 100);
    
    // Performance optimization: Lazy load content
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('loaded');
            }
        });
    });
    
    document.querySelectorAll('.slide').forEach(slide => {
        observer.observe(slide);
    });
});

// Prevent context menu on right-click to avoid distractions
document.addEventListener('contextmenu', (e) => {
    e.preventDefault();
});

// Handle visibility change to pause auto-play when tab is not active
document.addEventListener('visibilitychange', () => {
    if (window.presentation && window.presentation.isPlaying()) {
        if (document.hidden) {
            window.presentation.stopAutoPlay();
        }
    }
});

// Export for external access if needed
window.PresentationController = PresentationController;
window.PresentationUtils = PresentationUtils;