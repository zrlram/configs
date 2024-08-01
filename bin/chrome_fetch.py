"""
CLI tool and library for fetching content via Chrome driven by Selenium. Has some tricks up its sleeve to evade
mechanized browser detection.

Pedram Amini
https://pedramamini.com

Requirements:
    pip install selenium
    pip install webdriver_manager

Usage:
    usage: chrome_fetch.py [-h] [--sleep SLEEP] [--headless] [--debug] [--referrer [REFERRER]]
                           [--human]
                           url

    Fetch the inner text of a webpage.

    positional arguments:
      url                   URL of the webpage to fetch

    options:
      -h, --help            show this help message and exit
      --sleep SLEEP         Time to wait in-between operations
      --headless            Run in headless mode.
      --debug               Enable debug mode.
      --referrer [REFERRER]
                            Referrer URL to start from (default: https://www.google.com).
      --human               Mimick human behavior with mouse
"""

import sys
import time
import random
import hashlib
import logging
import argparse

from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.action_chains import ActionChains

USER_AGENT = "user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36"

########################################################################################################################
def chrome_fetch (url, sleep_time=0.25, headless=False, debug=False, referrer=None, human=False):
    """
    Navigates to a specified URL in a Chrome browser session, optionally mimicking human behavior, and returns the text content of the page.

    Args:
        url (str): The target URL from which to fetch the content.
        sleep_time (float, optional): The duration in seconds to pause between actions,
                                      helping to mimic human behavior or allow page elements to load (default is 0.25 seconds).
        headless (bool, optional): If set to True, runs the Chrome browser in headless mode
                                   without a GUI (default is False).
        debug (bool, optional): If set to True, enables verbose logging to aid in debugging
                                (default is False).
        referrer (str, optional): A URL to visit before navigating to the target URL,
                                  simulating a user journey from one page to another (default is None, meaning no referrer is used).
        human (bool, optional): If set to True, simulates human-like browsing behavior such as
                                random scrolling and variable timing between actions (default is False).

    Returns:
        str: The text content of the target webpage after it has been fully loaded,
             and after performing any additional simulated human interactions if enabled.

    This function initializes a Chrome browser session, optionally in headless mode, and navigates first to a referrer URL,
    then to the target URL. If human-like behavior is enabled, it simulates human actions like scrolling and random delays to
    make the automation less detectable to anti-bot mechanisms. It waits for the page to load and scrolls to ensure dynamic content
    is loaded, then extracts and returns the text content of the page.
    """

    if debug:
        logging.basicConfig(level=logging.DEBUG)
        logging.debug("Debug mode enabled")

    # Set up Chrome options
    chrome_options = Options()

    # Hide from detection
    chrome_options.add_argument(USER_AGENT)
    chrome_options.add_argument("--disable-features=WebRtcHideLocalIpsWithMdns")

    if headless:
        chrome_options.add_argument("--headless")
        chrome_options.add_argument("--disable-gpu")
        chrome_options.add_argument("--window-size=1920x1080")
        logging.debug("Headless mode enabled")

    logging.debug("Initializing ChromeDriver")
    service = Service(ChromeDriverManager().install())
    driver = webdriver.Chrome(service=service, options=chrome_options)

    # Hide from detection
    driver.execute_script("Object.defineProperty(navigator, 'webdriver', {get: () => undefined})")

    try:
        # Navigate to referrer URL
        if referrer:
            if debug:
                logging.debug(f"Starting at referrer: {referrer}")
            driver.get(referrer)
            if debug:
                logging.debug("Referrer page loaded")

        # Navigate to the target URL
        if debug:
            logging.debug(f"Navigating to {url}")
        driver.get(url)

        WebDriverWait(driver, 20).until(EC.presence_of_element_located((By.TAG_NAME, "body")))

        if debug:
            logging.debug("Page initially loaded")

        # Human-like behavior on the target site
        if human:
            logging.debug("Human-like behavior enabled")
            actions = ActionChains(driver)
            # Simulate human-like scrolling and content checking
            for _ in range(random.randint(3, 7)):
                scroll_length = random.randint(100, 500)
                actions.scroll_by_amount(0, scroll_length).perform()
                time.sleep(random.uniform(0.5, 2))
            logging.debug("Human-like scrolling completed")

        # Regular behavior
        else:
            last_height = driver.execute_script("return document.body.scrollHeight")
            for _ in range(10):  # Limit the number of scrolls
                driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
                time.sleep(random.uniform(0.1, sleep_time))
                new_height = driver.execute_script("return document.body.scrollHeight")
                if new_height == last_height:
                    break
                last_height = new_height
                if debug:
                    logging.debug("Scrolled to new height")

        old_content = ""
        new_content = driver.find_element(By.TAG_NAME, "body").text

        for _ in range(3):  # Limit the number of content checks
            if hashlib.md5(old_content.encode()).digest() == hashlib.md5(new_content.encode()).digest():
                break
            time.sleep(random.uniform(0.1, sleep_time))
            old_content = new_content
            new_content = driver.find_element(By.TAG_NAME, "body").text
            if debug:
                logging.debug("Content checked")

        return new_content

    finally:
        if debug:
            logging.debug("Quitting driver")

        driver.quit()


########################################################################################################################
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Fetch the inner text of a webpage.")
    parser.add_argument("url", help="URL of the webpage to fetch")
    parser.add_argument("--sleep", type=float, default=0.25, help="Time to wait in-between operations")
    parser.add_argument("--headless", action='store_true', help="Run in headless mode.")
    parser.add_argument("--debug", action='store_true', help="Enable debug mode.")
    parser.add_argument("--referrer", nargs='?', default=None, const="https://www.google.com", help="Referrer URL to start from (default: https://www.google.com).")
    parser.add_argument("--human", action='store_true', help="Mimick human behavior with mouse")

    args = parser.parse_args()

    print(chrome_fetch(args.url, args.sleep, args.headless, args.debug, args.referrer, args.human))
