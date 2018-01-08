# Examples:
# ./run_experiments.sh obstacle_wall Learned SliceOracleRRT 250
# ./run_experiments.sh kth Human CompleteSliceOracleRRT 1
# ./run_experiments.sh slalom Learned SliceOracleRRT 100
export problem=$1
export oracle=$2
export algorithm=$3
export num_iterations=$4
export template_path=src/planner_tests/data/box2d/planning_problems/${problem}_template.yaml
export problem_file=src/planner_tests/data/box2d/planning_problems/experiment_world.yaml
export output_file=results/${problem}_${oracle}_${algorithm}.csv
echo Writing results to $output_file
if [ ! -d results ]; then
    mkdir results
fi

rosrun planner_tests generate_experiment_world.py \
    --template_path $template_path \
    --algorithm $algorithm \
    --oracle_type $oracle

rosrun planner_tests box2d_push_planner \
    --planning_problem $problem_file \
    --output_file $output_file \
    --num_iterations $num_iterations \
    --no-gui
