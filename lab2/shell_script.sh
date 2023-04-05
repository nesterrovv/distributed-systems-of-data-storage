# initialize necessary system variables

PGDATA=$HOME/u01/gsd65  # directory of database cluster
PGENCODE=KOI8-R         # encoding
PGLOCALE=ru_RU.KOI8-R   # locale
PGUSERNAME=postgres1   # username

export PGDATA PGLOCALE PGENCODE PGUSERNAME                                 # export system variables
mkdir -p $PGDATA                                                            # move to directory for cluster storing
chown postgres1 $PGDATA                                                     # change owner of this direcrory
initdb --encoding=$PGENCODE  --locale=$PGLOCALE --username=$PGUSERNAME     # initialize database cluter

# download cluster configuration files for editing
scp postgres1@pg102:u01/gsd65/postgresql.conf /home/s312621/distrubuted-systems-of-data-storage/lab2    # postgresql.conf downloading
scp postgres1@pg102:u01/gsd65/pg_hba.conf     /home/s284731/distrubuted-systems-of-data-storage/lab2    # pg_hba.conf     downloading


# configuration files changing...


scp /home/s312621/distrubuted-systems-of-data-storage/lab2/postgresql.conf      postgres1@pg102:u01/gsd65/               # postgresql.conf uploading
scp /home/s284731/distrubuted-systems-of-data-storage/lab2/pg_hba.conf          postgres1@pg102:u01/gsd65/pg_hba.conf    # pg_hba.conf     uploading


psql -p 9006 -d template1 -h pg102 -U postgres1                         # authorization of root user

# necessary tablespaces creating
CREATE TABLESPACE tablespace1 LOCATION '/var/db/postgres1/u03/gsd65';
CREATE TABLESPACE tablespace2 LOCATION '/var/db/postgres1/u04/gsd65';
CREATE TABLESPACE tablespace3 LOCATION '/var/db/postgres1/u05/gsd65';

# database creating
CREATE DATABASE greatercapybara WITH TEMPLATE = template0;

# role creating. Authorization for it has been configuried yet
CREATE ROLE s312621 LOGIN PASSWORD 'PASSWORD';

# authorizarion in created database as s312621 user (via created role)
psql -h pg102 -d greatercapybara -p 9006 -U s312621

# some data manipulations in PSQL...