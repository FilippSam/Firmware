#! /bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
PX4_SRC_DIR=${DIR}/..

source /opt/ros/kinetic/setup.bash
mkdir catkin_ws/src
cd catkin_ws
git clone --depth=1 https://github.com/PX4/avoidance.git src/
catkin init
catkin build local_planner --cmake-args -DCMAKE_BUILD_TYPE=Release
source ${PX4_SRC_DIR}/Tools/setup_gazebo.bash ${PX4_SRC_DIR} ${PX4_SRC_DIR}/build/posix_sitl_default

source devel/setup.bash
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:${PX4_SRC_DIR}:${PX4_SRC_DIR}/Tools/sitl_gazebo

rostest px4 "$@"
