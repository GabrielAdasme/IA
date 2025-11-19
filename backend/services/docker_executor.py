import subprocess

def run_code_in_docker(path):
    cmd = [
        "docker", "run",
        "--rm",
        "-v", f"{path}:/app/main.py",
        "python:3.10",
        "python", "/app/main.py"
    ]
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=20)
        return result.stdout + result.stderr
    except Exception as e:
        return str(e)
