require 'yajl'

class Reservation

  attr_reader :attributes

  @@namespace = "maitre_d"

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

  def symbolize_keys(hash)
    hash.inject({}) do |options, (key, value)|
      options[(key.to_sym rescue key) || key] = value
      options
    end
  end

  def get
    if val = $redis.get(key)
      val = symbolize_keys(Yajl::Parser.parse(val))
    else
      val = {}
    end
    @attributes = val.merge(:environment => environment)
    val
  end

  def key
    raise "environment option not present" unless attributes[:environment]
    "#{@@namespace}:#{attributes[:environment]}"
  end

  def self.find(attributes)
    res = self.new(attributes)
    res.get
    res
  end

  def self.all
    $redis.keys("#{@@namespace}:*").map do |key|
      m = key.match(/maitre_d\:(.*)\:?/)
      find(:environment => m[1]) if m and m[1]
    end.compact
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