# frozen_string_literal: true

generate 'rspec:install'

directory 'spec', force: true

copy_file '.rspec', force: true
