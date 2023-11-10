FROM ubuntu:20.10 as builder
FROM google/dart:latest
WORKDIR /lib



# Use an official Dart runtime as the base image


# Set the working directory


# Copy the pubspec.yaml and pubspec.lock to leverage Docker cache
COPY pubspec.* ./

# Get dependencies
# RUN dart pub get

# Copy the entire project to the container
COPY . .

# Build the Flutter application
# Installing Android SDK
# RUN mkdir -p Android/sdk
# ENV ANDROID_SDK_ROOT /home/user/Android/sdk
# RUN mkdir -p .android && touch .android/repositories.cfg
# RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
# RUN unzip sdk-tools.zip && rm sdk-tools.zip
# RUN mv tools Android/sdk/tools
# RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
# RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
# ENV PATH "$PATH:/home/user/Android/sdk/platform-tools"

#Installing Flutter SDK
# RUN git clone https://github.com/flutter/flutter.git
# ENV PATH "$PATH:/Users/gourabchatterjee/Desktop/flutter/bin"

RUN flutter doctor
RUN flutter run

# Expose the desired port
EXPOSE 80

# Start the Flutter application
CMD ["dart", "bin/server.dart"]
