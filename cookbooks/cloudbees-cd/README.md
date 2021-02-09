# CloudBees CD #

## Introduction ##

This recipe will install CloudBees CD.  It currently assumes all components will be installed on a single server and it will use the 'expressServer' option (ie using builtin mariaDB database).

The installation will be using the self-singed certificates.

It was created and tested on Ubuntu 18.04.

## Roles ##

There is a single role at this time:

- all-in-one: Installs on the components on a single target
## How to use ##

- Change values in attributes/default.rb as needed.  These are mostly paths and filenames.
- Change values in data_bag 'cloudbees-cd' as needed.  This data bag is for sensitive data (ie passwords)
- Encrypt data_bag 'cloudbees-cd' as usual

Run the role, for example:

```bash
sudo chef-client --local-mode --why-run --runlist "role[all-in-one]"
```
