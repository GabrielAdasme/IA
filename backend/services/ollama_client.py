import requests

OLLAMA_URL = "http://localhost:11434/api/generate"
MODEL = "deepseek-coder"

def ollama_generate(prompt):
    response = requests.post(OLLAMA_URL, json={
        "model": MODEL,
        "prompt": prompt
    }, stream=True)

    full = ""
    for line in response.iter_lines():
        if line:
            try:
                import json
                full += json.loads(line.decode())["response"]
            except:
                pass
    return full
