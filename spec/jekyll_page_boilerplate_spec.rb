require 'spec_helper'
RSpec.describe JekyllPageBoilerplate do

  let(:file_content) {File.read('test/title.md')}

  it "has a version number" do
    expect(JekyllPageBoilerplate::VERSION).not_to be nil
  end

  context '`boilerplate` command renders readme' do
    subject { %x|exe/boilerplate| }
    it {is_expected.to match 'A boilerplate is a markdown'}
  end

  context '`boilerplate init` command' do
    subject {%x|exe/boilerplate init|}

    it {is_expected.not_to match /Fatal/}
    
    it {is_expected.to match '_boilerplates/example.md'}

    it 'creates example.md' do
      expect(File.exist?('_boilerplates/example.md')).to eq(true)
    end
  end

  context '`boilerplate help` command' do
    subject { %x|exe/boilerplate help| }
    it {is_expected.not_to match '(no summary)'}
    it {is_expected.not_to match '(no description)'}
    it {is_expected.to match '--slug'}
  end

  context '`boilerplate list` command' do
    subject { %x|exe/boilerplate list| }
    it 'displays a list of boilerplate options' do
      is_expected.to match('test')
      is_expected.to match('example')
      is_expected.not_to match(".md")
    end
  end

  context '`bplate` alias command' do
    subject { %x|exe/bplate test| }
    it {is_expected.not_to match "not found"}
    it {is_expected.not_to match "no such file"}
  end

end
