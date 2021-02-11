name "server-only"
description "Install only the CloudBees CD server"
run_list "recipe[cloudbees-cd::setup-env]", "recipe[cloudbees-cd::cloudbees-cd-server-express]"