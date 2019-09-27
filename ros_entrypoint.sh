#!/bin/bash
set -e

touch /test.txt
# setup ros environment
if [ -f /opt/ros/$ROS_DISTRO/setup.bash ]; then source "/opt/ros/$ROS_DISTRO/setup.bash"; fi
if [ -f $ROS_DIR/setup.bash ]; then source $ROS_DIR/setup.bash; fi
if [ -f $ROS_DIR/devel/setup.bash ]; then source $ROS_DIR/devel/setup.bash; fi
exec "$@"
