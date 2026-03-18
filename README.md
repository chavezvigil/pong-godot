# 🐢 Turtle Studio: Pong Premium Remake 🏓

Un remake moderno y ultra-pulido del clásico **Pong**, desarrollado con **Godot Engine 4.5**. Este no es solo un clon; es una experiencia arcade completa diseñada para móviles (landscape) con sistemas procedimentales, audio sintético y alta competitividad.

---

## 🎮 Características Premium

### 🎨 5 Temáticas Dinámicas (Procedural)
Cada tema cambia por completo la estética, el balón, el fondo y la atmósfera auditiva mediante **Shaders GLSL** y generación por código:
- **🌌 Espacio**: Campo de estrellas dinámico con nebulosas y audio etéreo.
- **🏖️ Playa**: Horizonte tropical con mar turquesa, arena dorada y sonido de olas.
- **⚽ Fútbol**: Campo de césped con líneas realistas y ambiente de estadio.
- **🍕 Pacman**: Laberinto retro con un Pacman animado y música de 8 bits.
- **🔳 Clásico**: La esencia original con un toque de brillo moderno.

### 👥 Modos de Juego
- **1 Jugador (vs CPU)**: Inteligencia Artificial con 20+ niveles de dificultad progresiva.
- **2 Jugadores (Local)**: ¡Reto 1vs1 en el mismo dispositivo! Pantalla dividida con zonas de toque independientes.

### 🧠 Sistemas Avanzados
- **💾 Persistencia de Datos**: Guardado automático de récords (Nivel Máximo), logros (Títulos de Rango) y ajustes de usuario.
- **🔊 Audio Produrmental**: Sintetizador de audio en tiempo real para ambientes y efectos de impacto "Wii Style" de baja latencia.
- **📳 Feedback Sensorial**: Vibración háptica en cada golpe y partículas de explosión tematizadas por cada rebote.
- **⚡ Optimización Mobile**: Diseño "Landscape-First", controles de baja fricción y renderizado eficiente mediante código puro.

---

## 🧠 Estructura del Proyecto

```text
res://
├── GlobalSettings/     # Persistencia y Variables Globales
├── Splash/            # Intro Animada de Turtle Studio
├── Menu/              # Menú Principal con Sistema de Récords
├── Settings/          # Panel de Ajustes Mobile-Friendly
├── Pong/              # Lógica de Juego y Mezclador de Audio Procedural
├── Player/            # Control de Paleta Humana (Left/Right)
├── Computer/          # IA Adaptativa / Modo 2 Jugadores
├── Ball/              # Shaders, Partículas y Física de Rebote
└── assets/            # Recursos base y Fuentes "Premium"
```

## 🕹️ Controles

| Acción | Jugador 1 (Izquierda) | Jugador 2 (Derecha) |
| :--- | :--- | :--- |
| **Táctil / Mouse** | Mitad Izquierda de Pantalla | Mitad Derecha de Pantalla |
| **Teclado** | W / S o Flechas ↑ / ↓ | Teclado Numérico u Otros |

---

## 🛠️ Tecnologías
- **Motor**: Godot 4.5
- **Lenguaje**: GDScript
- **Visuales**: Shaders GLSL personalizados (Sin dependencia de imágenes pesadas)

---

### Desarrollado por **Turtle Studio** 🐢🚀🏆
