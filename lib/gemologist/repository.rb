require 'pathname'

module Gemologist
  class Repository
    attr_reader :name

    def self.create(name, url)
      new(name, url).tap do |repository|
        repository.save
      end
    end

    def self.all
      _directories.map {|dir| new(dir) }
    end

    def self.root
      @@root ||= begin
        result = Pathname.new(File.dirname(__FILE__)).join('../../repositories')
        result.mkpath
        result.realpath
      end
    end

    def initialize(name, url = nil)
      @name, @url = name, url
    end

    def save
      ! persisted? ? create : update
    end

    def persisted?
      File.exist?(path)
    end

    def create
      system "cd #{ self.class.root } && git clone #{ @url } #{ @name }"
    end

    def update
      system "cd #{ path } && git pull"
    end

    def destroy
      system "rm -rf #{ path }"
    end

    def path
      self.class.root.join(@name)
    end

    def gemfile
      path.join('Gemfile')
    end

    def gemfile_lock
      path.join('Gemfile.lock')
    end

    protected
    def self._directories
      root.children.map do |child|
        File.basename(child) if child.directory?
      end.compact
    end
  end
end
