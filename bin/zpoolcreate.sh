 ~/bin/all_sd_disks_to_one_line.sh | sed 's|^|sudo zpool create mypool mirror |g;s|$| -f |g'

