defmodule Day2Part1Test do
  use ExUnit.Case
  import Day2.Part1

  test "
    Given a list of strings without repeating chars
    Then the checksum is 0
  " do
    input = ~w(qwertyu asdfghj zxcvbnm)
    assert solve(input) == 0
  end

  test "
    Given a list of strings with one string with two a
    Then the checksum is 0
  " do
    input = ~w(qwertyu aadfghj zxcvbnm)
    assert solve(input) == 0
  end

  test "
    Given a list of strings with one string with two a
    and one with three b
    Then the checksum is 1
  " do
    input = ~w(qwertyu aadfghj zxcvbbbnm)
    assert solve(input) == 1
  end

  test "
    Given a list of strings with one string with two a and 2 f
    and one with three b
    Then the checksum is 1
  " do
    input = ~w(qwertyu aadffghj zxcvbbbnm)
    assert solve(input) == 1
  end

  test "
    Given a list of strings with one string with 2 a and 2 f
    and one with 3 b and 3 c
    Then the checksum is 1
  " do
    input = ~w(qwertyu aadffghj zxcccvbbbnm)
    assert solve(input) == 1
  end

  test "
    Given a list of strings with one string with 2 a and 3 f
    Then the checksum is 1
  " do
    input = ~w(qwertyu aadfffghj zxcvbnm)
    assert solve(input) == 1
  end

  test "
    Given a list of strings with one string with 2 a and 3 f
    one with 3 chars
    one with 2 chars
    Then the checksum is 4
  " do
    input = ~w(qweeertyu aadfffghj zxccvbnm)
    assert solve(input) == 4
  end

  test "
    Given a list of strings with one string with 2 a and 3 f
    one with 3 chars
    one with 2 chars
    one with 4 chars
    Then the checksum is 4
  " do
    input = ~w(qweeertyu aadfffghj zxccvbnm qqqqertyu)
    assert solve(input) == 4
  end

  test"
    Given day 2 input
    when solving
    answer is 7105
  " do

  end
end

defmodule Day2Part2Test do
  use ExUnit.Case
  import Day2.Part2

  test "part2" do
    input = ~w(abcde fghij klmno pqrst fguij axcye wvxyz)
    assert solve(input) == "fgij"
  end

  test"
    Given day 2 input
    when solving
    answer is 7105
  " do

  end
end
