import requests

def construct_fabric_prompt(prompt_name, content):
    # Construct the GitHub URL for the prompt file
    prompt_file = f"https://raw.githubusercontent.com/jcran/fabric/main/patterns/{prompt_name}/system.md"
    
    # Read the prompt from the specified GitHub URL
    response = requests.get(prompt_file)
    if response.status_code == 200:
        prompt = response.text
    else:
        raise ValueError(f"Failed to fetch the prompt from: {prompt_file}")

    # Combine prompt and content
    combined_prompt = prompt + "\n" + content
    return combined_prompt
