require 'spec_helper'

describe 'bundler/geminabox/gem_tasks' do
  context 'rake -T' do
    it { expect(system("rake -T")).to be_truthy }
  end
end

