# This is an auto generated Dockerfile for ros:desktop-full
# generated from docker_images/create_ros_image.Dockerfile.em
FROM osrf/ros:kinetic-desktop-xenial

# install ros packages
RUN apt-get update && apt-get install -y \
    ros-kinetic-desktop-full=1.3.2-0*

RUN apt-get update --fix-missing

RUN apt-get install \
    ros-kinetic-serial -y \
    ros-kinetic-bfl -y \
    ros-kinetic-urg-c -y \
    ros-kinetic-laser-proc -y \
    ros-kinetic-move-base-msgs -y \
    ros-kinetic-ecl -y \
    libsdl-image1.2-dev -y \
    ros-kinetic-ros-control ros-kinetic-ros-controllers \
    ros-kinetic-gazebo-ros-control ros-kinetic-laser-proc \
    ros-kinetic-hector-gazebo-plugins -y \
    ros-kinetic-navigation-layers -y \
    ros-kinetic-hector-models -y \
    ros-kinetic-robot-pose-publisher -y \
    ros-kinetic-tf2-web-republisher -y \
    ros-kinetic-rosapi -y \
    ros-kinetic-rosauth -y \
    ros-kinetic-rosbridge-library -y \
    python-wstool -y \
    python-pandas -y \
    wget
RUN apt-get install vim -y
RUN ln -s /usr/include/gazebo-7/gazebo/ /usr/include/gazebo
RUN ln -s /usr/include/sdformat-4.0/sdf/ /usr/include/sdf
RUN ln -s /usr/include/ignition/math2/ignition/math.hh /usr/include/ignition/math.hh
RUN ln -s /usr/include/ignition/math2/ignition/math /usr/include/ignition/math

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get install nodejs iputils-ping -y

RUN  apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}
#ENV QT_DEVICE_PIXEL_RATIO=1

RUN bash -c 'echo "source \$ROS_DIR/devel/setup.bash" >> /root/.bashrc'
RUN bash -c 'echo "export QT_DEVICE_PIXEL_RATIO=1" >> /root/.bashrc'
ENV ALIAS_DEF '"cd $ROS_DIR"'
RUN bash -c 'echo "alias ros=${ALIAS_DEF}" >> /root/.bashrc'

ADD ./alias.txt /root/alias
RUN bash -c 'echo "source /root/alias" >> /root/.bashrc'
