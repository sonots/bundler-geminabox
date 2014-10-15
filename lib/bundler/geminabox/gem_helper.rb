require 'bundler/gem_helper'
require 'forwardable'

module Bundler
  module Geminabox
    class GemHelper
      extend Forwardable
      include Rake::DSL if defined? Rake::DSL
        
      GEMINABOX = ENV['GEMINABOX'] || 'https://your.rubygems.org'

      class << self
        def install_tasks(opts = {})
          obj = Bundler::GemHelper.new(opts[:dir], opts[:name])
          obj.install
          new(obj).install
        end
      end

      def_delegators :@obj, :version_tag, :name, :version, :built_gem_path,
        :guard_clean, :build_gem, :tag_version, :git_push, :already_tagged?, :gem_push?

      def initialize(obj)
        @obj = obj
      end

      def install
        Rake::Task[:release].clear
        desc "[WARN] Release to rubygems.org is prohibited, use rake geminabox_release."
        task 'release' do
          abort 'gem release to rubygems.org is prohibited.'
        end

        desc "Create tag #{version_tag} and build and push #{name}-#{version}.gem to #{GEMINABOX}"
        task 'geminabox_release' => 'build' do
          geminabox_release_gem(built_gem_path)
        end
      end

      protected

      def geminabox_release_gem(built_gem_path=nil)
        guard_clean
        built_gem_path ||= build_gem
        tag_version { git_push } unless already_tagged?
        geminabox_rubygem_push(built_gem_path) if gem_push? # custom
      end

      def geminabox_rubygem_push(path)
        sh("gem push '#{path}' --host #{GEMINABOX}")
        Bundler.ui.confirm "Pushed #{name} #{version} to #{GEMINABOX}."
      end
    end
  end
end
