name "agent-only"
description "Install CloudBees Agent only."
run_list "recipe[cloudbeescd::setup-env]", "recipe[cloudbeescd::cloudbeescd-agent]"