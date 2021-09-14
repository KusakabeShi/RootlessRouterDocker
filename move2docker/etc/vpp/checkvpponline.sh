#!/bin/bash
. /.denv
result=`vppctl show int loop${VPP_LOOPID} addr | grep L3`
if [ -z "$result" ] ; then 
    echo "VPP not ready" ;
    exit -1
fi
exit 0
