# Connie-4 v0.0.0

### Overview
This project is for a basic playable GUI of the popular board game
[Connect Four](https://en.wikipedia.org/wiki/Connect_Four). Within this game,
users can play against **Connie-4**, the aptly-named AI.

### Usage Instructions
*(Production builds not yet supported)*

### How It's Made &reg;
This project was designed with [Godot](https://godotengine.org/), an open-source
video game engine. The scripts within are
[GDScript](https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/gdscript_basics.html),
with the more computationally-intensive areas written in GDNative (C++).

### Current Status / Future Plans
Currently, the basic UI is in place, but the functionality behind it is totally lacking. I hope to
first focus on basic user inputs, potentially providing a basic 2-player mode if
it seems simple. However as soon as possible, I will begin developing Connie-4.

The primary goal of Connie-4 is just to make as strong of an AI as possible. However,
just for the sake of interest, I hope to also give Connie-4 different "moods" that correlate
to different AI implementation techniques. These may include but are not limited to:
- **Nerd** (Game Tree)
- **Forgiving** (Game Tree w/ a bit of randomization)
- **Braniac** (Neural Network)
- **Caveman** (Genetic Algorithm)
