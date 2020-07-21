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

# puts nb_ennemies = Integer(gets)

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
def fight_two_players(player1, player2)
	# créer ces variables afin de pouvoir aleterner les rôles
	attacker = player1
	defender = player2

	while defender.life_points > 0

		# Montrer les pdv une attaque sur deux
		if attacker == player1
			puts "#{player1.name} a #{player1.life_points} points de vie et #{player2.name} a #{player2.life_points} points de vie"
			STDIN.getch
			puts 
		end

		# procéder à l'attaque
		attacker.attacks(defender)

		# alterner les rôles attaquant et défenseur
		if defender.life_points > 0
			stock_player = attacker
			attacker = defender
			defender = stock_player
		end

		STDIN.getch
		puts
	end
end

# méthode pour permettre au joueur d'attaquer tous les ennemies à la suite
def fight_all_bots(player1, array_of_bots)
	puts "Vous attaquez tous les ennemies !"
	puts

	#boucle pour combattre les bots un par un
	array_of_bots.each_with_index do |bot, i|
		
		puts "Vous attaquez #{bot.name}"
		puts

		fight_two_players(player1, bot)

		# Vérifier que le player1 a gagné
		if player1.life_points > 0
			puts "Bravo, vous avez vaincu #{bot.name} !"
			puts
			# puts "Mais un nouvel adversaire se présente.." if i < ( array_of_bots.length -1 )
		else
			puts "Vous êtes mort..."
			break
		end
	end
end

# menu pour permettre au personnage de choisir ses actions
def menu(player1, nb_ennemies)
	
	array_of_ennemies = create_array_of_ennemies(nb_ennemies)

	while true

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

		puts "z - attaquer tous les ennemies à la suite"
		puts

		print "Votre choix : "
		choice_player = gets.chomp
		puts

		if choice_player == "a"
			player1.search_weapon

		elsif choice_player == "s"
			player1.search_health_pack

		elsif choice_player == "z"
			fight_all_bots(player1, array_of_ennemies)

		elsif choice_player == "!!!" || choice_player == "exit" || choice_player == "quit"
			break

		elsif choice_player.to_i.between?(0, nb_ennemies-1)
			fight_two_players(player1, array_of_ennemies[choice_player.to_i])

		else
			puts "Veuillez choisir une option disponible"
		end

		STDIN.getch
		puts "-----------------------------"
	end

	# Terminé par félicité le joueur s'il a gagné
	# puts "#{player1.name} a vaincu tous les ennemies !" if player1.life_points > 0
end



puts




binding.pry