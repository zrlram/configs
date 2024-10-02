import os
import requests
from bs4 import BeautifulSoup

def scrape_url_via_service(url):
    """
    Scrape the content of a URL using the ScrapingBee service.
    
    Parameters:
    url (str): The URL to scrape.
    
    Returns:
    str: The text content of the scraped page.
    """
    api_key = os.getenv('SCRAPINGBEE_API_KEY')
    if not api_key:
        raise ValueError("SCRAPINGBEE_API_KEY environment variable not set")
    
    try:
        response = requests.get(
            'https://app.scrapingbee.com/api/v1/',
            params={
                'api_key': api_key,
                'url': url,
                'render_js': 'false'
            }
        )
        if response.status_code == 200:
            # Assuming the content is in HTML, you might want to parse it using BeautifulSoup
            soup = BeautifulSoup(response.content, 'html.parser')
            # Extract the full text content from the HTML page
            return str(soup)
        else:
            raise ValueError(f"Failed to retrieve content from {url}, status code: {response.status_code}")
    except Exception as e:
        raise ValueError(f"Request to {url} failed: {str(e)}")
