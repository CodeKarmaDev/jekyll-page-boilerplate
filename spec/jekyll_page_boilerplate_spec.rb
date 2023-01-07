require 'spec_helper'
RSpec.describe JekyllPageBoilerplate do

  let(:file_content) {File.read('test/title.md')}

  context "`boilerplate version` renders the version number." do
    subject { %x|exe/boilerplate version| }
    it {expect(JekyllPageBoilerplate::VERSION).not_to be nil}
    it {is_expected.to match JekyllPageBoilerplate::VERSION.to_s}
  end

  context 'readme command' do
    it '`boilerplate` command renders readme' do
      expect(%x|exe/boilerplate|).to match 'A boilerplate is a markdown'
    end
    it '`boilerplate readme`' do
      expect(%x|exe/boilerplate readme|).to match 'A boilerplate is a markdown'
    end
  end


  context '`boilerplate init` command' do
    subject {%x|exe/boilerplate init|}

    it {is_expected.not_to match /Fatal|Error/}
    
    it {is_expected.to match '_boilerplates/example.md'}

    it 'creates example.md' do
      expect(File.exist?('_boilerplates/example.md')).to eq(true)
    end
  end

  context 'help command' do
    context '`boilerplate help`' do
      subject { %x|exe/boilerplate help| }
      it {is_expected.to match 'Commands'}
      it {is_expected.to match 'init'}
      it {is_expected.to match 'list'}
      it {is_expected.to match 'readme'}
      it {is_expected.to match 'version'}
      it {is_expected.to match 'boilerplate create BOILERPLATE TITLE'}
      it {is_expected.to match 'boilerplate test TITLE'}
      it {is_expected.to match 'boilerplate example TITLE'}
    end

    context '`boilerplate help create`' do
      subject { %x|exe/boilerplate help create| }
      it {is_expected.to match '--title'}
      it {is_expected.to match '--path'}
      it {is_expected.to match '--slug'}
      it {is_expected.to match '--timestamp'}
      it {is_expected.to match '--suffix'}
    end

    it '`boilerplate help test`' do
      expect(%x|exe/boilerplate help test|).to match '--path'
    end

    it '`boilerplate help example`' do
      expect(%x|exe/boilerplate help test|).to match '--slug'
    end
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
