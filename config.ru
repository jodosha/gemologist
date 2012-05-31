$:.unshift('lib')
require 'rubygems'
require 'bundler'
Bundler.setup
require 'gemologist/app'

run Gemologist::App
