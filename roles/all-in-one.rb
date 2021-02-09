name "all-in-one"
description "Install all components on a single server"
run_list "recipe[cloudbees-cd::setup-env]", "recipe[cloudbees-cd::cloudbees-cd-server]", "recipe[cloudbees-cd::cloudbees-cd-analytics]"