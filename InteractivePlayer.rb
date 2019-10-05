
require_relative "PlayerInterface"
require_relative "Player"
require_relative "Card"
require_relative "Guess"
require_relative "Model"

#human player Class a subclass of PlayerInterface

class InteractivePlayer <  PlayerInterface
  attr_accessor :currentPindex, :cards #accessor for variables
  def initialize()
    @cards = []
    #initializing an array of cards it has --currently empty

  end

  #  A method setup that receives five parameters: the number of players in the game, the index
  #  of the current player (what player number am I?), a list of all the suspects, a list of all the
  #  locations and a list of all the weapons.
  def setup (number_of_players,currentPindex ,suspectlist,locationlist,weaponlist)
    @numberofplayers =number_of_players
    @currentPindex = currentPindex
    @suspectlist = suspectlist.clone
    @locationlist = locationlist.clone
    @weaponlist =weaponlist.clone
  end

  #A method setCard which indicates that the player has been dealt a particular card.
  def setCard (card)
    # player has been dealt a particular card
    @cards << card

  end

  #  This method represents that player i (which is different from the current player) has made
  #  guess g. The current player is responsible for “answering” that guess, if possible. The
  #  method should either return a card (which the current player has it their hand) or nil, to
  #  represent that the current player cannot answer that guess.
  def canAnswer(i,g )
    #player index i and guess g
    #player i has made a guess g
    returnCard = nil

    #selects the cards which matches the guess
    returnVal = @cards.select{
      |i|
      i.is_a?(Card) && (i.value== g.person.value || i.value== g.place.value ||i.value== g.weapon.value)

    }

    if returnVal[0]!=nil #if there are 1 or more than 1 cards that match the guess

      returnSize = returnVal.size

      if (returnSize>1) #more than 1
        puts ("Player #{i} asked you about #{g.to_s} Which do you show?")
        counter=0
        returnSize.times {
          #shows the choices of all the cards
          puts("#{counter} : #{returnVal[counter].value.to_s}")
          counter = counter+1

        }
        indexnum = gets.chomp.to_i

        #prompting user if it enters wrong values
        if (indexnum<0||indexnum>returnSize-1)
          while indexnum<0||indexnum>returnSize-1 do
            puts("Not Valid . Try Again")
            indexnum = gets.chomp.to_i

          end

        end
        returnCard = returnVal[indexnum]
        # puts the card in the returnCard

      else
        puts("Player #{i} asked you about #{g.to_s}, you only have one card, #{returnVal[0].value}, showed it to them.")
        returnCard = returnVal[0]
        #only one card case - in this case card is shown directly
      end

    else
      puts("Player #{i}  asked you about #{g.to_s}, but you couldn't answer.")
      #if it doesnt have a card that matches the guess

    end

    returnCard # returns the guess

  end

  #this method is called, it indicates that it is the
  #current player’s turn. The method should return the current player’s guess for that turn.
  #The guess may be a suggestion or an accusation.
  def getGuess ()
    guess = nil

    puts("It is your turn.")
    puts ("Which person do you want to suggest?")
    counter = 0

    @suspectlist.size.times {
      |i|
      puts("#{i} : #{@suspectlist[i].value.to_s}")

    }

    #shows all of the suspects and asks for choice

    indexsuspect = gets.chomp.to_i
    #checks if its in the given range

    if (indexsuspect<0||indexsuspect>@suspectlist.size-1)
      while indexsuspect<0||indexsuspect>@suspectlist.size-1 do
        puts("Not Valid . Try Again")
        indexsuspect = gets.chomp.to_i

      end

    end

    puts ("Which location do you want to suggest?")
    #asks for Location and shows choice to the user and also manages the range of values
    @locationlist.size.times {
      |i|
      puts("#{i} : #{@locationlist[i].value.to_s}")

    }

    indexlocation = gets.chomp.to_i
    if (indexlocation<0||indexlocation>@locationlist.size-1)
      while indexlocation<0||indexlocation>@locationlist.size-1 do
        puts("Not Valid . Try Again")
        indexlocation = gets.chomp.to_i

      end

    end

    puts ("Which weapon do you want to suggest?")
    #shows the values and manages the input value to be in the range

    @weaponlist.size.times {
      |i|
      puts("#{i} : #{@weaponlist[i].value.to_s}")

    }

    indexweapon = gets.chomp.to_i

    if (indexweapon<0||indexweapon>@weaponlist.size-1)
      while indexweapon<0||indexweapon>@weaponlist.size-1 do
        puts("Not Valid . Try Again")
        indexweapon = gets.chomp.to_i

      end

    end
    puts ("Is this an accusation (Y/[N])?")
    valueAccusation =   gets.chomp.upcase
    #converts to upperCase and checks if its an accusation or not
    #makes a guess based on that

    if valueAccusation== "Y"
      guess = Guess.new(@suspectlist[indexsuspect],@locationlist[indexlocation], @weaponlist[indexweapon],true)
    elsif valueAccusation == "N"
      guess = Guess.new(@suspectlist[indexsuspect],@locationlist[indexlocation], @weaponlist[indexweapon],false)

    end

    guess
  end

  #A method receiveInfo which has two parameters: a player index i and a card c. This
  #represents that the current player has made a guess (previously) and the player at index i
  #has one of the cards of the guess, c.
  def receiveInfo (i , c)

    if i>-1 && c!=nil
      #SomePlayer has the card of ur guess and refutes your guess
      puts("Player #{i} refuted your suggestion by showing you #{c.value}.")
    else
      #no one could refutr ur guess
      puts("No one could refute your suggestion.")

    end

  end

end