FROM jenkins/jenkins:lts

USER root

RUN apt-get update && \
    apt-get -y install apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
    python2.7

# install jenkins plugins
ADD ./jenkins/jenkins-plugins /usr/share/jenkins/plugins
RUN while read i ; \
    do /usr/local/bin/install-plugins.sh $i ; \
    done < /usr/share/jenkins/plugins


# allows to skip Jenkins setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false


# Jenkins runs all grovy files from init.groovy.d dir
# use this for creating default admin user
ADD ./jenkins/pipeline-scripts/defaults.groovy /usr/share/jenkins/ref/init.groovy.d/
# Not working
#COPY roles.groovy /usr/share/jenkins/ref/init.groovy.d/

VOLUME /var/jenkins_home

RUN apt-get install python-pip -y \
    && pip install pyyaml \
    && pip install jenkins-job-builder
  
RUN apt-get install apt-utils sudo -y \
    && echo "jenkins ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/jenkins 

#COPY jenkins-plugin-cli.sh /usr/local/bin/jenkins-plugin-cli.sh
#RUN chmod 755 /usr/local/bin/jenkins-plugin-cli.sh

## Create directory for jenkins-job-builder
RUN mkdir -p  /etc/jenkins_jobs
RUN chmod 755 /etc/jenkins_jobs


## Create jenkins-job-builder config directory
ADD ./jenkins/jenkins_jobs.ini /etc/jenkins_jobs/jenkins_jobs.ini

#USER jenkins
## Create directory for jenkins-job-builder
ADD ./jenkins/job-definitions/* /var/jenkins_home/jobs/
## Expose jenkins http port
EXPOSE 8080 

## Update the job builder jenkins jobs
WORKDIR /var/jenkins_home

