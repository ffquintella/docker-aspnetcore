FROM ffquintella/docker-puppet:1.5.1

MAINTAINER Felipe Quintella <docker-jira@felipe.quintella.email>

LABEL version="3.1.1"
LABEL description="This is a base image to be used as source for other images"

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

#Microsoft repository
RUN rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm

# Puppet stuff all the instalation is donne by puppet
# Just after it we clean up everthing so the end image isn't too big
RUN mkdir /etc/puppet; mkdir /etc/puppet/manifests ; mkdir /etc/puppet/modules ; mkdir /opt/scripts
COPY manifests /etc/puppet/manifests/
COPY modules /etc/puppet/modules/
RUN /opt/puppetlabs/puppet/bin/puppet apply --modulepath=/etc/puppet/modules /etc/puppet/manifests/base.pp  ;\
 yum clean all ; rm -rf /tmp/* ; rm -rf /var/cache/* ; rm -rf /var/tmp/* ; rm -rf /var/opt/staging

#COPY start-service.sh /opt/scripts/start-service.sh
#RUN chmod +x /opt/scripts/start-service.sh ;


#COPY setenv.sh ${JIRA_INSTALLDIR}/atlassian-jira-software-${JIRA_VERSION}-standalone/bin
#RUN chmod +x ${JIRA_INSTALLDIR}/atlassian-jira-software-${JIRA_VERSION}-standalone/bin/setenv.sh

# Ports Jira web interface
#EXPOSE 8080/tcp

#WORKDIR $FACTER_JIRA_INSTALLDIR

# Configurations folder, install dir
#VOLUME  $JIRA_HOME

#CMD /opt/puppetlabs/puppet/bin/puppet apply -l /tmp/puppet.log  --modulepath=/etc/puppet/modules /etc/puppet/manifests/start.pp
#CMD ["start-service"]
