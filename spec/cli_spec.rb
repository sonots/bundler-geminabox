require 'spec_helper'
require 'bundler/geminabox/cli'

describe Bundler::Geminabox::CLI do
  BIN_DIR = File.join(ROOT, 'bin')
  TMP_DIR = File.join(ROOT, 'foo')

  context 'bundle-geminabox gem' do
    before :all do
      system("GEMINABOX=https://rubygems.mydomain.com #{File.join(BIN_DIR, 'bundle-geminabox')} gem foo")
    end

    after :all do
      FileUtils.rm_r(File.join(ROOT, 'foo'))
    end

    context 'Gemfile' do
      subject { File.read(File.join(TMP_DIR, 'Gemfile')) }
      it { expect(subject).to include("source 'https://rubygems.mydomain.com'") }
    end

    context 'Rakefile' do
      subject { File.read(File.join(TMP_DIR, 'Rakefile')) }
      it { expect(subject).to include('require "bundler/geminabox/gem_tasks"') }
    end
  end
end
