#! /bin/bash
#
# $Id: databackup.sh 3 2008-11-24 16:34:48Z Michele Sanges <michele.sanges@otomelara.it> $
# $Author: Michele Sanges <michele.sanges@otomelara.it> $
# $Date: 2008-11-24 17:34:48 +0100 (lun, 24 nov 2008) $
# $Rev: 3 $


if [ $# -lt 2 ]  # must have two arguments
then
	echo "Please invoke this script with two argument."
	echo "Usage: $0	source_path dest_path]"
	exit -1
fi  

# paths of the source and destination directories
SOURCE_PATH=$1
DEST_PATH=$2

# last char of SOURCE_PATH
POS=${#SOURCE_PATH}
CHAR=$(echo $SOURCE_PATH | cut -c$POS)
# if it isn't a '/', adds it
if [ "$CHAR" != "/" ]; then
	SOURCE_PATH=$(echo $SOURCE_PATH"/")
fi

# last char of DEST_PATH
POS=${#DEST_PATH}
CHAR=$(echo $DEST_PATH | cut -c$POS)
# if it isn't a '/', adds it
if [ "$CHAR" != "/" ]; then
	DEST_PATH=$(echo $DEST_PATH"/")
fi

# rsync command
rsync -avh --delete --progress $SOURCE_PATH $DEST_PATH

# file with the date and time of the backup
touch $DEST_PATH"backup_"$(date +%Y%m%d)_$(date +%H:%M:%S)

sync

