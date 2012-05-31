require 'gemologist/repository'
require 'gemologist/resolver'
require 'gemologist/app'

module Gemologist
  class Cli
    def self.start(*args)
      Repository.create(*args) if args.flatten!.any?

      Resolver.run(Repository.all).tap do |repositories|
        result = MultiJson.dump(Hash[updated_at: Time.now, repositories: repositories])
        File.write(Gemologist::App.repositories_path, result)
      end
    end
  end

  CLI = Cli
end
