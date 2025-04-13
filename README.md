# Genesis Void
**On-chain AI sandbox game with AI-Powered Morphing for 3D Assets**
## Project Name: Genesis Void
This repository contains the **frontend UI** for Genesis Void — a dynamic, on-chain AI sandbox game built on **Starkware’s Dojo engine**, visualized with **three.js** for immersive 3D interactions.
---
## What We’re Building!
Genesis Void is an on-chain AI sandbox where players carve reality out of the void — one step at a time. The world begins as a blank slate, but with the help of **Steve**, your intelligent AI companion powered by **Portia AI** and integrated with GPT, Gemini and Stability-based LLMs, you can shape it with your words.
Say “build a blue castle” and Steve will generate 3D assets in real time, morphing structures into existence. This AI-driven morphing engine interprets not just geometry, but **style**, **structure**, and **semantic intent** — enabling expressive, dynamic transformations.
On the backend, we use **Cairo 1.0** and **Dojo** to store all gameplay data on-chain: land ownership, inventories, structures, and player states. Players can **buy** tiles using the in-game currency **Quark**, **rent** land, or **capture** it via strategic play. For example, surrounding a 3x3 area with your owned tiles allows you to claim the center — combining world-building with tactical decision-making. Think *Minecraft meets chess*, running entirely on the blockchain.
---
## Morphing Pipeline
Genesis Void introduces a next-gen procedural morphing system that:
- Understands **style** and**structure** between asset inputs.
- Generates **intermediate 3D models** in response to prompts.
- Leverages **text input** to drive transformations (such as buy, rent or capture).
---
## Sponsor Technologies Used
### Starkware / Starknet
- On-chain game logic is implemented in **Cairo** using the **Dojo engine**, supporting fully verifiable state transitions.
- The world runs entirely on **Starknet**, where all gameplay actions, asset updates, and tile transactions are recorded.
- Tools used: **Cairo 1.0**, **Dojo**, **Katana**, **Starknet.js**

###  Portia.AI
- **Portia AI SDK** enables Steve to act as a controlled, intelligent agent:
  - Generates intermediate steps during morphing.
  - Requests human confirmation under specific uncertainty thresholds.
  - Makes Steve adaptable and context-aware, with human-in-the-loop support when needed.

###  Nethermind
-  We leverage **Nethermind** as the RPC backbone for Starknet communication and align with their **Agentic Future** vision:
  - Steve operates as a compact, autonomous agent with meaningful blockchain interaction.
  - Uses **on-chain smart contracts** to track land capture, resource usage, and morphing logic.
  - Ensures reliable, efficient access to the Starknet network and supports agentic execution at scale.
---

## Tech Stack
- **Frontend**: React, three.js
- **Onchain**: Dojo, Cairo 1.0, Starknet
- **AI Layer**: Python, Portia SDK, Prompt-to-Asset Morph Engine
- **Database**: Supabase
- **Asset Format**: glTF / glb / PNG
---
