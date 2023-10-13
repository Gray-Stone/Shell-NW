#! /usr/bin/zsh

# Source the ros stuff and include a waring print out 

# Yes using ros2 iron version
source_if_exists "/opt/ros/iron/setup.zsh" true

# This is from previous interbotix stuff
# source_if_exists "${HOME}/ws/interbotix/install/setup.zsh" true

CURRENT_ROS_LOCAL_WORKSPACE="$(realpath ${HOME}/495-hw-workspace)"

source_if_exists "${CURRENT_ROS_LOCAL_WORKSPACE}/install/setup.zsh" true

function nw-cbuild()
{
    (set -vx ; cd "${CURRENT_ROS_LOCAL_WORKSPACE}" && colcon build --symlink-install $@ )
}

function nw-clean()
{
    (set -vx ; cd "${CURRENT_ROS_LOCAL_WORKSPACE}" && colcon clean workspace $@ )
}


# argcomplete for ros2 & colcon
# This link does the trick. I think it's the autoload doing the work 
# https://github.com/ros2/ros2cli/issues/534#issuecomment-957926737


# This two line matter for making auto complete work. But might need more stuff on a fresh new machine
# echo "Regiested Ros2 colcon argcomplete"
eval "$(register-python-argcomplete3 ros2)"
eval "$(register-python-argcomplete3 colcon)"

