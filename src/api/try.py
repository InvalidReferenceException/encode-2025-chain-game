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


# ------------------ API ENDPOINT (FastAPI) x Frontend integration ------------------
const res = await fetch("/api/get-tiles");
const tiles = await res.json();
tiles.forEach(tile => {
  scene.add(loadTile(tile));
});
