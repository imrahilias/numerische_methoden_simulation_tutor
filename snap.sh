#!/bin/sh

ssh msiegel@server4.physprak.tuwien.ac.at:/home/EDV2/

for i in edvdi{36,38,39,40,41,42,44,45,47,48,49,50,51,53,54,55,56,58,59,77,95}
do
    echo "snapshooting $i"

    ## enter directory
    cd $i

    ## make new directory
    mkdir -p tutoren

    ## copy everything except the dir itself into 'tutoren'
    find * ! -regex "tutoren.*" -exec cp -rv {} tutoren \;

    ## lock everything in 'tutoren'
    chmod -R 744 tutoren
    
    ## write snapshot readme
    echo "moritz siegel @ $(date "+%y%m%d%H%M")

snapshot taken, later corrections will not be taken into account!

should you need more time to finish this exercise, please write to 
moritz.siegel@tuwien.ac.at, or directly to the professor in charge." > readme.md
    
    cd ..
    
done
