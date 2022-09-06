FROM jenkins/jenkins:lts

USER root


COPY ./plugins.txt /usr/share/jenkins/plugins
RUN while read i ; \
                do /usr/local/bin/install-plugins.sh $i ; \
        done < /usr/share/jenkins/plugins


#id_rsa.pub file will be saved at /root/.ssh/
RUN ssh-keygen -f /root/.ssh/id_rsa -t rsa -N ''

# allows to skip Jenkins setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Jenkins runs all grovy files from init.groovy.d dir
# use this for creating default admin user
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/

VOLUME /var/jenkins_home