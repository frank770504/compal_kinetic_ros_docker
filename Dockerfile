# This is an auto generated Dockerfile for ros:desktop-full
# generated from docker_images/create_ros_image.Dockerfile.em
FROM osrf/ros:kinetic-desktop-xenial

ARG DEBIAN_FRONTEND=noninteractive

# install ros packages
RUN apt-get update --fix-missing && apt-get install -y \
    ros-kinetic-desktop-full=1.3.2-0*

RUN apt-get update && apt-get install -y \
        ros-kinetic-serial \
        ros-kinetic-bfl \
        ros-kinetic-urg-c \
        ros-kinetic-laser-proc \
        ros-kinetic-move-base-msgs \
        ros-kinetic-ecl \
        libsdl-image1.2-dev \
        ros-kinetic-ros-control ros-kinetic-ros-controllers \
        ros-kinetic-gazebo-ros-control ros-kinetic-laser-proc \
        ros-kinetic-hector-gazebo-plugins \
        ros-kinetic-navigation-layers \
        ros-kinetic-hector-models \
        ros-kinetic-robot-pose-publisher \
        ros-kinetic-tf2-web-republisher \
        ros-kinetic-rosapi \
        ros-kinetic-rosauth \
        ros-kinetic-rosbridge-library \
        python-wstool \
        python-pandas \
        python-bloom \
        wget -y

#nvidia-docker-2 necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
        pkg-config \
        libxau-dev \
        libxdmcp-dev \
        libxcb1-dev \
        libxext-dev \
        libx11-dev

RUN apt-get update && apt-get install apt-utils -y
RUN apt-get update && apt-get install ros-kinetic-grid-map -y
RUN apt-get update && apt-get install ros-kinetic-joy -y
RUN apt-get update && apt-get install python-rosdep ninja-build -y
RUN apt-get update && apt-get install doxygen -y
RUN apt-get update && apt-get install python-igraph -y
RUN apt-get update && apt-get install python-sphinx -y
RUN apt-get update && apt-get install protobuf-compiler -y
RUN apt-get update && apt-get install libgflags-dev -y
RUN apt-get update && apt-get install libatlas-base-dev -y
RUN apt-get update && apt-get install libsuitesparse-dev -y
RUN apt-get update && apt-get install libgoogle-glog-dev -y
RUN apt-get update && apt-get install liblua5.2-dev -y

RUN apt-get install vim -y
RUN ln -s /usr/include/gazebo-7/gazebo/ /usr/include/gazebo
RUN ln -s /usr/include/sdformat-4.0/sdf/ /usr/include/sdf
RUN ln -s /usr/include/ignition/math2/ignition/math.hh /usr/include/ignition/math.hh
RUN ln -s /usr/include/ignition/math2/ignition/math /usr/include/ignition/math

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install nodejs iputils-ping -y

#RUN npm install npm@5.5.1 -g
RUN npm install forever -g

RUN  apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

#nvidia-docker-2 necessary files
COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 \
  /usr/local/lib/x86_64-linux-gnu \
  /usr/local/lib/x86_64-linux-gnu

COPY --from=nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04 \
  /usr/local/share/glvnd/egl_vendor.d/10_nvidia.json \
  /usr/local/share/glvnd/egl_vendor.d/10_nvidia.json

RUN echo '/usr/local/lib/x86_64-linux-gnu' >> /etc/ld.so.conf.d/glvnd.conf && \
    ldconfig && \
    echo '/usr/local/$LIB/libGL.so.1' >> /etc/ld.so.preload && \
    echo '/usr/local/$LIB/libEGL.so.1' >> /etc/ld.so.preload

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

#LABEL com.nvidia.volumes.needed="nvidia_driver"
#ENV PATH /usr/local/nvidia/bin:${PATH}
#ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}
#ENV QT_DEVICE_PIXEL_RATIO=1

RUN bash -c 'echo "source \$ROS_DIR/devel/setup.bash" >> /root/.bashrc'
RUN bash -c 'echo "export QT_DEVICE_PIXEL_RATIO=1" >> /root/.bashrc'
ENV ALIAS_DEF '"cd $ROS_DIR"'
RUN bash -c 'echo "alias ros=${ALIAS_DEF}" >> /root/.bashrc'

ADD ./alias.txt /root/alias
RUN bash -c 'echo "source /root/alias" >> /root/.bashrc'
