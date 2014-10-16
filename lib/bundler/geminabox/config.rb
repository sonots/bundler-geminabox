module Bundler
  module Geminabox
    class Config
      class << self
        attr_writer :geminabox, :gem_tasks, :release_task

        def geminabox
          @geminabox ||= ENV['GEMINABOX'] || 'https://your.rubygems.org'
        end

        def gem_tasks
          @gem_tasks ||= ENV['GEM_TASKS'] || 'bundler/geminabox/gem_tasks'
        end

        def release_task
          @release_task ||= ENV['RELEASE_TASK'] || 'geminabox_release'
        end
      end
    end
  end
end
