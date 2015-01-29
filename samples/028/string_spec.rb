RSpec.describe String do
  it { expect(String.new).to eq '' }
  it { expect("one #{1 + 1} three").to eq 'one 2 three' }
  it { expect("100".to_i).to be_a(Integer)  }
end
