#! /bin/bash -l
 
#SBATCH --partition=panda   # cluster-specific
#SBATCH --nodes=1 
#SBATCH --ntasks=5
#SBATCH --job-name=christini-job
#SBATCH --time=04:00:00   # HH/MM/SS
#SBATCH --mem=1G   # memory requested, units available: K,M,G,T
 
source ~/.bashrc
 
echo "Starting at:" `date` >> population_output.txt
sleep 30
echo "This is job #:" $SLURM_JOB_ID >> population_output.txt
echo "Running on node:" `hostname` >> population_output.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> population_output.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> population_output.txt

/softlib/exe/x86_64/pkg/matlab/2018b/bin/matlab -r "run('test.m')"

run("test.m")
 
exit