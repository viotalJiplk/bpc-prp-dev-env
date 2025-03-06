# BPC-PRP dev env
This is dev enviroment for bpc-prp 2025 in docker.
## demo
Run ros demo.
### host
```bash
xhost +local:docker
docker build -t ros2 . --load
docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -it ros2
```
### container
```bash
source /opt/ros/humble/setup.bash
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
git clone https://github.com/ros/ros_tutorials.git -b humble
cd ..
rosdep install -i --from-path src --rosdistro humble -y
cd src/ros_tutorials/
colcon build
source install/local_setup.bash
ros2 run turtlesim turtlesim_node
```

## projekt
Run project in ros.
### initialization
#### host
Replace <projekt-folder> with (absolute) path to your project directory.
```bash
xhost +local:docker
docker build -t ros2 . --load
docker run --name ros2 -d -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix  -v <projekt-folder>:/projekt -it ros2 bash
```

#### container
***Please delete `.idea`, `.cmake-build-debug`, `install` and `log` folders before initializiang `rm -rf .idea .cmake-build-debug install log`***

```bash
source /opt/ros/humble/setup.bash
colcon build
source install/setup.bash
exit
```

### Run
***Activate licence using `Login with token`*** because there is no browser inside the container.
(somehow needed to kill - CTRL+C and than run again)
```bash
./ros2.bash
```