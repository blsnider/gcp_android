# android-cloud-workstation/Dockerfile
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl wget unzip gnupg2 software-properties-common \
    openjdk-17-jdk \
    xfce4 xfce4-goodies x11vnc xvfb \
    novnc websockify \
    git sudo net-tools ca-certificates \
    dbus-x11 xfonts-base \
    && apt-get clean

# Create user
RUN useradd -m -s /bin/bash devuser && echo 'devuser:devuser' | chpasswd && adduser devuser sudo

# Install Android Studio
RUN mkdir -p /opt/android-studio && \
    wget -q https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2022.3.1.20/android-studio-2022.3.1.20-linux.tar.gz -O studio.tar.gz && \
    tar -xzf studio.tar.gz -C /opt/android-studio --strip-components=1 && \
    rm studio.tar.gz

ENV PATH=$PATH:/opt/android-studio/bin

# Install Android SDK Command Line Tools
RUN mkdir -p /opt/android-sdk/cmdline-tools && \
    cd /opt/android-sdk/cmdline-tools && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O tools.zip && \
    unzip tools.zip && mv cmdline-tools latest && \
    rm tools.zip

ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=$PATH:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin

# Accept licenses and install essential SDK packages
RUN yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"

# Copy and set startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 6080
CMD ["bash"]
