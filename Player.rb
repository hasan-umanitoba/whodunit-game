

require_relative "PlayerInterface"
require_relative "Card"
require_relative "Guess"
require_relative "Model"
require_relative "InteractivePlayer"

class Player < PlayerInterface
  #subclass for Computer Player

  attr_accessor :currentPindex, :cards
  #accessor (getter) to get the variables
  def initialize()
    #cards held by a player
    @cards = []  ##Keeps tracks of the cards it has in hand
    @NobodyAnswered = false # this is a variable to indicate nobody has responded to the previous suggestion
    #in this if nobody answered it will make an accusation

  end

  # A method setup that receives five parameters: the number of players in the game, the index
  #  of the current player (what player number am I?), a list of all the suspects, a list of all the
  #  locations and a list of all the weapons.
  def setup (number_of_players,currentPindex ,suspectlist,locationlist,weaponlist)
    @numberofplayers =number_of_players
    @currentPindex = currentPindex
    @suspectlist = suspectlist.clone
    @locationlist = locationlist.clone
    @weaponlist =weaponlist.clone

  end

  def setCard (card)
    # player has been dealt a particular card
    @cards << card

  end

  #  method canAnswer which has two parameters: a player index i and a guess g. This
  #  method represents that player i (which is different from the current player) has made
  #  guess g. The current player is responsible for “answering” that guess, if possible. The
  #  method should either return a card (which the current player has it their hand) or nil, to
  #  represent that the current player cannot answer that guess.

  def canAnswer(i,g )
    #player index i and guess g
    #player i has made a guess g
    returnCard = nil

    returnVal =[]

    #selects the cards which matches the guess

    @cards.size.times {
      |i|  if @cards[i].value== g.person.value || @cards[i].value==g.place.value ||@cards[i].value==g.weapon.value
        returnVal << @cards[i]
      end

    }

    if returnVal[0]!=nil #if someCards matches the guess
      returnCard = returnVal[0]

    end

    returnCard #returns one of the card that matches

  end

  #If this method is called, it indicates that it is the
  #current player’s turn. The method should return the current player’s guess for that turn.
  #The guess may be a suggestion or an accusation.
  def getGuess ()
    guess = nil

    #We pick out the cards that we dont have in out hand
    #and for only those cards we can make a guess

    suspectdiff = @suspectlist - @cards
    suspect = suspectdiff[0]

    locationdiff = @locationlist - @cards

    location = locationdiff[0]

    weapondiff =@weaponlist - @cards

    weapon  = weapondiff[0]
    #end picking

    #the computer Player makes an Accusation when only 1 card from each suspected place , person and weapon remains

    if weapondiff.size==1 && locationdiff.size==1 && suspectdiff.size ==1
      guess = Guess.new(suspect,location,weapon,true)
      #this will be an accusation

    elsif @NobodyAnswered==true
      #the player can also accuse if nobody answered its suggestion in the previous turns

      guess = Guess.new(suspect,location,weapon,true)
    else
      #it makes a suggestion
      guess = Guess.new(suspect,location,weapon,false)

    end
    guess #returns guess

  end

  #method receiveInfo which has two parameters: a player index i and a card c. This
  #represents that the current player has made a guess (previously) and the player at index i
  #has one of the cards of the guess, c.
  def receiveInfo (i , c)
    #in this method if someone answered its guess its gonna eliminate that card from the suspected place , person or weapon

    if i>-1 && c!=nil
      if (@suspectlist.include?(c))
        @suspectlist.delete(c)
        #removes the card from suspectlist
      elsif (@weaponlist.include?(c))
        @weaponlist.delete(c)
        #removes the card from weaponlist it thinks can be answer
      elsif (@locationlist.include?(c))
        @locationlist.delete(c)
        #removes cards from locations that it thinks can be answer

        #this player eliminates one by one all of the places , person or weapons
        #which can be in the deck of solution

      end

    else
      @NobodyAnswered= true
      #if i==-1 and c is nil it means no one answered it no it can make an accusation in the turn

    end

  end

end

