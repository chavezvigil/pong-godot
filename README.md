# 🏓 Pong – Classic Game in Godot 4.5

A modern remake of the classic **Pong**, built with **Godot Engine 4.5**.  
This project was created to practice **2D physics, input handling, and scene structure** in Godot.

---

## 🎮 Features

- Classic arcade-style gameplay  
- **1 Player (vs CPU)** and **2 Player** local modes  
- Score tracking system  
- Realistic ball bounces depending on hit angle  
- Automatic restart after scoring  
- Easy configuration for speed and field size

---

## 🧠 Project Structure

```text
res://
├── main.tscn           # Main game scene
├── paddle.gd           # Paddle script (player or CPU)
├── ball.gd             # Ball behavior script
├── ui/
│   └── score_label.tscn  # Score label scene
├── assets/
│   ├── sounds/
│   ├── sprites/
│   └── fonts/
└── project.godot        # Godot project configuration

| Action       | Player 1 | Player 2 |
| ------------ | -------- | -------- |
| Move up      | `W`      | `↑`      |
| Move down    | `S`      | `↓`      |
| Restart game | `R`      | —        |
| Quit game    | `Esc`    | —        |
