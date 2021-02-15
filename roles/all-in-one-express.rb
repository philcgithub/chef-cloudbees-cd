name "all-in-one"
description "Install all components on a single server"
run_list "recipe[cloudbeescd::setup-env]", "recipe[cloudbeescd::cloudbeescd-server-express]", "recipe[cloudbeescd::cloudbeescd-analytics]"