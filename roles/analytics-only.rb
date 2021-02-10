name "analytics-only"
description "Install CloudBees Analytics only."
run_list "recipe[cloudbees-cd::setup-env]", "recipe[cloudbees-cd::cloudbees-cd-analytics]"