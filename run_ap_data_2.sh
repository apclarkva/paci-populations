# #! /bin/bash -l

CURRI=$1
 
# #SBATCH --partition=panda   # cluster-specific
# #SBATCH --nodes=6
# #SBATCH --ntasks=200
# #SBATCH --job-name=christini-job
# #SBATCH --time=04:00:00   # HH/MM/SS
# #SBATCH --mem=1G
 
# source ~/.bashrc
 
# echo "Starting at:" `date` >> population_output.txt
# sleep 30
# echo "This is job #:" $SLURM_JOB_ID >> population_output.txt
# echo "Running on node:" `hostname` >> population_output.txt
# echo "Running on cluster:" $SLURM_CLUSTER_NAME >> population_output.txt
# echo "This job was assigned the temporary (local) directory:" $TMPDIR >> population_output.txt

# /softlib/exe/x86_64/pkg/matlab/2018b/bin/matlab -r "run('main_ventricular.m')"
 
# exit

printf $CURRI

# /softlib/exe/x86_64/pkg/matlab/2018b/bin/matlab -r "run('test()')"

# /softlib/exe/x86_64/pkg/matlab/2018b/bin/matlab -r "test(${CURRI})"

/Applications/MATLAB_R2018b.app/bin/matlab -nodisplay -nosplash -nodesktop -r "main_vent(${CURRI})"