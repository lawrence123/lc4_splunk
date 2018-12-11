name 'lc4_splunk'
maintainer 'Larry Charbonneau'
maintainer_email 'larrycharbonneau4@gmail.com'
license 'GPL-3.0'
description 'Installs/Configures lc4_splunk'
long_description 'Installs/Configures lc4_splunk'
version '0.1.12'
chef_version '>= 12.14' if respond_to?(:chef_version)

depends 'lc4_firewalld'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/lawrence123/lc4_splunk/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/lawrence123/lc4_splunk'
