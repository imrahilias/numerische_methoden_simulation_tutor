#!/bin/sh

hd="/mnt/troika/uni/numerische_methoden_simulation_tutor"

## for testing add "--list-only \"
rsync -aP \
      --include-from=$hd/sync_groups \
      --exclude='/*/' \
      msiegel@server4.physprak.tuwien.ac.at:/home/EDV2/ \
      $hd/groups/ \
    |& tee $hd/log/rsync_$(date "+%y%m%d%H%M").log
