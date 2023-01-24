require 'open-uri'
require 'nokogiri'
require 'csv'

# Programa
# Dada as seguintes ações:
# Construir a ação adicionar presentes:
# 1. Construir uma array com a lista de presentes
# 2. Receber o presente do usuário
# 3. Adicionar o Presente nessa lista
@christmas_list = []

def add(gift)
  @christmas_list << gift
  save_csv
end

# Construir a ação marcar um presente como comprado
# 1. Listar os presentes disponiveis na lista
# 2. Perguntar ao user, qual o presente a ser marcado
# 3. Seleciona na lista de presentes, o número selecionado pelo user
# 4. Mudar o parametro bought do item p/ true
def mark_as_bought(index)
  gift = @christmas_list[index - 1]
  gift[:bought] = true
  puts "#{gift[:name].capitalize} was marked as bought!"
  save_csv
end

# Construir a ação marcar de listar todos os presentes
# 1 - [ ] Playstation
# 2 - [ ] Air Fryer
def list
  @christmas_list.each_with_index do |gift, index|
    # if gift[:bought]
    #   bought = "[X]"
    # else
    #   bought = "[ ]"
    # end
    bought = gift[:bought] ? "[X]" : "[ ]"
    puts "#{index + 1} - #{bought} #{gift[:name].capitalize} | R$#{gift[:price]}"
  end
end

# Construir a ação de deletar um item da lista
# 1. Listamos p/ o user, os prensentes disponiveis
# 2. Perguntar qual o item ele quer deletar
# 3. Deletemos o item da lista
# 4. Listamos novamente a lista com os itens restantes
def delete(index)
  @christmas_list.delete_at(index - 1)
  puts "Item was deleted!"
  save_csv
end

def ideia(gift)
  url = "https://www.etsy.com/search?q=#{gift}"
  html_doc = URI.open(url).read
  document = Nokogiri::HTML.parse(html_doc)
  cards = document.search(".v2-listing-card__info")
  etsy_list = []
  cards.each do |item|
    etsy_name = item.search(".v2-listing-card__title").text.strip
    etsy_symbol = item.search(".lc-price .currency-symbol").text.strip
    etsy_price = item.search(".lc-price .currency-value").text.strip.to_f.truncate(10)
    etsy_list << { name: etsy_name, price: etsy_price }
  end
  etsy_list
end

def display(list)
  list.each_with_index do |item, index|
    puts "#{index + 1}. #{item[:name]} - R$#{item[:price]}"
  end
end

def load_csv
  file_path = "data/gifts.csv"
  CSV.foreach(file_path, headers: :first_row) do |item|
    gift = {name: item['name'], price: item['price'].to_f, bought: (item['bought'] != "false")}
    @christmas_list << gift
  end
  @christmas_list
end

def save_csv
  file_path = "data/gifts.csv"
  CSV.open(file_path, "wb", col_sep: ",", force_quotes: true, quote_char: '"') do |file|
    # O primeiro passo p/ salvar no CSV é colocar os headers
    file << ["name", "price", "bought"]
    @christmas_list.each do |gift|
      file << [gift[:name], gift[:price], gift[:bought]]
    end
  end
end