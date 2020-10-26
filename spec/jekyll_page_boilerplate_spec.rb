RSpec.describe JekyllPageBoilerplate do
  it "has a version number" do
    expect(JekyllPageBoilerplate::VERSION).not_to be nil
  end

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
end
