RSpec.describe JekyllPageBoilerplate do
  it "has a version number" do
    expect(JekyllPageBoilerplate::VERSION).not_to be nil
  end

  context 'page command' do
    it "can create a new post/page" do
      output = %x|exe/boilerplate create test|
      puts output
      expect(File.exist?('test/title.md')).to eq(true)
      expect(output).not_to match /Fatal/
      file_content = ''
      open('test/title.md', 'r') do |file|
        file_content = file.read()
      end
      expect(file_content).to match /---/
      expect(file_content).to match /layout: post/
      expect(file_content).to match /author: John Doe/
    end
    
    it "cant create two pages with the same name" do
      output = %x|exe/boilerplate page test|
      expect(output).to match /Fatal/
    end

    it 'can create content' do
      %x|exe/boilerplate page test|
      file_content = ''
      open('test/title.md', 'r') do |file|
        file_content = file.read()
      end
      expect(file_content).to match 'some boilerplate text'
      expect(file_content).to match 'Default Test Heading'
    end

    # _boilerplate:
    #   path: test
    #   timestamp: false
    it 'removes the boilerplate settings' do
      %x|exe/boilerplate page test|
      file_content = ''
      open('test/title.md', 'r') do |file|
        file_content = file.read()
      end
      expect(file_content).not_to match '_boilerplates:'
      expect(file_content).not_to match 'path: test'
      expect(file_content).not_to match 'timestamp: false'
    end


    it 'removes doubled new lines' do
      %x|exe/boilerplate page test|
      file_content = ''
      open('test/title.md', 'r') do |file|
        file_content = file.read()
      end

      expect(file_content).not_to match /[\r\n]{3,}[^-]*(?=-{3}$)/m

    end


    it 'handles file options' do
      output = %x|exe/boilerplate create test -T "Test Title" --suffix markdown --timestamp|
      expect(Dir["test/*test-title.markdown"]).not_to be_empty
    end



  end

  context 'init command' do
    it 'creates example.md' do
      output = %x|exe/boilerplate init|
      expect(output).not_to match /Fatal/
      expect(File.exist?('_boilerplates/example.md')).to eq(true)
    end
  end

end
