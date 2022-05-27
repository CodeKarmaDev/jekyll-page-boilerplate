RSpec.describe JekyllPageBoilerplate::Tags do


  context 'basic usage' do
    subject {JekyllPageBoilerplate::Tags.new(
      {a: 'b', c: 1, d: true, e: false}
    )}

    it "can return expected values" do
      expect(subject[:a]).to eq('b')
      expect(subject[:c]).to eq(1)
      expect(subject[:d]).to eq(true)
      expect(subject[:e]).to eq('')
    end
  end

  context 'fillable tags' do
    subject {JekyllPageBoilerplate::Tags.new(
      {slug: '{{ date }}-{{ name }}.md', name: 'John Doe'}
    ).fill(:slug, safe: true)}

    it {expect(subject[:slug]).to match /\d{4}-\d{2}-\d{2}-john-doe.md/}
  end

  context 'merge tags' do
    subject {JekyllPageBoilerplate::Tags.new(
      {a: 1},{'b' => 2},c: 3 
    )}
    it 'have correct values' do
      expect(subject['a']).to eq(1)
      expect(subject[:b]).to eq(2)
      expect(subject.c).to eq(3)
    end
  end

  context 'generated tags' do
    subject {JekyllPageBoilerplate::Tags.new(
      name: 'John Doe'
    )}
    it('safe=name') {expect(subject['safe= name']).to eq('john-doe')}
    it('date') {expect(subject[:date]).to match /\d{4}-\d{2}-\d{2}/}
    it('time') {expect(subject[:time]).to match /\d{4}-\d{2}-\d{2} \d{1,2}:\d{2}:\d{2} -{0,1}\d{4}/}
    it('random') {expect(subject['random']).to match /[0-9a-zA-Z]{32}/}
    it('random=2') {expect(subject['random =2']).to match /[0-9a-zA-Z]{4}/}
  end

  context 'add new tags' do
    subject {JekyllPageBoilerplate::Tags.new(
      a: 1
    )}
    it {expect(subject.add(a:2).a).to eq(2)}
    it {expect(subject.add({b: 3}).b).to eq(3)}
  end

  context 'set tags' do
    subject do
      tags = JekyllPageBoilerplate::Tags.new(a: 1)
      tags[:a] = 2
      tags[:b] = 3
      tags
    end
    it {expect(subject.a).to eq(2)}
    it {expect(subject.b).to eq(3)}
  end
end
