FROM ubuntu:jammy
ENV DEBIAN_FRONTEND=noninteractive

RUN locale  # check for UTF-8

RUN apt update && apt install locales
RUN locale-gen en_US en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8

RUN apt install -y software-properties-common
RUN add-apt-repository universe

RUN apt install curl -y
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
RUN apt update
RUN apt install -y ros-humble-ros-base
RUN apt install -y python3-colcon-common-extensions ros-humble-turtlesim git python3-rosdep
RUN rosdep init
RUN rosdep update
RUN apt install -y g++ cmake

RUN apt install -y ros-humble-rclcpp ros-humble-std-msgs ros-humble-sensor-msgs ros-humble-cv-bridge ros-humble-image-transport ros-humble-ament-cmake libopencv-dev libsdl2-dev ros-humble-rqt-graph ros-humble-rqt-plot ros-humble-rqt-common-plugins
RUN curl -L https://download.jetbrains.com/cpp/CLion-2024.3.4.tar.gz --output /opt/clion
RUN tar xvzf /opt/clion -C /opt
RUN ln -s /opt/clion-*/bin/clion /bin/clion
RUN mkdir /projekt
WORKDIR /projekt

CMD ["bash"]