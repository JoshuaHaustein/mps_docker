# Examples:
# ./run_experiments.sh obstacle_wall learned 250
# ./run_experiments.sh kth human 1
# ./run_experiments.sh slalom learned 100
export problem=$1
export oracle=$2
export num_iterations=$3
export problem_file=src/planner_tests/data/box2d/planning_problems/${problem}_problem_${oracle}.yaml
export output_file=results/${problem}_${oracle}.csv
echo Starting runs with $problem_file
echo Writing results to $output_file
if [ ! -d results ]; then
    mkdir results
fi
rosrun planner_tests box2d_push_planner \
    --planning_problem $problem_file \
    --output_file $output_file \
    --num_iterations $num_iterations \
    --no-gui
