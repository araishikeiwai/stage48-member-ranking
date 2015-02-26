class Team
  include Comparable

  attr_reader :group, :team, :color, :preference

  def initialize(str, preference)
    str = str.split(',').map(&:strip)
    @group = str[0].gsub('# ', '')
    @team = str[1]
    @color = str[2].gsub(/\s/, '')
    @preference = preference
  end

  def <=>(otherTeam)
    @preference <=> otherTeam.preference
  end

  def to_s
    @group + ' ' + @team
  end
end
