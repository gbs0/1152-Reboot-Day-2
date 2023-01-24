# Programa
# Dada as seguintes ações:
# Construir a ação adicionar presentes:
# 1. Construir uma array com a lista de presentes
# 2. Receber o presente do usuário
# 3. Adicionar o Presente nessa lista
@christmas_list = []

def add(gift)
  @christmas_list << gift
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
    puts "#{index + 1} - #{bought} #{gift[:name].capitalize}"
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
end
