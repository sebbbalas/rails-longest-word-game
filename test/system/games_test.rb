require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "div.letter", count: 10
  end

  test "get a message that the word is not in the grid" do
    visit new_url
    fill_in "word", with: "zzzzzzzzzzzzz"
    click_on "Submit"

    assert_text "can't be built out of"
  end

  test "get a message it's not a valid English word" do
    visit new_url
    fill_in "word", with: "n"
    click_on "Submit"

    assert_text "does not seem to be a valid English word..."
  end

  # test "get a message to congratulate" do
  #   visit new_url
  #   fill_in "word", with: "no"
  #   click_on "Submit"

  #   assert_text "Congratulations!"
  # end
end
