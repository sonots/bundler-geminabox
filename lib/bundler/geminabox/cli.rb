require 'bundler/cli'

module Bundler
  module Geminabox
    class CLI < Thor
      include Thor::Actions

      desc "gem GEM [OPTIONS]", "Creates a skeleton for creating a rubygem"
      method_option :ext, :type => :boolean, :default => false, :banner => "Generate the boilerplate for C extension code"
      method_option :test, :type => :string, :lazy_default => 'rspec', :aliases => '-t', :banner =>
        "Generate a test directory for your library: 'rspec' is the default, but 'minitest' is also supported."

      def gem(name)
        Bundler::CLI.start(ARGV, :debug => true)

        require 'bundler/geminabox/cli/gem'
        self.class.source_root(File.join(__dir__, 'templates'))
        Gem.new(options, name, self).run
      end
    end
  end
end
