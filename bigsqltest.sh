source ./bigsqltest.rc

LOGFILE=$LOGDIR/bigsqltest.log
BIGSQLCONNECT=

#set -x
#w

log() {
  echo $1
  echo $1 >>$LOGFILE
}

logfail() {
  log "$1"
  log "Exit immediately"
  exit 1
}

prepareconnectstring(){
   BIGSQLCONNECT=
   if [ -n "$BIGSQLPASSWORD" ]; then BIGSQLCONNECT="USER $BIGSQLUSER USING $BIGSQLPASSWORD"; fi
}

runscript() {
  local sc=$1
  local table=$2
  local size=$3
  local table1=$4
  log "Run $sc script"
  cat $sc | sed s/XXconnectXX/"$BIGSQLCONNECT"/g | sed s/XXtableXX/$table/g  | sed s/XXtable1XX/$table1/g | sed s/XXtablesizeXX/$size/g | sed s/XXstorageformatXX/"$TABLESTORAGE"/g | db2 -tv >>$LOGFILE
  [ $? -eq 0 ] || logfail "Cannot execute $sc"
}


droptable() {
  local table=$1
  log "Drop table $1"
  cat droptable.sql | sed s/XXconnectXX/"$BIGSQLCONNECT"/g | sed s/XXtableXX/$table/g | db2 -tv >>$LOGFILE
  # ignore result set
}

printhelp() {
  log "Usage :"
  log "$0 /param/"
  log "  param : "
  log "    nontable : create non partitioned table"
  log "    dimtable: create dimension table"
  log "    nonquery: run query on non partitioned table"
  log "    parttable : create partitioned table"
}


runnonquery() {
  runscript runnonquery.sql $BIGSQLTABLE1 ""  $BIGSQLDIMTABLE
}

runpartquery() {
  runscript runnonquery.sql $BIGSQLTABLE2 ""  $BIGSQLDIMTABLE
}

createnon() {
  droptable $BIGSQLTABLE1
  runscript createnonpartitionedtable.sql $BIGSQLTABLE1 $BIGSQLSIZE1
  runscript insertrows.sql $BIGSQLTABLE1 $BIGSQLSIZE1
}

createdim() {
  droptable $BIGSQLDIMTABLE
  runscript createdimtable.sql $BIGSQLDIMTABLE
}
# BIGSQLPARTSIZE

createnextpart() {
  local part=$1
  runscript createpartitionedtable.sql $BIGSQLTABLE2
}

createpart() {
  droptable $BIGSQLTABLE2
  runscript createpartitionedtable.sql $BIGSQLTABLE2
  runscript insertrows.sql $BIGSQLTABLE2 $BIGSQLSIZE1
}

prepareconnectstring

# main

case $1 in
  nontable) createnon;;
  dimtable) createdim;;
  nonquery) runnonquery;;
  parttable) createpart;;
  partquery) runpartquery;;
  *) printhelp; logfail "Parameter expected";;
esac
