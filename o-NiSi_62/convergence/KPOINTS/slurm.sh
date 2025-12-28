#!/bin/bash
#SBATCH --job-name=NiSi_62_KPOINTS_ConvergenceTest
#SBATCH --account=def-chihang
#SBATCH --ntasks-per-node=32    # number of MPI processes per node
#SBATCH --nodes=1              # number of nodes
#SBATCH --mem-per-cpu=10G       # memory
#SBATCH --time=0-05:00         # time (DD-HH:MM)
#SBATCH --output=vasp.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=dhett034@uottawa.ca

echo '-------------------Job starts at-------------------'
date "+%k:%M:%S %b-%d-%Y"
echo '---------------------------------------------------'

# Load required modules
module load StdEnv/2023 intel/2023.2.1 intelmpi/2021.9.0
module load vasp/6.4.2

# Loop over the KPOINTS values (4 4 4, 6 6 6, ..., 20 20 20)
for k in {26..28..2}
do
    # Create a directory for each KPOINTS value
    mkdir -p KPOINTS_$k
    cp INCAR POSCAR POTCAR KPOINTS_$k/

    # Modify the KPOINTS file for this loop iteration
    echo -e "Automatic mesh\n0\nGamma\n$k $k $k\n0\n" > KPOINTS_$k/KPOINTS

    # Change to the KPOINTS-specific directory
    cd KPOINTS_$k

    # Run the VASP job
    echo "Running VASP for KPOINTS = $k $k $k"
    srun vasp_std

    # Return to the original directory
    cd ..
done

echo '--------------------Job ends at--------------------'
date "+%k:%M:%S %b-%d-%Y"
echo '---------------------------------------------------'
