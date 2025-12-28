#!/bin/bash
#SBATCH --job-name=NiSi_DOS_Fine
#SBATCH --account=def-chihang
#SBATCH --ntasks-per-node=32    # number of MPI processes per node
#SBATCH --nodes=2              # number of nodes
#SBATCH --mem-per-cpu=10G       # memory
#SBATCH --time=0-10:00         # time (DD-HH:MM)
#SBATCH --output=vasp.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=dhett034@uottawa.ca


echo '-------------------Job starts at-------------------'
date "+%k:%M:%S %b-%d-%Y"
echo '---------------------------------------------------'


module load StdEnv/2023 intel/2023.2.1 intelmpi/2021.9.0
module load vasp/6.4.2
srun vasp_std


echo '--------------------Job ends at--------------------'
date "+%k:%M:%S %b-%d-%Y"
echo '---------------------------------------------------'
