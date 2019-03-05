#! /bin/bash -l

CURRI=$1
 
#SBATCH --partition=panda   # cluster-specific
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=christini-job
#SBATCH --time=00:02:00   # HH/MM/SS
#SBATCH --mem=1G
 
source ~/.bashrc
 
echo "Starting at:" `date` >> population_output.txt
sleep 30
echo "This is job #:" $SLURM_JOB_ID >> population_output.txt
echo "Running on node:" `hostname` >> population_output.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> population_output.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> population_output.txt

# SLURM_ARRAY_JOB_ID will be set to the first job ID of the array. 
# SLURM_ARRAY_TASK_ID will be set to the job array index value.

printf "${SLURM_ARRAY_TASK_ID}"
printf "${SLURM_ARRAY_JOB_ID}"
printf "test" 
 
exit
