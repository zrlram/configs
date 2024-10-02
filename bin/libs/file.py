def read_file(file_path):
    """
    Reads the content of a file and returns it as a string.
    
    :param file_path: Path to the file to be read
    :return: Content of the file as a string
    :raises FileNotFoundError: If the file does not exist
    :raises IOError: If there is an error reading the file
    """
    try:
        with open(file_path, 'r') as file:
            content = file.read()
        return content
    except FileNotFoundError:
        raise FileNotFoundError(f"File {file_path} not found")
    except IOError as e:
        raise IOError(f"Error reading file {file_path}: {str(e)}")
