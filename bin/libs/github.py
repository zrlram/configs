import os
import requests


def get_github_api_key():
    return os.getenv('GITHUB_API_KEY')


def create_gist_from_file(file_path, gist_description):

    access_token = get_github_api_key()

    # Prepare the payload for the gist creation
    if not os.path.isfile(file_path):
        print(f"File {file_path} does not exist.")
        return None

    with open(file_path, 'r') as file:
        content = file.read()

    gist_files = {
        os.path.basename(file_path): {"content": content}
    }

    # Create the gist
    gist_data = {
        "description": gist_description,
        "public": True,
        "files": gist_files
    }

    headers = {
        "Authorization": f"token {access_token}"
    }

    response = requests.post("https://api.github.com/gists", json=gist_data, headers=headers)

    if response.status_code == 201:
        gist_url = response.json()["html_url"]
        print(f"Gist created successfully: {gist_url}")
        return gist_url
    else:
        print(f"Failed to create gist: {response.status_code}")
        print(response.json())
        return None


def create_gist_from_directory(directory_path, gist_description):
    
    access_token = get_github_api_key()
    
    # Prepare the payload for the gist creation
    gist_files = {}
    for filename in os.listdir(directory_path):
        file_path = os.path.join(directory_path, filename)
        if os.path.isfile(file_path):
            with open(file_path, 'r') as file:
                content = file.read()
                gist_files[filename] = {"content": content}

    # Create the gist
    gist_data = {
        "description": gist_description,
        "public": True,
        "files": gist_files
    }

    headers = {
        "Authorization": f"token {access_token}"
    }

    response = requests.post("https://api.github.com/gists", json=gist_data, headers=headers)

    if response.status_code == 201:
        gist_url = response.json()["html_url"]
        print(f"Gist created successfully: {gist_url}")
        return gist_url
    else:
        print(f"Failed to create gist: {response.status_code}")
        print(response.json())
        return None


