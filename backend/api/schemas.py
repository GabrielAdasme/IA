from pydantic import BaseModel

class GenerateRequest(BaseModel):
    prompt: str
    project_id: str
