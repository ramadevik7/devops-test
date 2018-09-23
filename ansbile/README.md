# Ansible Role: NVM


Installs NVM & Node.js on Ubuntu 

## Were other roles fall short
Other Ansible roles that install NVM and/or Node.js fall short in a few areas.

1. They use the apt-get or yum packages to install Node.js. This often means that the Node.js package is older than what is currently available via the Node repo. In some cases, those packages may not be a LTS release and if you need multiple node versions, you're out of luck.

1. They will often install NVM and Node.js as `root` user (`sudo su` or `become: true`) to install NVM. This can add to the headache of NPM plugin management in addition to being an unneeded privilege escalation security risk

1. You cannot run ad hoc NVM commands


## Where this role differs

1. You can install NVM via wget, curl or git
1. You can use NVM just like you would via your [command line](https://github.com/creationix/nvm#usage)
1. You can install whatever version of Node.js you want
1. Doesn't install NVM or Node.js as root

## Installation
1. Clone this repo into your roles folder
1. Point the `roles_path` variable to the roles folder i.e. `roles_path = ../ansible-roles/` in your `ansible.cfg` file
1. Include role in your playbook


## Example Playbooks

Playbooks are set up as an 'either/or' situation in regards to `nodejs_version` and
`nvm_commands`. It is one or the other, it cannot be both.


## Notes

If you specify `nodejs_version` and `nvm_commands`, `nodejs_version` will be ignored.
If you do not explicitly specify the `nvm install VERSION` as part of the `nvm_commands`
Node.js will not be installed and any subsequent commands WILL NOT WORK as expected.

```
ansible-playbook my-playbook.yml -e "ansible_python_interpreter=/usr/bin/python3"
```






## Role Variables

Available variables are listed below, along with default values see [defaults/main.yml]( defaults/main.yml)

The Node.js version to install. The latest "LTS" version is the default and works on most supported OSes.

    nodejs_version: "LTS"

NVM version to install

    nvm_version: "0.33.2"

List of NVM commands to run. Default is an empty list.

    nvm_commands: []

NVM Installation type. Options are wget, curl and git

    nvm_install: "wget"

NVM Installation directory

    nvm_dir: "{{ansible_env.HOME}}/.nvm"

NVM Profile location Options are .profile, .bashrc, .bash_profile, .zshrc

    nvm_profile: ".bashrc"

NVM source location i.e. you host your own fork of [NVM](https://github.com/creationix/nvm)

    nvm_source: ""

<!--
    nodejs_install_npm_user: "{{ ansible_ssh_user }}"

The user for whom the npm packages will be installed can be set here, this defaults to `ansible_user`.

    npm_config_prefix: "/usr/local/lib/npm"

The global installation directory. This should be writeable by the `nodejs_install_npm_user`.

    npm_config_unsafe_perm: "false"

Set to true to suppress the UID/GID switching when running package scripts. If set explicitly to false, then installing as a non-root user will fail.

    nodejs_npm_global_packages: []

A list of npm packages with a `name` and (optional) `version` to be installed globally. For example:

    nodejs_npm_global_packages:
      # Install a specific version of a package.
      - name: jslint
        version: 0.9.3
      # Install the latest stable release of a package.
      - name: node-sass
      # This shorthand syntax also works (same as previous example).
      - node-sass

