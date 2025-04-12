from fastapi import FastAPI, UploadFile, File
from fastapi.staticfiles import StaticFiles
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os
import shutil

app = FastAPI()

# ------------------ CONFIG DATABASE ------------------
DATABASE_URL = "sqlite:///./glb_files.db"  # SQLite to collect file in  local

engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# ------------------ MODEL ------------------
class GLBModel(Base):
    __tablename__ = "glb_files"
    id = Column(Integer, primary_key=True, index=True)
    filename = Column(String, unique=True, index=True)
    url = Column(String)

Base.metadata.create_all(bind=engine)  # create table in database

# ------------------ UPLOAD CONFIG ------------------
UPLOAD_FOLDER = "src/assets/uploads"
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

# Serve static files
app.mount("/static", StaticFiles(directory="src/assets"), name="static")

# ------------------ API ENDPOINT ------------------
@app.post("/upload-glb/")
async def upload_glb(file: UploadFile = File(...)):
    # 1. Save file to the upload folder
    file_location = os.path.join(UPLOAD_FOLDER, file.filename)
    with open(file_location, "wb") as f:
        shutil.copyfileobj(file.file, f)

    # 2. Generate URL for the uploaded file
    url = f"/static/uploads/{file.filename}"

    # 3. Save filename and url to the database
    db = SessionLocal()
    glb_file = GLBModel(filename=file.filename, url=url)
    db.add(glb_file)
    db.commit()
    db.refresh(glb_file)
    db.close()

    # 4. Return JSON response
    return {"filename": file.filename, "url": url}
