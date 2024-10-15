import subprocess
import os
from datetime import datetime, timedelta

from pathlib import Path
from dateutil.rrule import rrule, DAILY

def set_file_time(file_path, dt):
    # Convert datetime to the format required by touch command
    time_str = dt.strftime('%Y%m%d%H%M.%S')
    
    if os.name == 'posix':  # Unix-like system
        subprocess.call(['touch', '-t', time_str, file_path])
    elif os.name == 'nt':  # Windows
        # Setting creation time is not directly possible; setting modification time instead
        subprocess.call(['powershell', '$(Get-Item', str(file_path) + ').lastwritetime=$(Get-Date', f"'{dt.strftime('%Y-%m-%d %H:%M:%S')}'" + ')'])

def create_missing_daily_files(directory, template_path):
    start_date = datetime(datetime.now().year, 1, 1)  # Start from Jan 1 of the current year
    end_date = datetime(datetime.now().year, 12, 31)  # End on Dec 31 of the current year
    current_date = datetime.now()
    
    daily_path = Path(directory)
    template_path = Path(template_path)
    
    # Read the template content
    with template_path.open('r') as file:
        template_content = file.read()

    # Ensure the directory exists
    daily_path.mkdir(parents=True, exist_ok=True)

    # Generate all dates within the year
    for dt in rrule(DAILY, dtstart=start_date, until=current_date):
        file_name = dt.strftime("%Y%m%d-Daily.md")
        file_path = daily_path / file_name

        date_plus_one = dt + timedelta(days=1)
        fourteen_days_from_date = dt + timedelta(days=14)
        thirty_days_past_date = dt + timedelta(days=-30)
        
        # Check if the file exists
        if not file_path.exists():
            # Replace placeholder in template content
            date_specific_content = template_content.replace("{{date}}", dt.strftime('%Y-%m-%d'))
            date_specific_content = date_specific_content.replace("{{date_plus_one}}", date_plus_one.strftime('%Y-%m-%d'))
            date_specific_content = date_specific_content.replace("{{fourteen_days_from_date}}", fourteen_days_from_date.strftime('%Y-%m-%d'))
            date_specific_content = date_specific_content.replace("{{thirty_days_past_date}}", thirty_days_past_date.strftime('%Y-%m-%d'))
            
            # Create the file
            with file_path.open('w') as file:
                file.write(date_specific_content)
            
            # Set file creation and modification time
            set_file_time(str(file_path), dt)
            print(f"Created missing file: {file_path}")
        else:
            print(f"skipping existing file: {file_path}")

# Usage: specify the path where you want to check and create files, and the path to your template file
create_missing_daily_files("/Users/stephanchenette/Documents/ObsidianTest/Daily", "./daily_template.md")
