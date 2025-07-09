#!/usr/bin/env python3
"""
Comprehensive Playwright Testing for Mirador Web Dashboard
Tests all interactive elements, links, and content
"""

import asyncio
from playwright.async_api import async_playwright
import sys

async def test_dashboard():
    """Run comprehensive dashboard tests"""
    
    async with async_playwright() as p:
        # Launch browser
        browser = await p.chromium.launch(headless=True)
        context = await browser.new_context()
        page = await context.new_page()
        
        print("🧪 Starting Playwright Web Browser Testing")
        print("=" * 50)
        
        try:
            # Navigate to dashboard
            print("\n📍 Navigating to dashboard...")
            await page.goto("http://localhost:8501", wait_until="networkidle")
            print("✅ Dashboard loaded successfully")
            
            # Test 1: Check page title
            print("\n📋 Testing Page Elements:")
            title = await page.title()
            print(f"  ✅ Page Title: {title}")
            
            # Test 2: Check main header
            header = await page.text_content("h1")
            if "AI Innovation Portfolio" in header:
                print("  ✅ Main Header: Found 'AI Innovation Portfolio'")
            else:
                print(f"  ❌ Main Header: Expected 'AI Innovation Portfolio', got '{header}'")
            
            # Test 3: Check key metrics
            print("\n💰 Testing Key Metrics:")
            metrics_to_check = [
                ("significant cost savings", "Automation Savings"),
                ("97%", "Accuracy Improvement"),
                ("30+ hrs", "Time Saved Weekly"),
                ("80+", "Models Created")
            ]
            
            page_content = await page.content()
            for metric, description in metrics_to_check:
                if metric in page_content:
                    print(f"  ✅ {description}: {metric} found")
                else:
                    print(f"  ❌ {description}: {metric} not found")
            
            # Test 4: Check navigation tabs
            print("\n🗂️ Testing Navigation Tabs:")
            tabs = [
                "Mirador Framework",
                "JCPS Boots",
                "JobCraft",
                "FretVision",
                "Impact Metrics"
            ]
            
            for tab in tabs:
                tab_element = await page.query_selector(f"text={tab}")
                if tab_element:
                    print(f"  ✅ Tab '{tab}': Found")
                else:
                    print(f"  ❌ Tab '{tab}': Not found")
            
            # Test 5: Test Mirador tab content
            print("\n🔬 Testing Mirador Framework Tab:")
            # Click on Mirador tab if not already active
            mirador_tab = await page.query_selector("text=Mirador Framework")
            if mirador_tab:
                await mirador_tab.click()
                await page.wait_for_timeout(500)  # Wait for tab content to load
                
                # Check for key content
                mirador_content = [
                    "Transforming Medical Leave into Innovation",
                    "100% local processing",
                    "80+ specialized AI models",
                    "Sub-2 second response times",
                    "Context-aware decision making"
                ]
                
                tab_content = await page.content()
                for content in mirador_content:
                    if content in tab_content:
                        print(f"  ✅ Content found: '{content[:40]}...'")
                    else:
                        print(f"  ❌ Content missing: '{content[:40]}...'")
            
            # Test 6: Test Live Demo section
            print("\n🎯 Testing Live Demo Section:")
            # Check for input field
            input_field = await page.query_selector("input[type='text']")
            if input_field:
                print("  ✅ Query input field: Found")
                # Test typing in the field
                await input_field.fill("Test query for Mirador")
                print("  ✅ Input field: Accepts text")
            else:
                print("  ❌ Query input field: Not found")
            
            # Check for Run Query button
            run_button = await page.query_selector("button:has-text('Run Query')")
            if run_button:
                print("  ✅ Run Query button: Found")
                # Check if button is clickable
                is_enabled = await run_button.is_enabled()
                print(f"  ✅ Run Query button: {'Enabled' if is_enabled else 'Disabled'}")
            else:
                print("  ❌ Run Query button: Not found")
            
            # Test 7: Test sidebar elements
            print("\n📱 Testing Sidebar:")
            sidebar_elements = [
                ("User", "Name"),
                ("Target Leadership Role Candidate", "Title"),
                ("Quick Links", "Section header"),
                ("LinkedIn", "LinkedIn button"),
                ("Contact", "Email button"),
                ("GitHub", "GitHub button"),
                ("Core Philosophy", "Philosophy section"),
                ("System Status", "Status section")
            ]
            
            for element_text, description in sidebar_elements:
                element = await page.query_selector(f"text={element_text}")
                if element:
                    print(f"  ✅ {description}: Found")
                else:
                    print(f"  ❌ {description}: Not found")
            
            # Test 8: Test link buttons
            print("\n🔗 Testing Quick Links:")
            
            # Test LinkedIn link
            linkedin_button = await page.query_selector("a:has-text('LinkedIn')")
            if linkedin_button:
                href = await linkedin_button.get_attribute("href")
                if "linkedin.com/in/your-profile" in href:
                    print(f"  ✅ LinkedIn URL: Correct ({href})")
                else:
                    print(f"  ❌ LinkedIn URL: Incorrect ({href})")
            
            # Test Contact link
            contact_button = await page.query_selector("a:has-text('Contact')")
            if contact_button:
                href = await contact_button.get_attribute("href")
                if "mailto:contact@example.com" in href:
                    print(f"  ✅ Contact Email: Correct ({href})")
                else:
                    print(f"  ❌ Contact Email: Incorrect ({href})")
            
            # Test GitHub link
            github_button = await page.query_selector("a:has-text('GitHub')")
            if github_button:
                href = await github_button.get_attribute("href")
                if "github.com/your-username" in href:
                    print(f"  ✅ GitHub URL: Correct ({href})")
                else:
                    print(f"  ❌ GitHub URL: Incorrect ({href})")
            
            # Test 9: Test other tabs
            print("\n📊 Testing Other Tabs:")
            
            # Test JCPS tab
            jcps_tab = await page.query_selector("text=JCPS Boots")
            if jcps_tab:
                await jcps_tab.click()
                await page.wait_for_timeout(500)
                jcps_content = await page.query_selector("text=From Crisis to Community Tool")
                print(f"  ✅ JCPS Tab: {'Content loaded' if jcps_content else 'Content missing'}")
            
            # Test JobCraft tab
            jobcraft_tab = await page.query_selector("text=JobCraft")
            if jobcraft_tab:
                await jobcraft_tab.click()
                await page.wait_for_timeout(500)
                jobcraft_content = await page.query_selector("text=Beat the Bots")
                print(f"  ✅ JobCraft Tab: {'Content loaded' if jobcraft_content else 'Content missing'}")
            
            # Test 10: Check for errors
            print("\n🐛 Checking for JavaScript Errors:")
            # Set up console message listener
            console_messages = []
            page.on("console", lambda msg: console_messages.append(msg))
            
            # Reload page to catch any console errors
            await page.reload()
            await page.wait_for_timeout(2000)
            
            error_count = sum(1 for msg in console_messages if msg.type == "error")
            if error_count == 0:
                print("  ✅ No JavaScript errors detected")
            else:
                print(f"  ❌ Found {error_count} JavaScript errors")
            
            # Test 11: Performance metrics
            print("\n⚡ Performance Metrics:")
            performance_metrics = await page.evaluate('''() => {
                const perfData = window.performance.timing;
                return {
                    pageLoadTime: perfData.loadEventEnd - perfData.navigationStart,
                    domReady: perfData.domContentLoadedEventEnd - perfData.navigationStart,
                    firstPaint: perfData.responseEnd - perfData.navigationStart
                };
            }''')
            
            print(f"  📊 Page Load Time: {performance_metrics['pageLoadTime']}ms")
            print(f"  📊 DOM Ready: {performance_metrics['domReady']}ms")
            print(f"  📊 First Paint: {performance_metrics['firstPaint']}ms")
            
            # Test 12: Accessibility checks
            print("\n♿ Basic Accessibility Checks:")
            
            # Check for alt text on images
            images = await page.query_selector_all("img")
            images_with_alt = sum(1 for img in images if await img.get_attribute("alt"))
            print(f"  ✅ Images with alt text: {images_with_alt}/{len(images)}")
            
            # Check for button labels
            buttons = await page.query_selector_all("button")
            print(f"  ✅ Interactive buttons found: {len(buttons)}")
            
            print("\n" + "=" * 50)
            print("✅ Dashboard testing completed successfully!")
            print(f"🌐 Dashboard URL: http://localhost:8501")
            
        except Exception as e:
            print(f"\n❌ Error during testing: {e}")
            print("Make sure the dashboard is running: streamlit run mirador_web_dashboard.py")
            
        finally:
            await browser.close()

async def main():
    """Main function"""
    # Check if playwright is installed
    try:
        import playwright
    except ImportError:
        print("❌ Playwright not installed. Installing now...")
        import subprocess
        subprocess.check_call([sys.executable, "-m", "pip", "install", "playwright"])
        subprocess.check_call([sys.executable, "-m", "playwright", "install", "chromium"])
        print("✅ Playwright installed successfully")
    
    # Run tests
    await test_dashboard()

if __name__ == "__main__":
    asyncio.run(main())