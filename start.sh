#!/bin/bash

echo "[Start] Launching GUI stack..." | tee /var/log/startup.log

export DISPLAY=:1

echo "[Start] Starting Xvfb..." | tee -a /var/log/startup.log
Xvfb :1 -screen 0 1280x800x16 &
sleep 2

echo "[Start] Starting Xfce session..." | tee -a /var/log/startup.log
xfce4-session &

echo "[Start] Starting VNC server..." | tee -a /var/log/startup.log
x11vnc -display :1 -nopw -forever &

echo "[Start] Starting noVNC on port 6080..." | tee -a /var/log/startup.log
websockify --web=/usr/share/novnc/ 6080 localhost:5900 &

echo "[Start] (Optional) Launching Android Studio..." | tee -a /var/log/startup.log
studio &

# Keep container alive
tail -f /var/log/startup.log
