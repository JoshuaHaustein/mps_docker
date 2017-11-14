FROM ros:lunar-ros-base-zesty

RUN apt-get update && apt-get install -y \
    wget \
    libboost-all-dev \
    libboost-mpi-python-dev \
    libyaml-cpp-dev \
    libeigen3-dev \
    qt4-dev-tools \
    libprotobuf-dev \
    protobuf-compiler \
    virtualenv \
    clang-3.8 \
    vim \
    sudo

RUN ln -s /usr/bin/clang++-3.8 /usr/bin/clang++
RUN ln -s /usr/bin/clang-3.8 /usr/bin/clang

# Install OMPL
ARG OMPL_DIR=/ompl
RUN mkdir $OMPL_DIR
WORKDIR $OMPL_DIR
RUN wget http://ompl.kavrakilab.org/install-ompl-ubuntu.sh
RUN chmod u+x install-ompl-ubuntu.sh
RUN /bin/bash -c './install-ompl-ubuntu.sh'

RUN useradd -ms /bin/bash ros

ARG WS=/home/ros/catkin_ws
WORKDIR $WS
RUN mkdir src
WORKDIR $WS/src
ADD planning_catkin             planning_catkin
ADD box2d_catkin                box2d_catkin
ADD box2d_sim_env               box2d_sim_env
ADD planner_tests               planner_tests
ADD sim_env                     sim_env
WORKDIR /home/ros
ADD oracle                      oracle
RUN chown -R ros ./

USER ros
WORKDIR $WS/src
RUN /bin/bash -c '. /opt/ros/lunar/setup.bash; catkin_init_workspace'
WORKDIR $WS
RUN /bin/bash -c '. /opt/ros/lunar/setup.bash; catkin_make'
RUN /bin/bash -c 'echo source ${WS}/devel/setup.bash >> /home/ros/.bashrc'

WORKDIR /home/ros/oracle
RUN virtualenv -p python3.5 venv
RUN /bin/bash -c '. venv/bin/activate; pip install http://download.pytorch.org/whl/cu75/torch-0.2.0.post3-cp35-cp35m-manylinux1_x86_64.whl'
RUN /bin/bash -c '. venv/bin/activate; pip install -e .'

RUN /bin/bash -c 'echo source /home/ros/oracle/setup.sh >> /home/ros/.bashrc'
RUN /bin/bash -c 'echo "cd /home/ros/oracle; venv/bin/python python_src/server.py &> /dev/null &" >> /home/ros/.bashrc'
RUN /bin/bash -c 'echo "cd /home/ros/catkin_ws" >> /home/ros/.bashrc'