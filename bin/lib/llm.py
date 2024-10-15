import os
import subprocess
from openai import OpenAI

def simple_openai_call(combined_prompt):
    # Read the OpenAI API key from environment variable
    api_key = os.getenv('OPENAI_API_KEY')
    if not api_key:
        raise ValueError("OPENAI_API_KEY environment variable not set")

    # Initialize OpenAI client
    client = OpenAI()

    # Call the OpenAI API
    try:
        completion = client.chat.completions.create(
            model="gpt-4o",
            messages=[
                {"role": "user", "content": combined_prompt}
            ]
        )
        return completion.choices[0].message.content.strip()
    except Exception as e:
        raise ValueError(f"OpenAI API request failed: {str(e)}")



def transcribe_with_whisper(media_file_path, model="base", language="en", output_format="txt"):
    
    # Determine the transcript file name
    transcript = f"{os.path.splitext(media_file_path)[0]}.txt"

    # Check if the transcript already exists
    if os.path.isfile(transcript):
        print(f"Transcript for {media_file_path} already exists.")
        return transcript

    # Run the whisper command with timing
    command = [
        "whisper", media_file_path,
        "--model", model,
        "--language", language,
        "--output_format", output_format,
        "--output_dir", os.path.dirname(media_file_path)
    ]
    subprocess.run(command)

    return transcript
