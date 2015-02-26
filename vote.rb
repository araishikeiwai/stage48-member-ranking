class Vote
  attr_accessor :voter, :file
  attr_reader :error_messages

  def initialize(dir, voter, girls)
    @voter = voter.gsub('.txt', '')
    @file = File.open(File.join(dir, voter), 'r')
    @girls = girls
    @error_messages = []
    @is_valid = validate
  end

  def count_vote
    vote_value = [15, 10, 9, 8, 7, 6, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2, 1, 1, 1, -5, -4, -3, -2, -1]

    @members.each_with_index do |mm, idx|
      member = @girls[mm]
      if idx < 20
        member.positive_vote_count += 1
        member.positive_vote += vote_value[idx]
      elsif
        member.negative_vote_count += 1
        member.negative_vote += vote_value[idx].abs
      end
    end
  end

  def is_valid?
    @is_valid
  end

  private

  def validate
    valid = true

    @members = []
    i = 0
    while (line = @file.gets)
      i += 1

      if line.strip.empty? && i == 21
        next
      end

      if line.strip.empty? && i != 21
        valid = false
        @error_messages << error_message(i, "Blanks detected")
        break
      end

      if !line.strip.empty? && i == 21
        valid = false
        @error_messages << error_message(i, "Too many positive entries")
        break
      end

      regex = line =~ /Team 8/ ? /^( ?\d\d\. )?([A-Za-z ]+ \(Team 8\))/ : /^( ?\d\d\. )?([A-Za-z ]+)/
      match = regex.match(line)
      member_name = match[2].strip
      @members << member_name
      unless @girls[member_name]
        valid = false
        @error_messages << error_message(i, "Not eligible entry: " + member_name)
      end
    end

    if i < 20
      valid = false
      @error_messages << error_message(i, "Not enough entry")
    elsif i > 26
      valid = false
      @error_messages << error_message(i, "Too many total entries")
    end

    if @members.uniq.count != @members.count
      valid = false
      doubles = @members.detect{ |e| @members.count(e) > 1 }
      @error_messages << error_message('--', "Multiple entry: " + doubles)
    end

    valid
  end

  def error_message(line_number, message)
    "Line #{line_number}: #{message}"
  end
end
