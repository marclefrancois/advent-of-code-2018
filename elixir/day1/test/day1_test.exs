defmodule Day1Test do
  use ExUnit.Case
  import Day1

  test "
    given a list of [0]
    when adjusting
    return 0
  " do
    assert adjustFrequency([0]).adjusted == 0
  end

  test "
    given a list of [1]
    when adjusting
    return 1
  " do
    assert adjustFrequency([1]).adjusted == 1
  end

  test "
    given a list of [-1]
    when adjusting
    return -1
  " do
    assert adjustFrequency([-1]).adjusted == -1
  end

  test "
    given a list of [-1, 1]
    when adjusting
    return 0
  " do
    assert adjustFrequency([-1, 1]).adjusted == 0
  end

  test "
    given a list of many adjustments
    when adjusting
    return 0
  " do
    assert adjustFrequency([-1, 1, 2, 12, -3, 6]).adjusted == 17
  end

  test "
    given a file containing these adjustments: [-1, 1, 2, 12, -3, 6]
    when adjusting
    return the final frequency of 17
  " do
    result = adjustFrequencyFromFile("../../inputFiles/simpleTestInputPartOne.txt")
    assert result.tries == 2
    assert result.adjusted == 17
  end

  test "
    given a list of many adjustments
    when detecting first repeating frequency
    return -1
  " do
    assert findRepeatingFrequency([-1, 2, -2, 12, -3, 6]).first_repeating == -1
  end

  test "
    given a list of many adjustments
    when detecting first repeating frequency
    return 3
  " do
    assert findRepeatingFrequency([-2, 5, -1, 1, -3, 6]).first_repeating == 3
  end

  test "
    given a list of many adjustments
    when detecting first repeating frequency takes 2 pass
    return -2 for first repeating but 0 for adjusted
  " do
    result = findRepeatingFrequency([-2, 1, 1])
    assert result.first_repeating == -2
    assert result.tries == 2
    assert result.adjusted == 0
  end

  test "
    given a list of many adjustments
    when detecting first repeating frequency never works
    return we stop after 10000 tries
  " do
    result = findRepeatingFrequency([1, 2, 3])
    assert result.tries == 10000
    assert result.first_repeating == nil
  end

  test "
    given a file containing these adjustments: [-1, 1, 2, 12, -3, 6]
    when finding first repeating
    return the first repeating is 0
  " do
    result = adjustFrequencyFromFile("../../inputFiles/simpleTestInputPartOne.txt")
    assert result.tries == 2
    assert result.first_repeating == 17
  end
end
