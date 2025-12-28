#!/bin/bash
#SBATCH --job-name=NiSi_FinerRelaxation
#SBATCH --account=def-chihang
#SBATCH --ntasks-per-node=32    # number of MPI processes per node
#SBATCH --nodes=2              # number of nodes
#SBATCH --mem-per-cpu=10G       # memory
#SBATCH --time=0-15:00         # time (DD-HH:MM)
#SBATCH --output=vasp.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=dhett034@uottawa.ca


echo '-------------------Job starts at-------------------'
date "+%k:%M:%S %b-%d-%Y"
echo '---------------------------------------------------'


module load StdEnv/2023 intel/2023.2.1 openmpi/4.1.5
module load vasp/6.4.2
srun vasp_std


echo '--------------------Job ends at--------------------'
date "+%k:%M:%S %b-%d-%Y"
echo '---------------------------------------------------'
