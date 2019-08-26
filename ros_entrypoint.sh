#!/bin/bash
set -e

touch /test.txt
# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
source $ROS_DIR/setup.bash
exec "$@"

