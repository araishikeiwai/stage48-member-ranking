class Stage48MemberRanking

  attr_accessor :girls, :votes, :teams

  def set_up_girls
    @girls = {}
    girlfile = File.open('votekeys.list')
    @teams = {}
    teamfile = File.open('teams.list')
    rankfile = File.open('ranking2013.list')

    pref = 0
    while (team = teamfile.gets)
      @teams[team.gsub(/\s/, '')] = Team.new(team, pref)
      pref += 1
    end

    team = nil
    while (girl = girlfile.gets)
      if girl[0].eql?('#')
        team = @teams[girl.gsub(/\s/, '')]
        next
      end
      @girls[girl.strip] = Girl.new(girl.strip, team)
    end

    while (rank = rankfile.gets)
      girl = /^([0-9]+)\. \(.*\) \[.*\] ([A-Za-z ]+)/.match(rank.strip)
      girl_rank = girl[1].to_i
      girl_name = girl[2].strip

      @girls[girl_name].previous_rank = girl_rank if @girls[girl_name]
    end
  end

  def set_up_votes
    @votes = []
    dir = 'votes'
    Dir.foreach(dir) do |vote|
      unless ['.', '..'].include?(vote)
        puts "validating " + vote.gsub('.txt', '') + ":"
        votefile = Vote.new(dir, vote, @girls)
        if votefile.is_valid?
          puts "OK"
          @votes << votefile
        else
          puts votefile.error_messages
        end
        puts
      end
    end
  end

  def count_votes
    @votes.map(&:count_vote)
  end

  def vote
    set_up_girls
    set_up_votes
    count_votes

    girls_sorted = @girls.values.sort

    result = File.open('vote_result.list', 'w')
    result = girls_sorted.reverse
    rank = 0
    hid = 0
    prev_vote = 0

    to_print = []

    result.each do |girl|
      if girl.total_vote == prev_vote
        to_print << print(girl, rank)
        hid += 1
      else
        rank += 1
        rank += hid
        hid = 0
        prev_vote = girl.total_vote
        to_print << print(girl, rank)
      end
    end

    vote_result = File.open('vote_result.list', 'w')
    to_print.reverse.each do |p|
      vote_result.write(p)
      vote_result.write("\n")
    end

    vote_result.write("\n")
    @teams.values.each do |team|
      vote_result.write(team.to_s + "\n")
      this_team = girls_sorted.select { |girl| girl.team == team }
      rank = 0
      hid = 0
      prev_vote = 0
      this_team.reverse.each do |girl|
        if girl.total_vote == prev_vote
          hid += 1
        else
          rank += 1
          rank += hid
          hid = 0
          prev_vote = girl.total_vote
        end
        vote_result.write(rank.to_s + '. ' + girl.to_s + "\n")
      end
      vote_result.write("\n")
    end

    vote_result.write("[I]Votes counted (#{votes.count}):\n")
    vote_result.write("[SIZE=2]")
    first = true
    @votes.map(&:voter).sort.each do |voter|
      vote_result.write(', ') unless first
      first = false
      vote_result.write(voter)
    end
    vote_result.write("[/SIZE][/I]")
  end

  private

  def print(girl, rank)
    result = rank.to_s + ". "
    if girl.previous_rank != -1
      if girl.previous_rank < rank
        result += "[COLOR=#FF0000]"
      elsif girl.previous_rank > rank
        result += "[COLOR=#00FF00]"
      else
        result += "[COLOR=#0000FF]"
      end
      result += "[SIZE=2](#{girl.previous_rank})[/SIZE][/COLOR]"
    else
      result += "[SIZE=2](---)[/SIZE]"
    end
    result += " " + girl.to_s
  end
end
