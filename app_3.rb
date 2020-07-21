require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


puts "--------------------------------------------------------|"
puts "|Bienvenue dans la forêt enchantée                      |"
puts "|Le but du jeu est d'éradiquer les monstres de la forêt |"
puts "|(pour pouvoir se la raconter auprès de la princesse...)|"
puts "---------------------------------------------------------"

puts

print "Saisissez le nom de votre chevalier servant : "
name_player = gets.chomp

nb_ennemies = 10 #valeur par défault
# print "Combien d'ennemis voulez-vous combattre ? (minimum 4) : "
# nb_ennemies = gets.chomp.to_i

my_game = Game.new(name_player, nb_ennemies)
puts

# tant que le jeu continue
while my_game.is_still_going?
	
	#afficher le menu
	my_game.menu

	print "Votre choix : "
		choice_player = gets.chomp
	puts

	my_game.menu_choice(choice_player)

	break if my_game.is_still_going? == false
	my_game.new_players_in_sight
end

my_game.end


binding.pry