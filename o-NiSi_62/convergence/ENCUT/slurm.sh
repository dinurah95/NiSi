#!/bin/bash
#SBATCH --job-name=NiSi_62_ENCUT_ConvergenceRun
#SBATCH --account=def-chihang
#SBATCH --ntasks-per-node=32    # number of MPI processes per node
#SBATCH --nodes=1              # number of nodes
#SBATCH --mem-per-cpu=3G       # memory
#SBATCH --time=0-01:00         # time (DD-HH:MM)
#SBATCH --output=vasp.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=dhett034@uottawa.ca

echo '-------------------Job starts at-------------------'
date "+%k:%M:%S %b-%d-%Y"
echo '---------------------------------------------------'

# Load required modules
module load StdEnv/2023 intel/2023.2.1 intelmpi/2021.9.0
module load vasp/6.4.2

# Loop over the ENCUT values (200, 230, 260, ..., 520)
for encut in {200..530..30}
do
    # Create a directory for each ENCUT value
    mkdir -p ENCUT_$encut
    cp INCAR KPOINTS POSCAR POTCAR ENCUT_$encut/

    # Modify the INCUT value in the INCAR file for this loop iteration
    sed -i "s/ENCUT = .*/ENCUT = $encut/" ENCUT_$encut/INCAR

    # Change to the ENCUT-specific directory and run the job
    cd ENCUT_$encut

    # Run VASP Job
    echo "Running VASP for ENCUT = $encut"
    srun vasp_std

    # Return to the original directory
    cd ..
done

echo '--------------------Job ends at--------------------'
date "+%k:%M:%S %b-%d-%Y"
echo '---------------------------------------------------'

