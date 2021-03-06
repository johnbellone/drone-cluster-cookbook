name 'drone-cluster'
maintainer 'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license 'Apache 2.0'
description 'Application cookbook which installs and configures a drone cluster.'
long_description 'Application cookbook which installs and configures a drone cluster.'
version '1.0.0'
issues_url 'https://github.com/johnbellone/drone-cluster-cookbook/issues' if defined?(issues_url)
source_url 'https://github.com/johnbellone/drone-cluster-cookbook' if defined?(source_url)

supports 'ubuntu', '~> 14.04'
supports 'redhat', '~> 7.1'
supports 'centos', '~> 7.1'

depends 'docker', '~> 2.2'
depends 'poise', '~> 2.2'
depends 'postgresql', '~> 3.4'
depends 'rc', '~> 1.2'
