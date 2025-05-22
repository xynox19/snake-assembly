# Snake Game in NASM (x86, Windows)

A simple Snake game written in x86 Assembly using NASM and the Windows Console API.

## Features
- Real-time keyboard input (arrow keys)
- Console-based rendering
- Windows API integration (GetAsyncKeyState, WriteConsoleOutputCharacterA, etc.)
- Basic game loop and movement logic

## Requirements
- NASM (Netwide Assembler)
- GoLink or Microsoft Linker (LINK.exe)
- Windows OS (32-bit or 64-bit console-compatible)

## Build Instructions


1. Assemble the code:
   nasm -f win32 snake.asm -o snake.obj

2. Link using GoLink:
   GoLink /console snake.obj kernel32.dll user32.dll

   Or using Microsoft's LINK:
   link /subsystem:console /defaultlib:kernel32.lib /defaultlib:user32.lib snake.obj

## Controls
- Arrow keys: Move the snake (Up, Down, Left, Right)

## How It Works
- Snake's position is updated each frame based on current direction
- Input is checked asynchronously using GetAsyncKeyState
- The game draws the snake character (O) and clears the previous position using console output APIs

License
-------

This project is open source and free to use for educational and non-commercial purposes.
