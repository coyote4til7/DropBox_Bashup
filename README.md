DropBox_Bashup
==============

a simple local and dropbox backup solution for small development projects

DropBox BashUp was created to provide 
  a simple backup solution for small development projects
that does
  frequently local backups (every 10 minutes, kept for two days)
  keeps zipped daily backups forever
  saves a copy of the daily zipped backup to DropBox
   
It's designed to be simple and dependable but, big projects...
better have a lot of disk space


Requirements/Supports

Should run on any *nix OS (Linux, OS X, etc)
Uses a few goodies that should be built-in (e.g. bash, cp)
Uses DropBox uploader
  Project: https://github.com/andreafabrizi/Dropbox-Uploader


Setup

put the script somewhere
  the crontab instructions below assume it's in ~/bin/DropBox_BashUp.sh

install DropBox uploader per:
  http://www.webupd8.org/2013/09/dropbox-uploader-012-$

tweak the configuration section (default config is for a WaveMaker project)

add it to your crontab
   > crontab -e
   */10 * * * * ~/bin/DropBox_BashUp.sh
if you want to change how often it runs, change to match what you want


That copyright thang

(c) 2014, Tim Wood (twood@edao.biz @coyote4til7)

Available for any use as long as all of this block (That copyright thang) 
including Like it (below) is kept

Suggestions, fixes and improvements welcome.


Like it?
Enough to pay for it? 
So much you want to throw money at me? Oh wow. You are cool!
Buy me a gift or buy something I helped create:
http://amzn.com/w/3JYNSVPIEGSFP
http://www.amazon.com/gp/collections/PCx6Sx7l150lD-vvcLqsbkPSA
