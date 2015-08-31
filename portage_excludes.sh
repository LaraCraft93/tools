#!/bin/bash
echo " * creating exclude list"

db=/var/db/pkg/*
ex=/etc/portage/rsync_excludes

# remove empty directories in /var/db/pkg/
rmdir $db 2>/dev/null

# whitelist system stuff
cat << EOF > $ex
+ eclass**
+ licenses**
+ profiles**
+ scripts**
+ virtual**
EOF

# whitelist used categories
for i in $db
do
    echo + `basename $i`** >> $ex
done

# blacklist everything else
cat << EOF >> $ex

**
EOF
