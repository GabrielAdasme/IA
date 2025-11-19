from fastapi import APIRouter
from orchestrator.manager import run_full_generation
from api.schemas import GenerateRequest

router = APIRouter(prefix="/api")

@router.post("/generate")
async def generate_app(payload: GenerateRequest):
    result = await run_full_generation(
        prompt=payload.prompt,
        project_id=payload.project_id
    )
    return result
