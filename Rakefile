# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'rong360'
  app.deployment_target = '7.1'
  app.icons = Dir.glob("resources/icon*.png").map{|icon| icon.split("/").last}
end
