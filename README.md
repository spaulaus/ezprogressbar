Overview
--------
ezProgressBar is really 3 C++ progress classes. See the [homepage][1].

[1]: http://ezprogressbar.sourceforge.net/

Testing
-------
   make

Publishing
----------
   make html; make clean
   make dist VER=2.1.0
   scp html/*.html ez*Bar.hpp rsz@web.sourceforge.net://home/project-web/ezprogressbar/htdocs

   # Log on to manage webpage.
   ssh -t rsz,ezprogressbar@shell.sourceforge.net create
   cd /home/project-web/ezprogressbar/htdocs
