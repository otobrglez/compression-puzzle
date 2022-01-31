require 'minitest/autorun'

def compress(str)
  str.chars.slice_when(&:!=).map { _1.tally.invert.to_a }.join
end

describe 'test' do
  it { assert_equal(compress('AAABBAAC'), '3A2B2A1C') }
end
