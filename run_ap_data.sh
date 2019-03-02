#! /bin/bash -l
 
#SBATCH --partition=panda   # cluster-specific
#SBATCH --nodes=1 
#SBATCH --ntasks=1
#SBATCH --job-name=hello_slurm
#SBATCH --time=00:02:00   # HH/MM/SS
#SBATCH --mem=1G   # memory requested, units available: K,M,G,T
 
source ~/.bashrc
 
echo "Starting at:" `date` >> hello_slurm_output.txt
sleep 30
echo "This is job #:" $SLURM_JOB_ID >> hello_slurm_output.txt
echo "Running on node:" `hostname` >> hello_slurm_output.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> hello_slurm_output.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> hello_slurm_output.txt
 
exit
