Pry.commands.alias_command "q", "exit"
Pry.commands.alias_command "wh", "whereami"

# Pry.config.editor = proc { |file, line| "vim +#{line} #{file}"} TODO

# for online docs ("? <object>")
begin
  require "pry-doc"
rescue LoadError => e
end

Pry.commands.alias_command "wh", "whereami"

# step debugging
begin
  require "pry-nav"
  Pry.commands.alias_command "c", "continue"
  # Pry.commands.alias_command "c", "continue" rescue nil # TODO
  Pry.commands.alias_command "s", "step"
  # Pry.commands.alias_command "s", "step" rescue nil # TODO
  Pry.commands.alias_command "n", "next"
  # Pry.commands.alias_command "n", "next" rescue nil # TODO
rescue LoadError => e
end

begin
  require "looksee"
rescue LoadError => e
end

# pretty-print
begin
  require "awesome_print"
  # # The following line enables awesome_print for all pry output,
  # # and it also enables paging
  # Pry.config.print = proc {|output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output)}

  AwesomePrint.pry!

  # If you want awesome_print without automatic pagination, use the line below
  # Pry.config.print = proc { |output, value| output.puts value.ai }
rescue LoadError => e
  puts "gem install awesome_print"
end

# TODO: no vim keybindings
# # history search with fzf (requires fzf)
# require 'rb-readline'
# require 'readline'
# def RbReadline.rl_reverse_search_history(sign, key)
#   rl_insert_text `cat ~/.pry_history | fzf --tac | tr '\n' ' '`
# end

# TODO https://github.com/janlelis/clipboard/
if RUBY_PLATFORM.include? 'darwin'
  def pbcopy(str)
    IO.popen('pbcopy', 'r+') { |io|
      io.puts str.is_a?(String) ? str : str.inspect
    }
  end

  # Pry.config.commands.command 'hist2copy', 'Copy a history to clipboard' do |n|
  #   pbcopy _pry_.input_array[n ? n.to_i : -1]
  # end

  Pry.config.commands.command 'clip', 'Copy the last result to clipboard' do
    pbcopy _pry_.last_result.chomp
  end
end

alias :r :require

Pry.commands.alias_command 'clear', 'clear-screen'

# Pry::Prompt TODO
Pry.prompt = [proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " }, proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }]

# Pry.config.ls.separator = "\n" # TODO sort

Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black

default_command_set = Pry::CommandSet.new do
  command "copy", "Copy argument to the clip-board" do |str|
    IO.popen("pbcopy", "w") { |f| f << str.to_s }
  end

  if ENV["RAILS_ENV"]
    command "clear" do
      system "clear"
      output.puts "Rails Environment: " + ENV["RAILS_ENV"]
    end
  end

  if ENV["RAILS_ENV"] || defined?(Rails)
    command "sql", "Send sql over AR." do |query|
      pp ActiveRecord::Base.connection.select_all(query)
    end
  end

  command "caller_method" do |depth|
    depth = depth.to_i || 1
    if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(depth + 1).first
      file = Regexp.last_match[1]
      line = Regexp.last_match[2].to_i
      method = Regexp.last_match[3]
      output.puts [file, line, method]
    end
  end
end

Pry.config.commands.import default_command_set

# TODO
# require 'rubygems'
# require '~/.irb/irb/pry_loader'
# require '~/.irb/irb/awesome_print_loader'
