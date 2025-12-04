from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI()

# 🔥 IMPORTANTE: Configurar CORS para o frontend se conectar
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Permite todas as origens (em produção, restringir)
    allow_credentials=True,
    allow_methods=["*"],  # Permite todos os métodos (GET, POST, etc)
    allow_headers=["*"],  # Permite todos os headers
)

class ProjectCreate(BaseModel):
    name: str
    description: str = ""

@app.get("/")
async def root():
    return {"message": "MochaLocalAI Backend Online!", "status": "success"}

@app.get("/api/health")
async def health_check():
    return {"status": "online", "message": "✅ Backend funcionando!"}

# 🔥 ROTA QUE O BOTÃO "NOVO PROJETO" DEVE CHAMAR
@app.post("/api/projects")
async def create_project(project: ProjectCreate):
    print(f"📨 Recebido: {project.name} - {project.description}")
    return {
        "status": "success", 
        "message": "Projeto criado com sucesso!",
        "project_id": 1,
        "project": project.dict()
    }

@app.get("/api/projects")
async def get_projects():
    return {
        "projects": [
            {"id": 1, "name": "Projeto Teste", "status": "ativo"}
        ]
    }
