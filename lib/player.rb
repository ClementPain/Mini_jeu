class Player

	attr_accessor :name, :life_points

	# créer un joueur avec un nom et 10 points de vie
	def initialize(name_ini)
		@name = name_ini
		@life_points = 10
	end

	# montrer la barre de pdv du joueur
	def show_state
		puts "#{@name} n'a plus qu'un point de vie !" if @life_points == 1

		puts "#{@name} est mort" if @life_points == 0

		puts "#{@name} a #{life_points} points de vie" if @life_points.between?(2,10)
	end

	# méthode pour faire subir des dégâts à un joueur
	def gets_damage(damage_received)
		@life_points -= damage_received

		if @life_points <= 0
			@life_points = 0
			puts "#{@name} subi une attaque fatale !"
		end
	end

	# méthode pour calculer les dégâts causés par un joueur
  def compute_damage
    return rand(1..6)
  end

	# méthode pour qu'un joueur puisse en attaquer un autre : fait appel aux méthodes compute_damage (calculer les dégâts) & gets_damage (appliquer les dégâts)
	def attacks(player_attacked)
		puts "#{@name} attaque #{player_attacked.name}"
		damage_caused = compute_damage

		puts "#{@name} lui inflige #{damage_caused} points de dégâts !"
		player_attacked.gets_damage(damage_caused)
		
		STDIN.getch
		
		return damage_caused
	end
end

			


class HumanPlayer < Player
	
	attr_accessor :weapon_level

	# ajoute des pdv et une arme
	def initialize(name_ini)
		# print "Saisissez le nom de votre gladiateur : "

		@name = name_ini #gets.chomp

		@life_points = 100
		@weapon_level = 1

	end

	# modifier la méthode show_state pour afficher l'arme
	def show_state
		puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}" if @life_points.between?(2,100)
		puts "#{@name} est mort" if @life_points == 0
		puts "Attention ! #{@name} n'a plus qu'un point de vie !" if @life_points == 1
	end

	# prendre en compte le niveau de l'arme pour les dégâts infligés
	def compute_damage
		rand(1..6) * @weapon_level
	end

	# méthode pour chercher une nouvelle arme
	def search_weapon
		weapon_found_level = rand(1..6)
		puts "Tu as trouvé une arme de niveau #{weapon_found_level}"

		if weapon_found_level > @weapon_level
			@weapon_level = weapon_found_level
			puts "Tu as amélioré ton arme !"
			puts
			puts "         |>  _________________________________"
			puts " O[########[]_________________________________>"
      puts "         |> "


		else
			puts "Tu gardes ta bonne vieille épée, ce n'est pas cette rapière qui va te sauver"
		end

		STDIN.getch
		puts
	end

	# méthode pour récupérer des pdv
	def search_health_pack
		luck = rand(1..6)

		if luck == 1
			puts "Tu n'as rien trouvé..." 

		elsif luck.between?(2, 5)
			@life_points += 50
			@life_points = 100 if @life_points > 100
			puts "Bravo, tu as trouvé un pack de +50 points de vie !"
		
		elsif luck == 6
			@life_points += 80
			@life_points = 100 if @life_points > 100
			puts "Waow, tu as trouvé un pack de +80 points de vie !"
			puts
		end
		
		STDIN.getch
		puts
	end
end