RSpec.describe JekyllPageBoilerplate do
  it "has a version number" do
    expect(JekyllPageBoilerplate::VERSION).not_to be nil
  end

  context 'page command' do
    it "can create a new post/page" do
      output = %x|exe/boilerplate page test 'title'|
      expect(File.exist?('test/title.markdown')).to eq(true)
      expect(output).not_to match /Fatal/
      file_content = ''
      open('test/title.markdown', 'r') do |file|
        file_content = file.read()
      end
      expect(file_content).to match /---/
      expect(file_content).to match /layout: post/
      expect(file_content).to match /author: John Doe/
    end
    
    it "cant create two pages with the same name" do
      %x|exe/boilerplate page test 'title'|
      output = %x|exe/boilerplate page test 'title'|
      expect(output).to match /Fatal/
    end

    it 'can create content' do
      %x|exe/boilerplate page test 'title'|
      file_content = ''
      open('test/title.markdown', 'r') do |file|
        file_content = file.read()
      end
      expect(file_content).to match 'some boilerplate text'
      expect(file_content).to match 'Default Test Heading'
    end

    # _boilerplate:
    #   path: test
    #   timestamp: false
    it 'removes the boilerplate settings' do
      %x|exe/boilerplate page test 'title'|
      file_content = ''
      open('test/title.markdown', 'r') do |file|
        file_content = file.read()
      end
      expect(file_content).not_to match '_boilerplates:'
      expect(file_content).not_to match 'path: test'
      expect(file_content).not_to match 'timestamp: false'
    end


    it 'removes doubled new lines' do
      %x|exe/boilerplate page test 'title'|
      file_content = ''
      open('test/title.markdown', 'r') do |file|
        file_content = file.read()
      end

      expect(file_content).not_to match /[\r\n]{3,}[^-]*(?=-{3}$)/m

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
