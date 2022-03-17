class CompressionLexer
  def initialize(string)
    @reader = Char::Reader.new(string)
  end

  def to_compressed_string
    compressed = String::Builder.new
    count = 1

    while @reader.has_next?
      case current = @reader.current_char
      when @reader.peek_next_char
        count += 1
      else
        compressed << count << current
        count = 1
      end

      @reader.next_char
    end

    compressed.to_s
  end
end

if CompressionLexer.new("AAABBAAC").to_compressed_string == "3A2B2A1C"
  puts "Successfully compressed."
else
  raise "Did not properly compress."
end
