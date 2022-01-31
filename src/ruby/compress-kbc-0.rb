require 'minitest/autorun'

def compress(str)
  str.chars.chunk_while(&:==).map { "#{_1.size}#{_1.first}" }.join
end

describe 'test' do
  it { assert_equal(compress('AAABBAAC'), '3A2B2A1C') }
end
