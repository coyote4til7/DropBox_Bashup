#!/bin/bash

# DropBox BashUp
#
# a simple local and dropbox backup solution for small development projects
# 
# DropBox BashUp was created to provide 
#   a simple backup solution for small development projects
# that does
#   frequently local backups (every 10 minutes, kept for two days)
#   keeps zipped daily backups forever
#   saves a copy of the daily zipped backup to DropBox
#    
# It's designed to be simple and dependable but, big projects...
# better have a lot of disk space


# ----
#
# Requirements/Supports
#
# Should run on any *nix OS (Linux, OS X, etc)
# Uses a few goodies that should be built-in (e.g. bash, cp)
# Uses DropBox uploader
#   Project: https://github.com/andreafabrizi/Dropbox-Uploader
#
# ----


# ----
#
# Setup
#
# put this somewhere
#   the crontab instructions below assume it's in ~/bin/DropBox_BashUp.sh
#
# install DropBox uploader per:
#   http://www.webupd8.org/2013/09/dropbox-uploader-012-released-bash.html
#
# tweak the configuration section (default config is for a WaveMaker project)
#
# add it to your crontab
#    > crontab -e
#    */10 * * * * ~/bin/DropBox_BashUp.sh
# To change how often DropBox Bashup runs, change that to match what you want
#
# ----


# -----
#
# That copyright thang
#
# (c) 2014, Tim Wood (twood@edao.biz @coyote4til7)
#
# This is LikeWare
#
# Available for any use as long as all of this block (That copyright thang) 
# including Like it is kept. Suggestions, fixes and improvements are welcome!
#
# If you liked this, found it useful or just like spreading the words,
# please check out some of the books I've helped create:
#
# http://www.amazon.com/gp/collections/PCx6Sx7l150lD-vvcLqsbkPSA
#
# Are you into local? Woo hoo!
# Encourage your favorite bookstore to stock them!
#
# Oh... and I love to see where my books end up
# Who's hands are holding them? Where are they lurking?
# Send me pictures!
# @coyote4til7
#
# ----      


# ----- 
#
# Version History
#
# 2014-03.28: Inital Release
# 2014-03.28: Minor change to documentation included in file, improvements
#     to handling deletion of older "hourly" files and addition of snarky
#     comment in version history
# 2014-04.08: Improvement to code to delete old "hourly" backups
# 2014-04.30: Bug fix on delete of old hourly backup (all issues appear solved)
#
# -----



# --------------------
# Configuration
# What we want to backup
dev_root="WaveMaker/projects"
project="BankwiseECT"

# Where we want it backed up
bkup_folder="Backups"
base="${bkup_folder}/projects/${project}/"

# logging file
# make sure you have permissions to write this file
log="/var/log/DropBox_Bashup.log"

# dropbox uploader and configuration
dbox_app="/usr/local/bin/dropbox_uploader"
dbox_path="Bankwise/Development_Backups"



# --------------------
# The Code

# Make sure we have the folders we need
mkdir -p $base/daily
mkdir -p $base/hourly

echo "$dhm running:" >> ${log}

# Config this backup
dhm=`date +%F.%H-%M`
dt=`date +%F`

# hourly backup
backup="$base/hourly/${dhm}"
cp -rf ${dev_root}/$project $backup 2>> $log

# Backup other stuff here
# e.g. a mysql/psql/etc database

# daily backup
ct=`ls ${base}/daily/ | grep ${dt} | grep zip | wc | awk '{print $1}'`
# echo ${ct}
if [ "${ct}" = "0" ]; then
    touch ${log}

    # make the daily backup
    echo "$dhm Create daily backup:" >> ${log}
    daily_zip_file="${dt}.zip"
    daily_zip="${base}/daily/${daily_zip_file}"
    zip -qr ${daily_zip} $backup >> ${log}

    # copy the daily backup to Dropbox
    echo "$dhm Copy daily backup to dropbox:" >> ${log}
    ${dbox_app} upload ${daily_zip} ${dbox_path}/${daily_zip_file} >> ${log}

    # Remove daily from prior months (other than the first)
    last_mth=`date +%d -d "30 day ago"`
    if [ "$last_mth" = "1" ]; then 
       echo "we keep the first backup of every month"
    else
      echo "${dhm} Removing the daily backup from last month" >> ${log}
      ayer=`date +%F -d "30 day ago"`
      rm ${base}/daily/${ayer}.zip 
    fi

    # remove "hourly" backups unless they are from day 0 (today) or day 1 (yesterday)
    pth=`cwd`
    cd ${base}/hourly/
    d0=`date +%F`
    d1=`date +%F -d "1 day ago"`
    ls | grep -v $d0 | grep -v $d1 | xargs /bin/rm -rf
    cd ${pth}
fi
