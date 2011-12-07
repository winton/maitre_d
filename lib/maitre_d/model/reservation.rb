require 'yajl'

class Reservation

  attr_reader :attributes

  def initialize(attributes={})
    @attributes = attributes
  end
  
  def create
    $redis.set(key, Yajl::Encoder.encode(value))
    $redis.expireat(key, expire_at.to_i)
    self
  end

  def destroy
    $redis.del(key)
  end

  def environment
    @attributes[:environment]
  end

  def exists?
    !@attributes[:user].nil?
  end

  def expire_at
    Time.at(Time.now.to_i + attributes[:seconds].to_i)
  end

  def get
    if val = $redis.get(key)
      val = Yajl::Parser.parse(val).symbolize_keys
    else
      val = {}
    end
    @attributes = val.merge(:environment => environment)
    val
  end

  def key
    raise "environment option not present" unless attributes[:environment]
    "maitre_d:#{attributes[:environment]}"
  end

  def self.find(attributes)
    res = self.new(attributes)
    res.get
    res
  end

  def to_response
    if exists?
      Yajl::Encoder.encode(value.merge(:status => 'reserved'))
    else
      Yajl::Encoder.encode({ :status => 'available' })
    end
  end

  def user
    @attributes[:user]
  end

  def value
    {
      :branch => @attributes[:branch],
      :expires => @attributes[:expires] || expire_at.to_i,
      :user => @attributes[:user]
    }
  end
end