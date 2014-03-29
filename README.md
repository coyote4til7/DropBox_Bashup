DropBox BashUp

a simple local and dropbox backup solution for small development projects

DropBox BashUp was created to provide 
  a simple backup solution for small development projects
that does
* frequently local backups (every 10 minutes, kept for two days)
* keeps zipped daily backups forever
* saves a copy of the daily zipped backup to DropBox
   
It's designed to be simple and dependable but, big projects...
better have a lot of disk space


----

Requirements/Supports

* Should run on any *nix OS (Linux, OS X, etc)
* Uses a few goodies that should be built-in (e.g. bash, cp)
* Uses DropBox uploader
  Project: https://github.com/andreafabrizi/Dropbox-Uploader

----


----

Setup

put this somewhere
* the crontab instructions below assume it's in ~/bin/DropBox_BashUp.sh

install DropBox uploader per:
* http://www.webupd8.org/2013/09/dropbox-uploader-012-$

tweak the configuration section (default config is for a WaveMaker project)

add it to your crontab
   > ] crontab -e
   >
   > */10 * * * * ~/bin/DropBox_BashUp.sh
   
To change how often DropBox Bashup runs, change that to match what you want

----


-----

That copyright thang

(c) 2014, Tim Wood (twood@edao.biz @coyote4til7)

This is LikeWare

Available for any use as long as all of this block (That copyright thang) 
including Like it is kept. Suggestions, fixes and improvements are welcome!

If you liked this, found it useful or just like spreading the words,
please check out some of the books I've helped create:

http://www.amazon.com/gp/collections/PCx6Sx7l150lD-vvcLqsbkPSA

Are you into local? Woo hoo!
Encourage your favorite bookstore to stock them!

Oh... and I love to see where my books end up
Who's hands are holding them? Where are they lurking?
Send me pictures!
@coyote4til7

----
