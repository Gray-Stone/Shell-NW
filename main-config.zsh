#! /usr/bin/zsh

# Source the ros stuff and include a waring print out 

# Yes using ros2 iron version
source_if_exists "/opt/ros/iron/setup.zsh" true

# This is from previous interbotix stuff
# source_if_exists "${HOME}/ws/interbotix/install/setup.zsh" true

# CURRENT_ROS_WORKSPACE="$(realpath ${HOME}/495-hw-workspace)"
CURRENT_ROS_WORKSPACE="$(realpath ${HOME}/OneDrive/Active-file/NW-classes/ME495-slam/slam-project-me495/)"
ALT_ROS_WORKSPACE="$(realpath ${HOME}/OneDrive/Active-file/NW-classes/winter-proj/switch-flipper)"

source_if_exists "${CURRENT_ROS_WORKSPACE}/install/setup.zsh" true

# source_if_exists "${HOME}/robots-ws/franka-ws/install/setup.zsh" true

function source_winter()
{
source_if_exists "${ALT_ROS_WORKSPACE}/install/setup.zsh" true
source_if_exists "${HOME}/robots-ws/interbotix/install/setup.zsh" true
}

function nw-cbuild()
{
    set -xv
    WORKSPACE_USAGE="${CURRENT_ROS_WORKSPACE}"
    if [[ "${1}" == "alt" ]]; then
        echo "Building ALT workspace"
        shift;
        WORKSPACE_USAGE="${ALT_ROS_WORKSPACE}"
    fi
    (set -vx ; cd "${WORKSPACE_USAGE}" && colcon build --symlink-install $@ )
}

function nw-clean()
{
    WORKSPACE_USAGE="${CURRENT_ROS_WORKSPACE}"
    if [[ "${1}" == "alt" ]]; then
        echo "cleaning ALT workspace"
        shift;
        WORKSPACE_USAGE="${ALT_ROS_WORKSPACE}"
    fi

    (set -vx ; cd "${WORKSPACE_USAGE}" && colcon clean workspace $@ )
}

function nw-ctest()
{    
    set -xv
    WORKSPACE_USAGE="${CURRENT_ROS_WORKSPACE}"
    if [[ "${1}" == "alt" ]]; then
        echo "Testing ALT workspace"
        shift;
        WORKSPACE_USAGE="${ALT_ROS_WORKSPACE}"
    fi

    (set -vx ; cd "${WORKSPACE_USAGE}" && colcon test $@ )
}

COLCON_CONSOLE_ARGS="--event-handlers console_direct+"


# argcomplete for ros2 & colcon
# This link does the trick. I think it's the autoload doing the work 
# https://github.com/ros2/ros2cli/issues/534#issuecomment-957926737


# This two line matter for making auto complete work. But might need more stuff on a fresh new machine
# echo "Regiested Ros2 colcon argcomplete"
eval "$(register-python-argcomplete3 ros2)"
eval "$(register-python-argcomplete3 colcon)"

