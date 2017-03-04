defmodule TargetTest do
  use ExUnit.Case

  test "should have nil default url" do
    target = %Target{}
    assert target.url == nil
  end

  test "should have nil default body_match" do
    target = %Target{}
    assert target.body_match == nil
  end


  test "should have false default follow_redirect" do
    target = %Target{}
    refute target.follow_redirect
  end


end
