require "js"

class View
  include DOMHelper

  def initialize
    game_init

    add_event_listener
  end

  def add_event_listener
    add_game_init_button_event
    add_validate_button_event
  end

  def game_init
    init_history

    @game = Game.new(level:)

    input_number = document.getElementById("input_number")
    input_number[:value] = ""
    input_number.setAttribute("maxlength", @game.level)
  end

  def level
    checked_value = nil
    radio = document.getElementsByName("level_radio")
    radio.to_a.each do |r|
      checked_value = r[:value] if r[:checked].to_i == 1
    end

    checked_value.to_i
  end

  def input_number
    document.getElementById("input_number")[:value].to_s.split("").map(&:to_i)
  end

  def add_game_init_button_event
    init_btn = document.getElementById("init_btn")
    init_btn.addEventListener("click") do
      game_init
    end
  end

  def add_validate_button_event
    validate_btn = document.getElementById("validate_btn")
    validate_btn.addEventListener("click") do
      next if @game.is_win
      next if input_number.count != @game.level

      result = @game.validate(input_number)

      add_history(result)
    end
  end

  def init_history
    history = document.getElementById("history")
    history[:innerHTML] = ""

    history_table = create_elem("table", history) do |table|
      table[:className] = "table col-12"
    end

    thead = create_elem("thead", history_table)
    tr = create_elem("tr", thead)

    %w[# 入力 Hit Blow].each do |header_text|
      create_elem("th", tr) do |th|
        th[:innerText] = header_text
      end
    end

    create_elem("tbody", history_table) do |tbody|
      tbody[:id] = "history-tbody"
    end
  end

  # {:round=>1, :number=>"1234", :correct=>false, :hit=>0, :blow=>1}
  def add_history(result)
    tbody = document.getElementById("history-tbody")

    tr = create_elem("tr", tbody)

    result.except(:correct).each_pair do |_, value|
      create_elem("td", tr) do |td|
        td[:innerText] = value
      end
    end
  end
end
