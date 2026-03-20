# main.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import schemas

app = FastAPI()

# CORS 설정: Flutter 에뮬레이터나 웹에서 API를 호출할 수 있도록 허용합니다.
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # 실무에서는 정확한 도메인을 넣어야 하지만, 개발 환경에선 "*"로 엽니다.
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/todos", response_model=list[schemas.Todo])
def get_todos():
    return [
        {"id": 1, "title": "FastAPI 서버 띄우기", "is_completed": True},
        {"id": 2, "title": "Flutter와 Riverpod 연동하기", "is_completed": False}
    ]