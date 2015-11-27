name 'drone-cluster'
maintainer 'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license 'Apache 2.0'
description 'Application cookbook which installs and configures a drone cluster.'
long_description 'Application cookbook which installs and configures a drone cluster.'
version '1.0.0'
issues_url 'https://github.com/johnbellone/drone-cluster-cookbook/issues'
source_url 'https://github.com/johnbellone/drone-cluster-cookbook'

supports 'ubuntu', '~> 14.04'
supports 'redhat', '~> 7.1'
supports 'centos', '~> 7.1'

depends 'build-essential'
depends 'docker'
depends 'golang'
depends 'poise', '~> 2.2'
depends 'poise-service', '~> 1.0'
depends 'postgres'
