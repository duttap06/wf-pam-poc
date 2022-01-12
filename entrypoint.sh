#!/bin/bash

/apps/jbpm/pamkie/add-wf-poc-users.sh

HOSTNAME=`hostname -I`

#sed -i "s/127.0.0.1/${HOSTNAME}/g" ${EAP_HOME}/standalone/configuration/standalone-full.xml
#sed -i "s/localhost/${HOSTNAME}/g" ${EAP_HOME}/standalone/configuration/standalone-full.xml

${EAP_HOME}/bin/standalone.sh -c standalone-full.xml
