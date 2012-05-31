require 'pathname'
require 'multi_json'
require 'sinatra/base'

module Gemologist
  class App < Sinatra::Base
    class << self
      attr_accessor :repositories_path
    end
    self.repositories_path = Pathname.new('repositories/index.json')

    before do
      result = MultiJson.load(
        self.class.repositories_path.read
      )

      @repositories = result.fetch('repositories')
      @updated_at   = Time.parse( result.fetch('updated_at') )
    end

    get '/' do
      erb :index
    end
  end
end
