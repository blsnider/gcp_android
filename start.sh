#!/bin/bash

# Setup display
export DISPLAY=:1
Xvfb :1 -screen 0 1280x800x16 &

# Start desktop environment
xfce4-session &

# Start web-based VNC access
websockify --web=/usr/share/novnc/ 6080 localhost:5900 &

# Start VNC server
x11vnc -display :1 -nopw -forever &

# Keep container running
sleep infinity
