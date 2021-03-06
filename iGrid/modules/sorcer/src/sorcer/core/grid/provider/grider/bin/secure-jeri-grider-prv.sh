#!/bin/sh

echo "[Run] Starting  Dispatcher Provider..."

SORCER_BASEURL="http://${IGRID_PORTAL_HOST}:${IGRID_PORTAL_PORT}"
JINI_BASEURL="http://${IGRID_WEBSTER}:${IGRID_WEBSTER_PORT}"

echo "${SORCER_BASEURL}/scheduler-dl.jar ${JINI_BASEURL}/sdm-dl.jar"

java -Djava.security.manager= \
    -Djava.protocol.handler.pkgs=net.jini.url \
    -Djavax.net.ssl.trustStore=../configs/truststore.server \
    -Djavax.net.ssl.keyStore=../configs/keyStore.server \
    -Djava.security.auth.login.config=../configs/serverjaas.config \
    -Djava.util.logging.config.file=${IGRID_HOME}/configs/sorcer.logging \
    -Djava,security.auth.login.config=${SORCER_BASEURL}/jaas.config \
    -Djava.security.policy=../policy/grider-prv.policy \
    -Dsorcer.server.codebase="${SORCER_BASEURL}/dispatcher-dl.jar ${SORCER_BASEURL}/dispatcher-ui.jar ${JINI_BASEURL}/sdm-dl.jar ${SORCER_BASEURL}" \
    -Dserver.classpath="${IGRID_HOME}/lib/dispatcher.jar" \
    -Dserver.impl="sorcer.core.grid.provider.grider.GridDispatcherProviderImpl" \
    -jar $JINI_HOME/lib/start.jar ../configs/secure-start-grider-prv.config
