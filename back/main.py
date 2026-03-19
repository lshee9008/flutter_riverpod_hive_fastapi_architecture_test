from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List
import uuid

app = FastAPI(title="Todo API")

# Flutter(앱)에서 접근 허용 - 개발 중에는 모든 origin 허용
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_method=["*"],
    allow_headers=["*"],
)

# 모델
class TodoCreate(BaseModel):
    title: str
    done: bool = False

class Todo(TodoCreate):
    id: str

# 임시 인메모리 유
db: dict[str, Todo] = {}

# 라우터
@app.get("/todos", response_model=List[Todo])
async def get_todos():
    return list(db.values())

@app.post("/todos", response_model=Todo)
async def create_todo(payload: TodoCreate):
    todo = Todo(id=str(uuid.uuid4()), **payload.model_dump())
    db[todo.id] = todo
    return todo

@app.patch("/todods/{todod_id}", response_model=Todo)
async def update_todo(todo_id: str, payload: TodoCreate):
    if todo_id not in db:
        raise HTTPException(status_code=404, detail="Not found")
    db[todo_id] = Todo(id=todo_id, **payload.model_dump())
    return db[todo_id]

@app.delete("/todos/{todo_id")
async def delete_todo(todo_id: str):
    if todo_id not in db:
        raise HTTPException(status_code=404, detail="Not found")
    del db[todo_id]
    return {"ok": True}