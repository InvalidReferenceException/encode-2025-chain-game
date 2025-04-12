## 🧠 ENCODE 2025 HACKATHON - On-chain AI Strategy Game

A modular on-chain strategy game where players move, claim, and rent land tiles on a fully decentralized map — with intelligent AI suggestions and 3D rendering powered by a visual agent system.

Built using [Dojo Engine](https://github.com/dojoengine/dojo) (ECS architecture on Starknet), Cairo contracts, and integrated with AI models (LLM, Portia, asset generation) and frontend-ready 3D render pipelines.

---

## 🗺️ Game Concept

- The world is divided into **(x, y)** tiles.
- Players own and **move** across tiles, **capture** unclaimed land, or **rent** from others.
- AI agent helps make decisions such as:
  - Best next move
  - Optimal land to claim/rent
  - Terrain-based strategy

---

## 🔩 Smart Contract Structure (Dojo)

Deployed on Starknet L2 (powered by StarkWare) with smart contracts written in Cairo.

| Folder | Purpose |
|--------|---------|
| `src/component` | Player, Tile (ownership, stats, wallet, position) |
| `src/systems-action` | Capture, CreateLand, Rent |
| `src/system-mapworld` | World map setup / validation |
| `tests-sample/` | Unit tests for component + systems |
| `lib.cairo` | Entry point for world logic |
| `manifest.json` | Dojo world manifest |

---

## 🤖 AI Integration

We use a dedicated Python service (ai_agent/) to:

- 💡 Interpret user text (e.g. “Where should I move?”)
- 🧠 Call LLMs (Portia AI & Gemini) to reason
- 🔗 Connect with game state via Cairo bindings
- 🎙️ Future: voice-to-text prompt / podcast mode

> Output is exposed via an API (`/suggest-move`, `/decision`) and can be consumed by frontend or automated bots.

---

## 🖼️ Visuals & Assets

All tiles may include:
- 📍 Coordinates (x, y)
- 🧱 Model type (gltf, obj, etc.)
- 🌄 Cloud image / texture
- 📃 Description + category
- 🧩 Used in 3D scene via Three.js / Unity or WebGL (external frontend)

---

## 🚀 Getting Started

### Run Cairo Locally

```bash
katana --dev --dev.no-fee
sozo build
sozo migrate
torii --world <WORLD_ADDRESS>

