from .agents import build_agents
from services.ollama_client import ollama_generate
from services.file_manager import save_project
from services.docker_executor import run_code_in_docker

async def run_full_generation(prompt: str, project_id: str):
    planner, coder, reviewer, executor = build_agents()

    # 1. Planejamento
    plan = ollama_generate(f"Crie um plano detalhado para:\n{prompt}")

    # 2. Geração do código
    code = ollama_generate(f"Com base no plano abaixo, gere TODO O CÓDIGO:\n{plan}")

    # 3. Revisão
    reviewed = ollama_generate(f"Revise o código abaixo:\n{code}")

    # 4. Salvar
    fp = save_project(project_id, reviewed)

    # 5. Executar
    logs = run_code_in_docker(fp)

    return {
        "plan": plan,
        "raw_code": code,
        "reviewed_code": reviewed,
        "execution_logs": logs
    }
