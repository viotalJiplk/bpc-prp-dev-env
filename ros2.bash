xhost +local:docker
docker container start ros2
docker exec -it ros2 bash -c "source /opt/ros/humble/setup.bash & clion"
docker container stop ros2