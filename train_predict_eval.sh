#=====================================
# SuperLearner launch script
#=====================================
# The user must specify:
# 1) the training/testing data set,
# 2) the number of inputs
# 3) the SuperLearner configuration,
# 4) the working directory,
# 5) Boolean flags (HPO, CV, SMOGN, ONNX) 
# For example:
#
# train_predict_eval.sh /path/to/data.csv \  #-----Core params------
#               $NUM_INPUTS
#               /path/to/sl_conf.py \
#               /path/to/work_dir \
#               $HPO_true_or_false \         #-----Bool opts---------
#               $CV_true_or_false \
#               $SMOGN_true_or_false \
#               $ONNX_true_or_false \
#               $NUM_JOBS \                  #-----HPC opts----------
#               $BACKEND \
#               $PREDICT_VAR \               #-----Predict opts------
#               /path/to/predict_data.csv
#====================================

echo Starting $0
echo Options for ONNX and SMOGN are currently ignored!

#====================================
# Command line requirements
#====================================
# Define the training data (input)
input_data=$1

# Set the number of inputs
num_inputs=$2

# Set the SuperLearner configuration
sl_conf=$3

# Define the work dir (where to run and put output)
work_dir=$4

# Workflow boolean options (all either True or False)
hpo=$5
cv=$6
smogn=$7
onnx=$8

# HPC options
num_jobs=$9
backend=$10

# Predict options
predict_var=$11
predict_data=$12

#===================================
# Conda activate and log env
#===================================
# Location/name of Conda env is hard
# coded and assumed to match
# build_conda_env.sh
my_env="sl_onnx"
miniconda_loc="/home/$(whoami)/.miniconda3"
source ${miniconda_loc}/etc/profile.d/conda.sh
conda activate $my_env
conda list -e > ${work_dir}/requirements.txt

#===================================
# Run the SuperLearner
#===================================
python -m main \
       --conda_sh "${miniconda_loc}/etc/profile.d/conda.sh" \
       --superlearner_conf $sl_conf \
       --n_jobs $num_jobs \
       --num_inputs $num_inputs \
       --cross_val_score $cv \
       --model_dir ${work_dir} \
       --hpo $hpo \
       --data ${input_data} \
       --backend $backend 1> ${work_dir}/std.out 2> ${work_dir}/std.err

#===================================
# Print out information about the
# model and make predictions
#===================================

# WORKING HERE

#===================================
# Run PCA on predictions
#===================================

# WORKING HERE

#===================================
# Compress outputs
#===================================

cd $work_dir
# WORKING HERE
ls

#===================================
echo $0 finished!
