require 'spec_helper'

describe 'Reservations Controller' do

  include Rack::Test::Methods

  def app
    Application
  end

  before(:all) do
    @expires = Time.now.to_i + 60
  end

  it "should create a reservation" do
    get '/reservations/create', {
      :environment => 'test',
      :seconds => @expires - Time.now.to_i,
      :user => 'tester'
    }
    Yajl::Parser.parse(last_response.body).symbolize_keys.should == {
      :expires => @expires,
      :status => 'reserved',
      :user => 'tester'
    }
  end
  
  it "should get a reservation" do
    get '/reservations/show', { :environment => 'test' }
    Yajl::Parser.parse(last_response.body).symbolize_keys.should == {
      :expires => @expires,
      :status => 'reserved',
      :user => 'tester'
    }
  end

  it "should destroy a reservation" do
    get '/reservations/destroy', { :environment => 'test' }
    Yajl::Parser.parse(last_response.body).symbolize_keys.should == {
      :expires => @expires,
      :status => 'reserved',
      :user => 'tester'
    }
    get '/reservations/show', { :environment => 'test' }
    Yajl::Parser.parse(last_response.body).symbolize_keys.should == {
      :status => 'available'
    }
    get '/reservations/destroy', { :environment => 'test' }
    Yajl::Parser.parse(last_response.body).symbolize_keys.should == {
      :status => 'available'
    }
  end
end