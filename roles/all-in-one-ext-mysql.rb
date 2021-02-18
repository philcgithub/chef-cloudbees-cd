name "all-in-one-express"
description "Install all components on a single server, connecting to an external mysql database"
run_list "recipe[cloudbeescd::setup-env]", "recipe[cloudbeescd::cloudbeescd-server-ext-mysql]", "recipe[cloudbeescd::cloudbeescd-analytics]"