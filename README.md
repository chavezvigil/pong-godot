# 🏓 Pong – Classic Game in Godot 4.5

A modern remake of the classic **Pong**, built with **Godot Engine 4.5**.  
This project was created to practice **2D physics, input handling, and scene structure** in Godot.

---

## 🎮 Features

- Classic arcade-style gameplay  
- **1 Player (vs CPU)** 
- Score tracking system  
- Realistic ball bounces depending on hit angle  
- Automatic restart after scoring  
- Easy configuration for speed and field size

---
<img width="1356" height="717" alt="image" src="https://github.com/user-attachments/assets/88bc4d66-5fdf-448d-b506-af9bee79458e" />

<img width="1128" height="600" alt="image" src="https://github.com/user-attachments/assets/4675c26c-1ec6-496c-a3e7-e6c76ad454fc" />

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/a8a37bad-f36e-4d6c-872c-3a7c8f5a3184" />


## 🧠 Project Structure

```text
res://
├── assets/
├── Ball/
│   ├── ball.tscn           # Ball game scene
│   ├── ball.gd             # Ball behavior script
├── Computer/
│   ├── computer.tscn       # Computer game scene
│   ├── computer.gd         # Computer behavior script
├── Player/
│   ├── player.tscn         # Player game scene
│   ├── player.gd           # player behavior script
├── Pong/
│   ├── pong.tscn           # Main game scene
│   ├── pong.gd             # Pong behavior script
└── icon.svg                # Godot project icon

| Action       | Player 1 | 
| ------------ | -------- | 
| Move up      | `↑`      |
| Move down    | `↓`      | 


