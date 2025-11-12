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

<img width="1356" height="717" alt="image" src="https://github.com/user-attachments/assets/bd5dd9a7-bac7-432e-b476-c646e84c8afe" />

