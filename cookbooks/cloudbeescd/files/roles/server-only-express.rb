name "server-only-express"
description "Install only the CloudBees CD server"
run_list "recipe[cloudbeescd::setup-env]", "recipe[cloudbeescd::cloudbeescd-server-express]"