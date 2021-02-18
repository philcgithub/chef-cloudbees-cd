name "analytics-only"
description "Install CloudBees Analytics only."
run_list "recipe[cloudbeescd::setup-env]", "recipe[cloudbeescd::cloudbeescd-analytics]"