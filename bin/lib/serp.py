import os
from serpapi import GoogleSearch
from lib.scrape import scrape_url_via_service

def top_result_content(search_query):
    
    # do the thing
    search_results = search_serpapi(search_query)

    # Extract relevant information from search results
    
    if 'organic_results' in search_results and len(search_results['organic_results']) > 0:
        top_result = search_results['organic_results'][0].get('link')
    
    if top_result:
        try:
            # Use the scrape_url_via_service method to get the content
            content = scrape_url_via_service(top_result)
            return content
        except Exception as e:
            raise ValueError(f"Request to {top_result} failed: {str(e)}")

    raise ValueError("Failed to retrieve top result content.")


def search_serpapi(query):
    # Read the SerpAPI key from environment variable
    api_key = os.getenv('SERPAPI_API_KEY')
    if not api_key:
        raise ValueError("SERPAPI_API_KEY environment variable not set")

    # Initialize SerpAPI client
    params = {
        "engine": "google",
        "q": query,
        "api_key": api_key
    }

    # Perform the search
    try:
        search = GoogleSearch(params)
        results = search.get_dict()
        return results
    except Exception as e:
        raise ValueError(f"SerpAPI request failed: {str(e)}")
