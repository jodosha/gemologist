require 'httparty'
require 'multi_json'

module Gem
  class Dependency
    # FIXME this is too hackish
    def to_version
      Gem::Version.new(requirement.to_s.scan(/[\w\.]*$/).first)
    end
  end
end

module Gemologist
  class Dependency
    OUTDATED_FLAG = 1

    include HTTParty
    format :json
    no_follow true

    base_uri 'https://rubygems.org/api/v1'
    attr_reader :name, :dependency

    def initialize(dependency)
      @name, @dependency = dependency.name, dependency
    end

    # TODO Provide support for Git repositories.
    def outdated?
      if dependency.specific?
        ( latest_stable_version <=> dependency.to_version ) == OUTDATED_FLAG
      end
    end

    def latest_stable_version
      @latest_stable_version ||= begin
        result = releases.find {|release| ! release['prerelease'] }
        Gem::Dependency.new(@name, result['number']).to_version
      end
    end

    def to_json(options = nil)
      MultiJson.dump(Hash[
        name:    name,
        current: dependency.to_version.to_s,
        latest:  latest_stable_version.to_s
      ])
    end

    protected
      def releases
        MultiJson.load(get)
      end

    private
      def get
        self.class.get("/versions/#{ @name }.json").body
      end
  end
end
