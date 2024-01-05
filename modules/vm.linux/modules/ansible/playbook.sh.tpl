#!/bin/bash

pip3 install --user ansible

ansible-playbook -i host.ini deploy_apache2.yml -e "static_web_path=${static_web_path}"
