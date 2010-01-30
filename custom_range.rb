#!/usr/bin/env ruby

class CustomRange
  attr_accessor :range_set

  def initialize(range_set)
    @range_set = range_set
  end
  
  def [](value)
    EndPoint.new value, @range_set
  end
end

class EndPoint
  attr_accessor :index

  def initialize(value, range_set)
    @range_set = range_set
    @index = self.send("index_from_" + value_type(value), value)
  end
  
  def index_from_integer(value)
    value % @range_set.size
  end
  
  def index_from_string(value)
    @range_set.index(value)
  end

  def index_from_symbol(value)
    index_from_string(value.to_s)
  end

  def succ
    EndPoint.new(@index + 1, @range_set)
  end

  def <=>(end_point)
    @index <=> end_point.index
  end
  
  def value_type(value)
    kind = [Integer, String, Symbol].find {|type| value.kind_of? type}.to_s.downcase
    puts kind
    return kind
  end
  
  def to_s
    @range_set[@index].to_s
  end
end
