# Interface
# 1. Fazer as boas vindas
# 2. Mostrar o menu de opções
# 3. Dar ao usuário a opção de escolher a ação
# 4. Performar essa ação
# 5. Voltar ao passo 2
require_relative "app"

puts "🎅🏼 Welcome to your Christmas List!"

def print_actions
  puts "Please select an action to start:"
  puts "1 - Add a Gift"
  puts "2 - Mark Gift As Bought"
  puts "3 - List all Gifts"
  puts "4 - Exit"
  print "> "
end

def dispatch_action(user_choice)
  case user_choice
    when "1"
      # Adicionar um presente
      puts "What's gift name you want to add:"
      gift_name = gets.chomp
      gift = { name: gift_name.downcase, bought: false }
      add(gift)
    when "2"
      # Marcar um presente como comprado
      list
      puts "Select the number of your gift:"
      user_choice = gets.chomp.to_i # Indíce do presente
      mark_as_bought(user_choice)
      list
    when "3"
      # Listar todos os presentes
      puts "Here are your gifts:"
      list
    when "4"
      puts "Bye bye!"
      exit
    else
      puts "Ação Inválida"
  end
end

loop do
  print_actions
  user_choice = gets.chomp
  dispatch_action(user_choice)
end