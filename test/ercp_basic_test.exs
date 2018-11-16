defmodule ERCPBasicTest do
  use ExUnit.Case
  doctest ERCPBasic

  test "greets the world" do
    assert ERCPBasic.hello() == :world
  end
end
