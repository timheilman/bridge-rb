module Bridge
  class Suit < Struct.new(:order, :key)
    include Comparable

    def <=> other
      order <=> other&.order
    end

    def to_s
      key.to_s
    end


    Club    = new(0, :club     ).freeze
    Diamond = new(1, :diamond  ).freeze
    Heart   = new(2, :heart    ).freeze
    Spade   = new(3, :spade    ).freeze
    NoTrump = new(4, :no_trump ).freeze

    @all = [Club,Diamond,Heart,Spade,NoTrump].sort.freeze
    @card = (@all - [NoTrump]).freeze

    def self.all
      @all
    end

    def self.card # suits that can be used on cards
      @card
    end

    def initialize(*args)
      raise NoMethodError, "Cannot initialize a new suit"
    end
  end
end