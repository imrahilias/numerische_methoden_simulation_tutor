# gotomeeting id

## nms prof channel

960767765


# vpn

sudo openconnect -u e0913499@student.tuwien.ac.at vpn.tuwien.ac.at
***Tu21


# account

sshfs msiegel@server4.physprak.tuwien.ac.at:/home/EDV2 /mnt/nms
***ns


# copy everything

scp -r "msiegel@server4.physprak.tuwien.ac.at:/home/EDV2/edv2di[3-9][0-9]/" ~/uni/numerische_methoden_simulation_tutor/groups |& tee ~/uni/numerische_methoden_simulation_tutor/log/nmscp_$(date "+%y%m%d%H%M").log
scp -r "msiegel@server4.physprak.tuwien.ac.at:/home/EDV2/edv2di00/" ~/uni/numerische_methoden_simulation_tutor/groups |& tee ~/uni/numerische_methoden_simulation_tutor/log/nmscp_$(date "+%y%m%d%H%M").log
***ns


# keep wanted

mv edv2di(36|38|39|42|44|45|47|48|49|50|51|53|54|55|56|58|59|77|95) .
rm -rf edv2*


# rsync?
