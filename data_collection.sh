#!/bin/sh

max=10000
num_iter=1
dataFolder="trainMap"
policyLoc="$HOME/Code/sorting-policy/models"

mark="kth"
policyName="rand"
mkdir data_gen

object=215
for i in `seq 1 $max`
do
    rosrun planner_tests box2d_alpha_sort --verbose --no-gui --pathInfo --num_iterations $num_iter \
	--problem src/planner_tests/data/${dataFolder}/${object}objs/$i.yaml \
	--infoFactor 3.0 \
	--infoDoc data_gen/${mark}-sortingData/${mark}-${policyName}-${object}/$i \
    --policy $policyLoc
    # --saveAllInfo
done
