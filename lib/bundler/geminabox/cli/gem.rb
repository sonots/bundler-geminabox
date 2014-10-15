module Bundler
  module Geminabox
    class CLI::Gem
      attr_reader :options, :gem_name, :thor
      def initialize(options, gem_name, thor)
        @options = options
        @gem_name = gem_name
        @thor = thor
      end

      def run
        name = gem_name.chomp("/") # remove trailing slash if present
        target = File.join(Dir.pwd, name)
        underscored_name = name.tr('-', '_')
        opts = {
          :geminabox        => ENV['GEMINABOX'] || 'https://your.rubygems.org',
          :gem_tasks        => ENV['CUSTOM_GEM_TASKS'] || 'bundler/geminabox/gem_tasks',
          :name             => name,
          :underscored_name => underscored_name,
          :test             => options[:test],
          :ext              => options[:ext]
        }
        opts[:force] = true
        thor.template(File.join("newgem/Gemfile.tt"), File.join(target, "Gemfile"), opts)
        thor.template(File.join("newgem/Rakefile.tt"), File.join(target, "Rakefile"), opts)
      end
    end
  end
end
