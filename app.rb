require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'



	#Code permettant le déroulement du jeu
def game1
	puts "Game On !"

	STDIN.getch

	puts

	puts "A ma droite José !"
	player1 = Player.new("José")

	STDIN.getch

	puts

	puts "A ma gauche André !"
	player2 = Player.new("André")

	STDIN.getch

	puts

	puts "FIGHT !"

	puts
end






# méthode pour faire combattre deux personnages, le player1 commence à attaquer
def fight_two_players(player1, player2)
	# créer ces variables afin de pouvoir aleterner les rôles
	player_attacking = player1
	player_defending = player2

	while player_defending.life_points > 0

		# Montrer les pdv une attaque sur deux
		if player_attacking == player1
			puts "#{player1.name} a #{player1.life_points} points de vie et #{player2.name} a #{player2.life_points} points de vie"
			puts 
		end

		STDIN.getch

		player_attacking.attacks(player_defending)

		# alterner les rôles attaquant et défenseur
		if player_defending.life_points > 0
			stock_player = player_attacking
			player_attacking = player_defending
			player_defending = stock_player
		end

		STDIN.getch
		puts
	end

	puts "#{player_attacking.name} a gagné !"
end


binding.pry