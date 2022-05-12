require 'spec_helper'
RSpec.describe JekyllPageBoilerplate::Page do


  let(:file_content) {File.read('test/title.md')}


  context '`boilerplate <page>` command' do
    subject {%x|exe/boilerplate test|}
  
    it('creates a file') do
      is_expected.not_to match /Fatal/
      expect(File.exist?('test/title.md')).to eq(true)
      expect(%x|exe/boilerplate test|).to match /Fatal/
    end

    it {is_expected.to match 'test/title.md'}
  end



  context '`boilerplate <page>` file content' do
    before {%x|exe/boilerplate test|}

    subject {file_content}
    
    it "generates correct content" do
      is_expected.to match /---/
      is_expected.to match /layout: post/
      is_expected.to match /author: John Doe/
    end

    it 'does not render nill' do
      is_expected.not_to match /nil|null/
    end

    it 'can create content' do
      is_expected.to match 'some boilerplate text'
      is_expected.to match 'Default Test Heading'
    end

    # _boilerplate:
    #   path: test
    #   timestamp: false
    it 'removes the boilerplate settings' do
      is_expected.not_to match '_boilerplates:'
      is_expected.not_to match 'path: test'
      is_expected.not_to match 'timestamp: false'
    end

    it 'removes doubled new lines' do
      is_expected.not_to match /[\r\n]{3,}[^-]*(?=-{3}$)/m
    end

    it 'replaces the boilerplate templates {{ boilerplate.xxx }}' do
      is_expected.not_to match /\{{2}\s*boilerplate\.\w+\s*\}{2}/
      is_expected.to match "Type is testing" 
      is_expected.to match "File is title.md" 
      is_expected.not_to match "boilerplate.random_url"
      is_expected.to match /random_url: [^\s]{3,}/
      is_expected.to match /random_url: [^\s]{9,}/
    end

  end



  context '`boilerplate <page> -T "Test Title" --suffix .markdown --timestamp`' do
    subject { %x|exe/boilerplate test -T "Test Title" --suffix .markdown --timestamp|}

    it 'handles file options' do
      is_expected.not_to match 'Fatal'
      expect(Dir["test/*"]).not_to be_empty
      expect(Dir["test/*test-title.markdown"]).not_to be_empty
    end
    
    it {is_expected.to match /test\/.+test-title\.markdown/}
  end



  context '`boilerplate <page> custom=1` command' do
    subject {%x|exe/boilerplate test custom=1|}
     
    it 'handles custom params' do
      is_expected.not_to match 'Fatal'
      expect(File.exist?('test/title.md')).to eq(true)
      expect(file_content).to match 'custom: 1'
      expect(file_content).not_to match 'boilerplate.custom'
    end
  end




end
