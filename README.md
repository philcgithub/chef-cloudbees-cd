# CloudBees CD #

## Introduction ##

This cookbook can be used to install CloudBees CD.  It currently either sets up an all-in-one server in express mode (using builtin mariadb database) or an all-in-one server connecting to an external mysql database.

The installation will be using the self-singed certificates.

It has been tested on Ubuntu 18.04 and RHEL 8, and with CloudBees CD 10.0.2 and 10.1.
## Roles ##

The following roles have been defined.

- all-in-one-express: Installs all the components on a single target and uses builtin mariaDB
- all-in-one-ext-mysql: Install all the components on a single target and connects to an external mysql database
- server-only-express: Installs the CloudBees CD server only with builtin mariaDB
- analytics-only: Installs the CloudBees Analytics only
- agent-only: Installs the CloudBees agent only

## Recipes ##

The following recipes have been defined:

- cloudbeescd-agent.rb
- cloudbeescd-analytics.rb
- cloudbeescd-server-express.rb
- cloudbeescd-server-ext-mysql.rb
- default.rb (the equivalent to role 'all-in-one-express')
- setup-env.rb

## How to use ##

- Change values in attributes/default.rb as needed.  These are mostly paths and filenames
- Download the installer files to the expected location (as defined in attributes/default.rb)
- Set the execute attribute for the installer files (sudo chmod +x ... )
- Change values in data_bag 'cloudbeescd' as needed.  This data bag is for sensitive data (ie passwords)
- Encrypt data_bag 'cloudbeescd' as usual
- You will need a CloudBees CD production license, place this in cookbooks/cloudbeescd/files and call it 'license.xml'
- If connecting to an external mysql database then you will also need a mysql-connect-java-XXX.jar file in the cookbooks/cloudbeescd/files directory.  The recipe currently expects to find a file named 'mysql-connector-java-8.0.22.jar', if it is anything else than also update the source for the 'Copy myql connector java in to the right location' step in cloudbees-cd-server-ext-mysql.rb to match the actual name.  When copied to target this gets renamed to mysql-connector-java.jar

Test run the role, for example using Chef Zero approach:

```bash
sudo chef-client --local-mode --why-run --runlist "role[all-in-one-express]"
```

and if all goes well, then run it for real:

```bash
sudo chef-client --local-mode --runlist "role[all-in-one-express]"
```

### Installing separate agents ###

- Make sure you update attributes/default.rb once the server is installed, paying particular attention to the agent section (e.g. agent-remoteserver).
- Run the agent only role:

```bash
sudo chef-client --local-mode --runlist "role[agent-only]"
```
