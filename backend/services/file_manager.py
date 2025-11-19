import os

BASE_DIR = "./workspace"

def save_project(project_id, code):
    project_path = f"{BASE_DIR}/{project_id}"
    os.makedirs(project_path, exist_ok=True)
    file_path = f"{project_path}/main.py"
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(code)
    return file_path
