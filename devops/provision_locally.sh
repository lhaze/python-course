#!/bin/bash
#
# Windows shell provisioner for Ansible playbooks, based on Jeff Geerling's
# windows-vagrant-ansible: https://github.com/geerlingguy/JJG-Ansible-Windows
#
# @author Jeff Geerling, 2014

# Uncomment if behind a proxy server.
# export {http,https,ftp}_proxy='http://username:password@proxy-host:80'

PROJECT_NAME="python_course"
ANSIBLE_PLAYBOOK=$1
HOME_DIR="/vagrant"
REQUIREMENTS_DIR="${HOME_DIR}/devops/requirements"

# Make sure Ansible playbook exists.
if [ ! -f ${HOME_DIR}/${ANSIBLE_PLAYBOOK} ]; then
  echo "Cannot find Ansible playbook: ${HOME_DIR}/${ANSIBLE_PLAYBOOK}"
  exit 1
fi

# Install Ansible roles from requirements file, if available.
if [ -f ${REQUIREMENTS_DIR}/ansible.txt ]; then
  sudo ansible-galaxy install -r ${REQUIREMENTS_DIR}/ansible.txt
fi

# Run the playbook.
echo "Running Ansible provisioner defined in Vagrantfile."
ansible-playbook -i 'python_course,' -c local -vvv ${HOME_DIR}/${ANSIBLE_PLAYBOOK} --extra-vars "is_windows=true"
