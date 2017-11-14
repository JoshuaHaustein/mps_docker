Installation:

Pull this repository and fetch all submodules
```
git clone <this-repo>
cd <this-repo>
git submodule init
git submodule update --recursive
```

Follow the instructions on https://github.com/JoshuaHaustein/box2d_catkin/blob/master/README.md how to properly
set up the folder ```box2d_catkin```. Start from the ```git submodule``` section.

Build and run the docker image:

```
docker build . -t planner
docker run -it -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 -v /tmp/.X11-unix:/tmp/.X11-unix planner bash
```

Inside the container, you can then run for example:
```
rosrun planner_tests box2d_push_planner --planning_problem src/planner_tests/data/box2d/planning_problems/obstacle_wall_problem.yaml
```
