#!/bin/bash

# Typically I would not encourage setup of a swap file on a web server
# but in our specific case it's okay. Composer (package installer)
# is a resource hog when first deploying and we need the swap
# just for that part -- better than firing up larger-than-necessary
# instances just so we can deploy and then run over-resourced 99%
# of the time.
#
# @coogle

SWAPFILE=/var/swapfile
SWAP_MEGABYTES=2048

if [ -f $SWAPFILE ]; then
	echo "Swapfile $SWAPFILE found, assuming already setup"
	exit;
fi

/bin/dd if=/dev/zero of=$SWAPFILE bs=1M count=$SWAP_MEGABYTES
/bin/chmod 600 $SWAPFILE
/sbin/mkswap $SWAPFILE
/sbin/swapon $SWAPFILE