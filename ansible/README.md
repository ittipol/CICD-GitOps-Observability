# Ansible
https://docs.ansible.com/ansible/latest/network/getting_started/first_playbook.html

## Run playbook
``` bash
ansible-playbook -i inventory ssl_cert_deploy.ansible.yml

# Ask for connection password
ansible-playbook -i inventory ssl_cert_deploy.ansible.yml -k

# Use connection password from vault
ansible-playbook -i inventory --vault-id dev@./password/password_file ssl_cert_deploy.ansible.yml
```

## Encrypting SSH password 
``` bash
ansible-vault encrypt_string --vault-id dev@password_file 'password' --name 'the_dev_secret'
```