class Game
  attr_reader :level, :answer, :round, :is_win

  LEVEL_MIN = 3
  LEVEL_MAX = 6

  def initialize(level: 4)
    @level = level
    @answer = generate_answer
    @round = 0
    @is_win = false
  end

  # { correct: bool, hit: integer, blow: integer }
  def validate(input)
    @round += 1 unless @is_win

    result = { round: @round, number: input.join, correct: false, hit: 0, blow: 0 }

    if correct?(input)
      result[:correct] = true
      result[:hit] = @level
      result[:blow] = 0
      @is_win = true
    else
      result[:hit] = hit(input)
      result[:blow] = blow(input)
    end

    result
  end

  private

  def generate_answer
    raise ArgumentError unless @level.between?(LEVEL_MIN, LEVEL_MAX)

    (0..9).to_a.sample(@level)
  end

  def correct?(input)
    input == @answer
  end

  def hit(input)
    count = 0
    input.each_with_index do |num, index|
      count += 1 if num == @answer[index]
    end

    count
  end

  def blow(input)
    count = 0

    reject_hit = input.reject.with_index { |i, index| @answer[index] == i }
    reject_hit.each do |i|
      count += 1 if @answer.include?(i)
    end

    count
  end
end
