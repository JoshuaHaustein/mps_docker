#!/bin/sh

max=10000
num_iter=1
dataFolder="trainMap"
policyLoc="$HOME/Code/sorting-policy/models"

mark="kth"
policyName="rand"
classes=2
objects=15
mkdir data_gen

# generate worlds
python3 src/planner_tests/python/scripts/sorting/yumi_generator.py --useFor ${dataFolder} --cls ${classes} \
	--obj ${objects} --num ${max} --output_path src/planner_tests/data/

for i in `seq 1 $max`
do
    rosrun planner_tests box2d_alpha_sort --verbose --no-gui --pathInfo --num_iterations $num_iter \
	--problem src/planner_tests/data/${dataFolder}/${classes}${objects}objs/$i.yaml \
	--infoFactor 3.0 \
	--infoDoc data_gen/${mark}-sortingData/${mark}-${policyName}-${classes}${objects}/$i \
    --policy $policyLoc
    # --saveAllInfo
done
