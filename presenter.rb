require "terminal-table"
require "colorize"
require "date"

module Presenter
  def print_welcome
    puts "####################################"
    puts "#       Welcome to Expensable      #"
    puts "####################################"
  end

  def print_user_dashboard
    table = Terminal::Table.new
    table.title = "#{@current_type.upcase} \n #{@current_day.strftime('%B %Y')}".green
    table.headings = %w[ID Category Total].map(&:cyan)
    table.rows = @current_categories.map do |row|
      [row[:id], row[:name], money_amount(row[:transactions])]
    end
    puts table
  end

  def money_amount(data)
    money = 0
    data.each do |trans|
      money += trans[:amount]
    end
    money
  end

  def current_month
    Date.today
  end

  def next_date
    @current_day = @current_day.next_month
  end

  def prev_date
    @current_day = @current_day.prev_month
  end

  def print_categorie_table
    table = Terminal::Table.new
    table.title = "#{@current_name_category} \n #{@current_day.strftime('%B %Y')} ".green
    table.headings = %w[ID Date Amount Notes].map(&:cyan)
    if @current_category != []
      table.rows = @current_category[:transactions].map do |trans|
        [
          trans[:id],
          format_date(trans[:date]),
          trans[:amount],
          trans[:notes]
        ]
      end
    end
    puts table
  end

  def select_id(id)
    @current_category = @current_categories.find { |category| category[:id] == id } || []
  end

  def format_date(date)
    Date.parse(date).strftime("%a,%b %d")
  end

  def print_goodbye
    puts "####################################"
    puts "#    Thanks for using Expensable   #"
    puts "####################################"
  end
end
