class LineAnalyzer
  attr_reader :content,:line_number,:highest_wf_count,:highest_wf_words
  def calculate_word_frequency
    s = Hash.new(0)
    z = 0
    @content.split.each do |word|
      s[word.downcase]+=1
      if s[word.downcase] > z
        z = s[word.downcase]
      end
    end
    @highest_wf_count = z
    s.each_pair do |key,value|
      if value == @highest_wf_count
        @highest_wf_words.push(key)
      end
    end
  end
  def initialize (content,line_number)
    @content = content
    @line_number = line_number
    @highest_wf_count = 0
    @highest_wf_words = []
    calculate_word_frequency
  end
end

class Solution
  attr_reader :analyzers,:highest_count_across_lines,:highest_count_words_across_lines
  def initialize
    @analyzers = []
  end
  def analyze_file
    idx = 0
    File.foreach ('test.txt') do |line|
      idx+=1
      q = LineAnalyzer.new(line,idx)
      @analyzers.push(q)
    end
  end
  def calculate_line_with_highest_frequency
    t = 0
    @analyzers.each do |ana|
      if (ana.highest_wf_count > t)
        t=ana.highest_wf_count
      end
    end
    @highest_count_across_lines = t
    @highest_count_words_across_lines = @analyzers.select {|ana| ana.highest_wf_count==t}
  end
  def print_highest_word_frequency_across_lines
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each { |o| puts "#{o.highest_wf_words} (appears in line #{o.line_number})" }
  end
end
