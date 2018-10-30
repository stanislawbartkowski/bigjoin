export LOGDIR=/tmp/log
mkdir -p $LOGDIR
#./bigsqltest.sh dimtable
./bigsqltest.sh nontable
#./bigsqltest.sh nonquery
#./bigsqltest.sh parttable
#./bigsqltest.sh partquery
if [ $? -ne 0 ]; then echo "FAILED"; else echo "PASSED"; fi
