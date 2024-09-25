#!/bin/bash -eux

curl -sO http://10.65.85.41:8080/jnlpJars/agent.jar || exit 1

mv /home/jenkins/jenkins-agent.service /etc/systemd/system/jenkins-agent.service
systemctl daemon-reload
sudo systemctl enable jenkins-agent.service