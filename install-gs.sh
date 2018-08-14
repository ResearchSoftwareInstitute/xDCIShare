#!/bin/sh
# Add Ghostscript 9.06 (last GPL version; later versions are AGPL) for use with MyHPOM
GHOSTSCRIPT_URL=https://sourceforge.net/projects/ghostscript/files/GPL%20Ghostscript/9.06/ghostscript-9.06.tar.bz2
cd /usr/local/src
wget -q $GHOSTSCRIPT_URL
tar xjf ghostscript-9.06.tar.bz2
cd ghostscript-9.06
./configure -q >configure.log 2>&1
make -s install >make.log 2>&1
# and now we have the "gs" command on our system.