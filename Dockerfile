FROM registry.access.redhat.com/ubi8-minimal:8.5-204
USER root

# Get EAP


ENV EAP_HOME=/apps/jbpm/pamkie/jboss-eap-7.3 \
    XDG_CONFIG_HOME=/apps/jbpm/pamkie \
    WORKDIR=/apps/jbpm/pamkie

RUN mkdir -p ${WORKDIR}/scratchpad && chmod -R 750 ${WORKDIR}

#LABEL io.openshift.expose-services="8080:business-central,9990:jboss-eap"

WORKDIR /tmp

ADD jboss-eap-7.3.9-patch.zip jboss-eap-7.3.0.zip \
    rhpam-7.11.1-kie-server-ee8.zip \
#   rhpam-7.11.1-business-central-eap7-deployable.zip \
#   rhpam-7.11.1-dashbuilder-runtime.zip \
    standalone-full.xml add-wf-poc-users.sh entrypoint.sh /tmp

RUN microdnf -y install unzip java hostname bind-utils iproute libaio && \
    microdnf update && \
    microdnf clean all && \
    unzip -o /tmp/jboss-eap-7.3.0.zip -d ${WORKDIR} && \
    rm -rf /tmp/jboss-eap-7.3.0.zip && \
    chmod a+x ${EAP_HOME}/bin/jboss-cli.sh && \
    ${EAP_HOME}/bin/jboss-cli.sh --command="patch apply /tmp/jboss-eap-7.3.9-patch.zip" && \
    unzip -o /tmp/rhpam-7.11.1-kie-server-ee8.zip -d ${EAP_HOME}/standalone/deployments && \
    rm -rf /tmp/rhpam-7.11.1-kie-server-ee8.zip && \
#   unzip -o /tmp/rhpam-7.11.1-business-central-eap7-deployable.zip -d ${WORKDIR} && \
#   rm -rf /tmp/rhpam-7.11.1-business-central-eap7-deployable.zip && \
#   unzip -o /tmp/rhpam-7.11.1-dashbuilder-runtime.zip -d ${EAP_HOME}/standalone/deployments && \
#   rm -rf /tmp/rhpam-7.11.1-dashbuilder-runtime.zip && \
    touch $EAP_HOME/standalone/deployments/kie-server.war.dodeploy && \
#   touch $EAP_HOME/standalone/deployments/business-central.war.dodeploy && \
#   touch $EAP_HOME/standalone/deployments/dashbuilder-runtime.war.dodeploy && \
    mv ${EAP_HOME}/standalone/deployments/SecurityPolicy/* ${EAP_HOME}/bin && \
    mv /tmp/add-wf-poc-users.sh /tmp/entrypoint.sh ${WORKDIR} && \
#   mv -f /tmp/standalone-full.xml ${EAP_HOME}/standalone/configuration && \
    rm -rf ${EAP_HOME}/standalone/deployments/SecurityPolicy && \
    chown -R 1001:root ${WORKDIR} && \
    chgrp -R 0 ${WORKDIR} && \
    chmod -R g=u ${WORKDIR} && \
    chmod a+x ${WORKDIR}/add-wf-poc-users.sh && \
    chmod a+x ${WORKDIR}/entrypoint.sh && \
    microdnf remove unzip

#EXPOSE 8080 8180 8280
EXPOSE 8080 9990

#VOLUME ${WORKDIR}/scratchpad

USER 1001

WORKDIR ${WORKDIR}

ENTRYPOINT ["/apps/jbpm/pamkie/entrypoint.sh"]

