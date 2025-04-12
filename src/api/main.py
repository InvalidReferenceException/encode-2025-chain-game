from fastapi import FastAPI, UploadFile, File
from fastapi.staticfiles import StaticFiles
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import requests
import os
import shutil

app = FastAPI()


# ------------------ API ENDPOINT (FastAPI & JSON) x AI integration ------------------

# AI endpoint 
AI_endpoint = "https://8da6-193-221-143-82.ngrok-free.app/generate"

# Pydantic for validation JSON body structure
# Validate JSON body structure (prompt, tile, neighbours)
class PromptRequest(BaseModel):
    prompt: str                 # Description for AI to generate image
    tile: int                   # Tile ID or coordinate number
    neighbours: List[int]       # List of surrounding tile IDs

# API endpoint 
@app.post("/generate-ai/")
async def generate_ai(data: PromptRequest):  # Validate JSON body using PromptRequest model
    # Convert validated object into dict for POST request
    response = requests.post(AI_ENDPOINT, json=data.dict())

    # Parse JSON response from AI backend
    result = response.json()

    # AI image URL to Frontend team - Sample (https://www.notion.so/aglaia-codes/Supabase-1d3c574ec74080fe8f60e43116c99b75?pvs=4)
    image_url = result.get("url")

    # Return success and generated image URL back to frontend
    return {"success": True, "ai_image": image_url}

# ------------------ API ENDPOINT (FastAPI) x Frontend integration - GET Tiles from Starknet (via RPC)  ------------------
@app.get("/tiles")
def get_all_tiles():
    """
    This endpoint simulates pulling tile data from Starknet via Torii RPC.
    Later this will be replaced with actual on-chain calls.
    """
    tiles = [
        {
            "x": 3,
            "y": 7,
            "img_url": "https://supabase.com/encode-assets/tile_3_7.png",
            "model_url": "https://supabase.com/encode-assets/tile_3_7.glb",
            "description": "tree",
            "tile_type": "normal"
        },
        {
            "x": 4,
            "y": 8,
            "img_url": "https://supabase.com/encode-assets/tile_4_8.png",
            "model_url": "https://supabase.com/encode-assets/tile_4_8.glb",
            "description": "house",
            "tile_type": "normal"
        }
    ]

    return {"tiles": tiles}







