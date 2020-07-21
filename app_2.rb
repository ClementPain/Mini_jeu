require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


puts "-------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"

puts

player1 = HumanPlayer.new

print "Combien d'ennemies voulez-vous affronter ? : " 
nb_ennemies = Integer(gets)

# méthode pour créer un groupe d'ennemies
def create_array_of_ennemies(nb_ennemies)
	i=1
	ennemies_array = []

	nb_ennemies.times do
		
		ennemies_array << Player.new("Sorcière nostaligique#{i/2}") if i % 2 == 0
		ennemies_array << Player.new("Gobelin farceur#{i/2 + 1}") if i % 2 == 1

		i+=1
	end
	return ennemies_array
end

# méthode pour faire se combattre deux ennemies
def fight_between_two_players(player1, player2)
	player1.attacks(player2)
	puts
end

# méthode pour que les bots attaquent le joueur
def bots_attack_player(player1, array_of_bots)
	puts "Les ennemies vous attaquent !"
	puts

	#boucle pour faire attaquer les bots un par un
	array_of_bots.each do |bot|

		fight_between_two_players(bot, player1) if bot.life_points > 0

		# Vérifier que le player1 a gagné
		break if player1.life_points <= 0
	end
end

#somme des points de vie des ennemies pour savoir si la partie est terminée
def bots_life_points(array_of_bots)
	sum_life_points = 0
	array_of_bots.each { |bot| sum_life_points += bot.life_points }
	return sum_life_points
end

# menu pour permettre au personnage de choisir ses actions
def menu(player1, nb_ennemies)
	
	array_of_ennemies = create_array_of_ennemies(nb_ennemies)

	while bots_life_points(array_of_ennemies) > 0 && player1.life_points > 0

		puts "Quelle action veux-tu effectuer ?"
		puts 

		puts "a - chercher une meilleure arme (arme actuelle niveau #{player1.weapon_level})"
		puts "s - chercher à se soigner (vous avez actuellement #{player1.life_points} points de vie)"
		puts

		puts "attaquer un joueur en vue :"
		array_of_ennemies.each_with_index do |bot, i| 
			print "#{i} - "
			bot.show_state
		end
		puts

		print "Votre choix : "
		choice_player = gets.chomp
		puts

		if choice_player == "a"
			player1.search_weapon

		elsif choice_player == "s"
			player1.search_health_pack

		# commande pour pouvoir quitter l'aventure
		elsif choice_player == "!!!" || choice_player == "exit" || choice_player == "quit"
			break

		# combat entre le joueur et les bots
		elsif choice_player.to_i.between?(0, nb_ennemies-1)
			if array_of_ennemies[choice_player.to_i].life_points > 0
				fight_between_two_players(player1, array_of_ennemies[choice_player.to_i])
				puts
				bots_attack_player(player1, array_of_ennemies) if bots_life_points(array_of_ennemies) > 0
			
			else
				puts "#{array_of_ennemies[choice_player.to_i].name} est mort"
				STDIN.getch
			end
		else
			puts "Veuillez choisir une option disponible"
			STDIN.getch
		end

		puts "-----------------------------"
	end

	# Terminé par féliciter le joueur s'il a gagné
	puts "#{player1.name} a vaincu tous les ennemies !" if player1.life_points > 0

	


	if player1.life_points <= 0
		puts "Vous êtes mort ..." 
		puts
end


puts

menu(player1, nb_ennemies)



binding.pry