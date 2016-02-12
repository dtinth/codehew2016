class Knapsack
  def initialize(values, weights, max_weight)
    @values, @weights = values, weights
    @max_weight = max_weight
    @cache = { }
  end
  def max_value
    max_value_given(@values.length - 1, @max_weight)
  end
  def max_value_given(choice_index, max_weight)
    @cache[[choice_index, max_weight]] ||= begin
      return 0 if choice_index < 0
      choices = [ ]
      weight = @weights[choice_index]
      if weight <= max_weight
        choices << max_value_given(choice_index - 1, max_weight - weight) + @values[choice_index]
      end
      choices << max_value_given(choice_index - 1, max_weight)
      choices.max
    end
  end
end

gets.to_i.times do
  n, l = gets.split.map(&:to_i)
  people = gets.split.map(&:to_i)
  delay = gets.split.map(&:to_i)
  overhead = n + 1
  max_weight = l - overhead
  c = Knapsack.new(people, delay, max_weight)
  p c.max_value
end
