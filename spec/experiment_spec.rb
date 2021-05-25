
RSpec.describe JekyllPageBoilerplate do
    let(:boilerplate_regx) { /^_boilerplate:(\s*^[\t ]{1,2}.+$)+/ }
    let(:file_regxp) { /^-{3}\s*$(?<head>[\s\S]*)^-{3}\s$(?<body>[\s\S]*)/ }

    it "fetch config" do
        File.open('_boilerplates/test.md') do |test_file|
 
            content = test_file.read
            config = YAML.load(content.match(boilerplate_regx).to_s)['_boilerplate']
            
            expect(
                config['path']
            ).to eq('test')
        end
    end

    it "remove config" do
        File.open('_boilerplates/test.md') do |test_file|
            content = test_file.read
            expect(
                content.gsub boilerplate_regx, ''
            ).not_to eq(content)
        end
    end

    it "replace or apend head" do
        File.open('_boilerplates/test.md') do |test_file|
            content = test_file.read.match(file_regxp).named_captures

            content['head'] << "\ncreated:"
            content['head'] << "\ntitle:"
            content['head'].gsub! /^created:.*$/, "created: the new time"
            # puts content['body']
            expect(content['head']).to eq('')

        end
    end
end