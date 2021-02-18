# CloudBees CD #

## Introduction ##

This recipe will install CloudBees CD.  It currently either sets up an all-in-one server in express mode (using builtin mariadb database) or an all-in-one server connecting to an external mysql database.

The installation will be using the self-singed certificates.

It has been tested on Ubuntu 18.04 and RHEL 8.
## Roles ##

The following roles have been defined.

- all-in-one-express: Installs all the components on a single target and uses builtin mariaDB
- all-in-one-ext-mysql: Install all the components on a single target and connects to an external mysql database
- server-only-express: Installs the CloudBees CD server only with builtin mariaDB
- analytics-only: Installs the CloudBees Analytics only
## How to use ##

- Change values in attributes/default.rb as needed.  These are mostly paths and filenames.
- Change values in data_bag 'cloudbeescd' as needed.  This data bag is for sensitive data (ie passwords)
- Encrypt data_bag 'cloudbeescd' as usual
- You will need a CloudBees CD production license, place this in cookbooks/cloudbeescd/files and call it 'license.xml'
- If connecting to an external mysql database then you will also need a mysql-connect-java-XXX.jar file in the cookbooks/cloudbeescd/files directory.  The recipe currently expects to find a file named 'mysql-connector-java-8.0.22.jar', if it is anything else than also update the source for the 'Copy myql connector java in to the right location' step in cloudbees-cd-server-ext-mysql.rb to match the actual name.  When copied to target this gets renamed to mysql-connector-java.jar

Run the role, for example using Chef Zero approach:

```bash
sudo chef-client --local-mode --why-run --runlist "role[all-in-one]"
```
