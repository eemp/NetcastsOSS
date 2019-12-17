FROM ubuntu:18.04

RUN apt-get update

ENV DEBIAN_FRONTEND=noninteractive

# Install some dependencies
RUN dpkg --add-architecture i386 && apt-get update \
    && apt-get install -y --force-yes curl expect git wget unzip xz-utils \
    libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1

# Install java
RUN apt-get install -y openjdk-8-jdk-headless

# Download and install Gradle
#RUN mkdir -p /opt/gradle && \
    #cd /opt/gradle && \
    #curl -L https://services.gradle.org/distributions/gradle-6.0-bin.zip -o gradle-6.0-bin.zip && \
    #unzip gradle-6.0-bin.zip && \
    #rm gradle-6.0-bin.zip

#ENV GRADLE_HOME /opt/gradle/gradle-6.0

# Install the Android SDK
RUN cd /opt && wget --output-document=android-sdk.zip --quiet \
    https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
    && unzip android-sdk.zip -d /opt/android-sdk && rm -f android-sdk.zip

# Install Flutter
RUN cd /opt && wget --output-document=flutter-sdk.tar.xz --quiet \
    https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.12.13+hotfix.5-stable.tar.xz \
    && tar xf flutter-sdk.tar.xz \
    && rm -f flutter-sdk-tar.xz

# Setup environment
ENV FLUTTER_HOME /opt/flutter
ENV ANDROID_SDK_ROOT /opt/android-sdk
ENV ANDROID_HOME /opt/android-sdk
#ENV PATH ${GRADLE_HOME}/bin:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${FLUTTER_HOME}/bin:${PATH}
ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${FLUTTER_HOME}/bin

# Install SDK elements. This might change depending on what your app needs
# I'm installing the most basic ones. You should modify this to install the ones
# you need. You can get a list of available elements by getting a shell to the
# container and using `sdkmanager --list`
RUN echo yes | sdkmanager "platform-tools" "platforms;android-28" "build-tools;28.0.3"

# Perform an artifact precache so that no extra assets need to be downloaded on demand.
RUN flutter precache

# Accept licenses.
RUN yes "y" | flutter doctor --android-licenses

# Disable analytics and crash reporting on the builder.
RUN flutter config  --no-analytics

# Perform a doctor run.
RUN flutter doctor -v

# Perform a flutter upgrade
RUN flutter upgrade

# Go to workspace
RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
