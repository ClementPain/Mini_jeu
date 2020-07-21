class Game

	attr_accessor :human_player, :players_left, :ennemies_in_sight



	def initialize(player_name, nb_ennemies)
		@human_player = HumanPlayer.new(player_name)
		self.create_array_of_ennemies(4)
		@players_left = nb_ennemies
	end

	# méthode pour créer un groupe d'ennemis (appelée à l'initialisation)
	def create_array_of_ennemies(nb_ennemies)
		i=1
		@ennemies_in_sight = []

		nb_ennemies.times do
			
			create_ennemy(i)
			i+=1
		end
	end

	# méthode pour créer des ennemis
	def create_ennemy(nb_ennemy)
		y = 4 #n = nombre monstres différents
		@ennemies_in_sight << Player.new("Sorcière malicieuse#{nb_ennemy/y}") if nb_ennemy % y == 0
		@ennemies_in_sight << Player.new("Gobelin farceur#{nb_ennemy/y + 1}") if nb_ennemy % y == 1
		@ennemies_in_sight << Player.new("Ogre peureux#{nb_ennemy/y + 1}") if nb_ennemy % y == 2
		@ennemies_in_sight << Player.new("Dragon endormi#{nb_ennemy/y + 1}") if nb_ennemy % y == 3
	end

	# méthode pour éliminer un ennemie (appelée dans .menu_choice)
	def kill_player(player_to_kill)
		puts "#{player_to_kill.name} est mort"
		@ennemies_in_sight.delete(player_to_kill)
		@players_left -= 1
		STDIN.getch
	end

	# méthode pour que les bots attaquent le joueur (appelée dans .menu_choice)
	def ennemies_attack
		puts "Les ennemies attaquent #{@human_player.name} !"
		puts

		damages = 0

		#boucle pour faire attaquer les bots un par un
		@ennemies_in_sight.each do |bot|

			damages += bot.attacks(@human_player)

			# Vérifier que le player1 a gagné
			break if @human_player.life_points <= 0
		end
		puts
		puts "#{@human_player.name} subit #{damages} points de dégâts .."
	end

	# méthode pour ajouter des ennemies en vue
	def new_players_in_sight
		if @players_left > @ennemies_in_sight.length
			luck = rand(1..6)
			if luck == 1
				puts "Aucun nouvel ennemie en vue"
			
			elsif luck.between?(2, 6)
				i = @ennemies_in_sight.length + 1

				t = 1
				t = 2 if luck.between?(5,6) && players_left - ennemies_in_sight.length > 1 # choisir d'ajouter un ou deux ennemies

				t.times do
					create_ennemy(i)

					puts "Le nouvel ennemi #{@ennemies_in_sight[i-1].name} apparaît !"
					i += 1
				end
			end

		elsif @players_left == @ennemies_in_sight.length
			puts "Tous les ennemies sont déjà en vue"
		end

		STDIN.getch
		puts
	end


	# méthode pour savoir si le jeu continue
	def is_still_going?
		@human_player.life_points > 0 && @players_left > 0
	end

	# méthode pour voir l'état de la partie
	def show_players
		@human_player.show_state
		puts
		puts "Il reste #{@ennemies_in_sight.length} ennemies" if @ennemies_in_sight.length > 1
		puts "Il ne reste qu'un ennemie" if @ennemies_in_sight.length == 0
	end



	# menu affichage
	def menu
		puts "-----------------------------"
		puts "Quelle action veux-tu effectuer ?"
		puts 

		puts "a - chercher une meilleure arme (arme actuelle niveau #{@human_player.weapon_level})"
		puts "s - chercher à se soigner (vous avez actuellement #{@human_player.life_points} points de vie)"
		puts

		puts "attaquer un joueur en vue :"
		@ennemies_in_sight.each_with_index do |bot, i| 
			print "#{i} - "
			bot.show_state
		end

		puts
	end

	# menu choix
	def menu_choice(choice_player)

		if choice_player == "a"
			@human_player.search_weapon

		elsif choice_player == "s"
			@human_player.search_health_pack

		# # commande pour pouvoir quitter l'aventure
		# elsif choice_player == "!!!" || choice_player == "exit" || choice_player == "quit"
		# 	break

		# combat entre le joueur et les bots
		elsif choice_player.to_i.between?(0, @ennemies_in_sight.length-1)
			
			@human_player.attacks(@ennemies_in_sight[choice_player.to_i])

			#Supprimer l'ennemie du tableau s'il meurt
			self.kill_player(@ennemies_in_sight[choice_player.to_i]) if @ennemies_in_sight[choice_player.to_i].life_points <= 0

			puts
			
			# Les ennemies attaquent s'il y en a en vu
			ennemies_attack  if @ennemies_in_sight.length > 1
			puts
		else
			puts "Veuillez choisir une option disponible"
			puts
			STDIN.getch
		end

	end



	# Terminer par féliciter le joueur s'il a gagné
	def end
puts "#{@human_player.name} a vaincu tous les ennemies !" if @human_player.life_points > 0
puts
puts  "       o    .   _     ."
puts "          .     (_)         o"
puts "   o      ____            _       o"
puts "  _   ,-/   /)))  .   o  (_)   ."
puts" (_)  \\_\\  ( e(     O             _"
puts" o       \\/' _/   ,_ ,  o   o    (_)"
puts"  . O    _/ (_   / _/      .  ,        o"
puts"     o8o/    \\_/ / ,-.  ,oO8/( -TT"
puts"    o8o8O | } }  / /   \\Oo8OOo8Oo||     O"
puts'   Oo(""o8"""""""""""""""""""""""")'
 puts" _   `\\`'                  `'   /'   o"
puts" (_)    \\                       /    _   ."
puts"      O  \\           _         /    (_)"
puts"o   .     `-. .----<(o)_--. .-'"
 puts"  --------(_/------(_<_/--\\_)--------'"


		puts "Vous êtes mort ..." if @human_player.life_points <= 0
	end
end