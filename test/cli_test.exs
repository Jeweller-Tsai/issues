defmodule CliTest do
  use ExUnit.Case

  import Issues.CLI, only: [parse_args: 1,
                            sort_into_ascending_order: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "project", "99"]) == { "user", "project", 99 }
  end

  test "count is defaulted if two values given" do
    assert parse_args(["user", "project"]) == { "user", "project", 4 }
  end

  test "sort ascending orders the correct way" do
    fake_issues = [
      i3 = %{ "created_at" => "2014-11-21" },
      i1 = %{ "created_at" => "2014-11-01" },
      i2 = %{ "created_at" => "2014-11-11" },
    ]

    assert sort_into_ascending_order(fake_issues) == [i1, i2, i3]
  end

end
