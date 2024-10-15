import os
import requests

def send_email(email, topic, content):
    api_key = os.getenv('POSTMARK_API_KEY')
    sender_email = os.getenv('PERSONAL_EMAIL', 'jcran@0x0e.org')
    url = 'https://api.postmarkapp.com/email'

    headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-Postmark-Server-Token': api_key,
    }

    data = {
        'From': sender_email,
        'To': email,
        'Subject': topic,
        'TextBody': content,
    }

    response = requests.post(url, headers=headers, json=data)

    if response.status_code == 200:
        print('Email sent successfully')
    else:
        print(f'Failed to send email: {response.status_code} - {response.text}')

