#!/bin/bash -eux


curl -sO http://192.168.2.235:8080/jnlpJars/agent.jar || exit 1

mv /home/jenkins/jenkins-agent.service /etc/systemd/system/jenkins-agent.service
systemctl daemon-reload