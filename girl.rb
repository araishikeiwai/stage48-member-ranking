class Girl
  include Comparable

  attr_accessor :name
  attr_accessor :positive_vote, :positive_vote_count
  attr_accessor :negative_vote, :negative_vote_count
  attr_accessor :team
  attr_accessor :previous_rank

  def initialize(name, team)
    @name = name
    @team = team
    @positive_vote = 0
    @positive_vote_count = 0
    @negative_vote = 0
    @negative_vote_count = 0
    @previous_rank = -1
  end

  def <=>(other_girl)
    if total_vote == other_girl.total_vote
      if @team == other_girl.team
        @name <=> other_girl.name
      else
        @team <=> other_girl.team
      end
    else
      total_vote <=> other_girl.total_vote
    end
  end

  def total_vote
    @positive_vote - @negative_vote
  end

  def to_s
    "[#{@positive_vote_count}|#{@negative_vote_count}] [COLOR=#{@team.color}]#{@name}[/COLOR] [COLOR=#BFBFBF]{#{@positive_vote == 0 ? 0 : '+' + @positive_vote.to_s},#{@negative_vote == 0 ? 0 : '-' + @negative_vote.to_s}}[/COLOR], #{total_vote}"
  end
end
