#FROM jboss/teiid:13.1.0
FROM jboss/wildfly:19.1.0.Final

ENV JBOSS_HOME /opt/jboss/wildfly

# Set the TEIID_VERSION env variable
ENV TEIID_VERSION 16.0.0 

#COPY teiid-wildfly-$TEIID_VERSION-dist.zip $JBOSS_HOME 

# Download and unzip Teiid server
RUN cd $JBOSS_HOME \
    && curl -O https://oss.sonatype.org/service/local/repositories/releases/content/org/teiid/wildfly/teiid-wildfly/$TEIID_VERSION/teiid-wildfly-$TEIID_VERSION-dist.zip \
    && bsdtar -xf teiid-wildfly-$TEIID_VERSION-dist.zip \
    && chmod +x $JBOSS_HOME/bin/*.sh \
    && rm teiid-wildfly-$TEIID_VERSION-dist.zip


###################################
#### ----  Users: setup   ---- ####
###################################

## -- setup ManagementRealm password
ARG ADMIN_USER=${ADMIN_USER:-admin}
ENV ADMIN_USER=${ADMIN_USER}
ARG ADMIN_PASSWORD=${ADMIN_PASSWORD:-Password12345_}
ENV ADMIN_PASSWORD=${ADMIN_PASSWORD}

## -- org.jboss.as.domain-add-user: assume 
##       1st arg=$admin_user, 2nd_arg=$admin_password, 3rd_arg (default)="ManagementRealm"
## RUN add-user.sh -u user1 -p Password12345_ -r ManagementRealm --silient --enable
RUN /opt/jboss/wildfly/bin/add-user.sh ${ADMIN_USER} ${ADMIN_PASSWORD} --silent --enable

## -- setup ApplicationRealm password
ARG APP_USER=${APP_USER:-user1}
ARG APP_PASSWORD=${APP_PASSWORD:-Password12345_}
ARG APP_GROUP=${APP_GROUP:-"odata,rest"}
ARG APP_REALM=${APP_REALM:-ApplicationRealm}

## RUN add-user.sh -a user1 -p Password12345_ -r ApplicationRealm -g "odata,rest" --silient --enable
RUN /opt/jboss/wildfly/bin/add-user.sh -a ${APP_USER} -p ${APP_PASSWORD} -r ${APP_REALM} -g ${APP_GROUP} --silent --enable

###################################
#### -- Volume: Declaration -- ####
###################################
#VOLUME ["$JBOSS_HOME/standalone", "$JBOSS_HOME/domain"]
#VOLUME ["$JBOSS_HOME/standalone/configuration", "$JBOSS_HOME/domain/configuration"]

###################################
#### ---- ENV: Setup ---- ####
###################################
ENV PATH=$PATH:${JBOSS_HOME}/bin

###################################
#### -_- Deploy: node-info --- ####
###################################
#### ref: https://github.com/goldmann/wildfly-docker-deployment-example
#ADD node-info.war /opt/jboss/wildfly/standalone/deployments/

###################################
#### ---- Deploy: Teiid  ---- ####
###################################
WORKDIR ${JBOSS_HOME}
#### CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

COPY jdbc /opt/jboss/jdbc
COPY data-federation /opt/jboss/data-federation

RUN /bin/sh -c "${JBOSS_HOME}/bin/standalone.sh -c standalone-teiid.xml -b 0.0.0.0 -bmanagement 0.0.0.0 &" && \
      sleep 20 && \
      cd /tmp && \
      $JBOSS_HOME/bin/jboss-cli.sh --file=/opt/jboss/data-federation/setup.cli && \
      $JBOSS_HOME/bin/jboss-cli.sh --connect --command=:shutdown 

CMD ["/bin/sh", "-c", "${JBOSS_HOME}/bin/standalone.sh -c standalone-teiid.xml -b 0.0.0.0 -bmanagement 0.0.0.0"]

