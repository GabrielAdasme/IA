from fastapi import FastAPI
from api.routes import router as api_router

app = FastAPI(title="Mocha Local AI")

app.include_router(api_router)

@app.get("/")
def home():
    return {"status": "ok", "message": "Mocha Local AI backend running"}
