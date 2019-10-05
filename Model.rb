
#Purpose :
#this class manages all of the players of the game, all the cards in the game and the turns of the board. You will write this class

require_relative "Player"
require_relative "Card"
require_relative "Guess"
require_relative "InteractivePlayer"
require_relative "PlayerInterface"

#loads all of the required Classes
class Model
  def initialize(people,places,weapons)

    #initializes people places and weapons given to it

    @people = people
    @places = places
    @weapons = weapons
    #stores all of the players cards and runs the game
    @answerCriminal=nil
    @answerLocation=nil
    @answerWeapon=nil
    #also holds the answer cards

    @players = nil
    #keeps tracks of the players as well

  end

  #  takes one parameter: an array of players in the game. The players
  #  are  initialized by this method, including calling the setup method
  def setPlayers (playerArray)

    puts("Here are the names of all the suspects:")
    stringPeople = []
    @people.each {
      |i|  stringPeople <<i.value

    }
    puts(stringPeople.join(" , "))
    #prints all of the suspects

    puts("Here are all the locations:")

    stringLocations = []
    @places.each {
      |i|  stringLocations <<i.value

    }
    puts(stringLocations.join(" , "))

    #prints all of the locations separated by comma

    puts("Here are all the weapons:")
    stringweapons = []
    @weapons.each {
      |i|  stringweapons <<i.value

    }
    puts(stringweapons.join(" , "))

    #prints all of the Weapons separated by comma

    @players = playerArray.clone
    #Model makes clone of the Players to keep track of the game properly

    index = 0 #we set players and assign them index arbitrarily
    indexarray = (0..playerArray.size-1).to_a
    @players.each{|i| i.setup(@players.size,indexarray[index],@people,@places,@weapons)
      index=index+1}

  end

  #A method setupCards that does all of the setup for cards before a game starts. This method
  #takes no parameters. This method should choose the answer for the game (the criminal, the
  #location and the weapon) and then distribute all remaining cards to the players
  def setupCards ()

    @people= @people.shuffle
    @places= @places.shuffle
    @weapons= @weapons.shuffle
    #shuffles people places and weapons

    @answerCriminal = @people.pop
    @answerLocation=@places.pop
    @answerWeapon=@weapons.pop
    #got the answer
    #distribute all of the remaining cards to players now

    totalplayers =@players.size

    #We fill and shuffle OneDeck Which consists of people places and weapons

    index = 0
    distributingDeck = []
    @people.size.times  {
      distributingDeck << @people[index]
      index=index+1 }

    index = 0
    @places.size.times  {

      distributingDeck << @places[index]
      index=index+1

    }

    index = 0

    @weapons.size.times {
      distributingDeck << @weapons[index]
      index=index+1

    }

    #distributingdeck contains all other cards now
    sizeDeck = distributingDeck.size
    distributingDeck = distributingDeck.shuffle

    #End filling of Deck here

    index= 0  #we setCard starting from Player 0

    sizeDeck.times {
      cardPopped = distributingDeck.pop

      if  index==totalplayers-1
        puts("you received the card " +cardPopped.value)

      end
      @players[index].setCard(cardPopped)#setting Card

      index=(index+1)%totalplayers #moves next player
    }

  end

  #A method play that runs the game. This method takes no parameters

  def play ()

    gameOverBool = false #Game over Boolean
    index = 0 #index of Active Player

    indexRemoved = []  #array which contains indexes of that players who have made wrong Accusations and are removed from the game

    while gameOverBool!= true do
      #while game is not over:
      #  ask active player for their guess

      if indexRemoved.include?(index) #chcks the indexRemovedArray
        #do nothing #if a player is removed he cannot make guess : he can only answer the guesses
      else
        puts("Current turn: #{index}")
        retreivedGuess=    @players[index].getGuess()
        puts ("Player #{index} : #{retreivedGuess.to_s}")
        #Makes a Guess - made by Active Player

        if retreivedGuess.isAccusation()
          #check if the accusation is correct
          if retreivedGuess.person.value == @answerCriminal.value && retreivedGuess.place.value==@answerLocation.value &&retreivedGuess.weapon.value== @answerWeapon.value
            #if all correct
            #game over
            puts("Player #{index} won the game")
            gameOverBool = true
            break
          else
            #ifnot correct active player is removed from the game
            puts("Player #{index} made a bad accusation and was removed from the game.")
            indexRemoved<< index

            if (@players.size-indexRemoved.size)==1 #if only one player left
              puts("Player #{index-1} won the game")
              gameOverBool= true
              break

            end

          end

        else
          #ask players if they can respond to the guests
          numPlayers_ask = @players.size-1
          count = (index +1 )% @players.size #ask next players if it can respond

          answered = false #this variables keeps teack whether someone has answered a guess or not

          numPlayers_ask.times {
            puts("Asking player #{count}")

            answer = @players[count].canAnswer( index,retreivedGuess)
            #if it can answer
            if answer!=nil
              answered = true
              @players[index].receiveInfo(count, answer)#providing the answer
              puts ("Player #{count} answered")

              break

            end
            count = (count +1 )% @players.size #moves next
          }
          if answered== false #if no one answered
            puts("No one could answer.")
            @players[index].receiveInfo(-1, nil)#providing the answer

          end

        end

      end
      if gameOverBool!= true #if game has not ended #moves to next Player
        index = (index+1)%@players.size

      end

    end#endwhileloop

  end #endplay

end

