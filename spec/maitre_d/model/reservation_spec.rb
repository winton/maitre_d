require 'spec_helper'

describe Reservation do

  before(:each) do
    @res = Reservation.new(:seconds => 60, :user => 'tester', :environment => 'test')
    @res.create
  end

  describe :create do

    it "should create redis entry" do
      @res.get.should == {
        :expires => Time.now.to_i + 60,
        :user => 'tester'
      }
    end

    it "should set ttl" do
      $redis.ttl(@res.key).should == 60
    end
  end

  describe :destroy do

    it "should delete redis entry" do
      @res.destroy
      $redis.get(@res.key).should == nil
    end
  end

  describe :find do

    it "should return Reservation" do
      Reservation.find(:environment => 'test').attributes.should == {
        :environment => 'test',
        :expires => Time.now.to_i + 60,
        :user => 'tester'
      }
    end

    it "should not return Reservation" do
      @res.destroy
      Reservation.find(:environment => 'test').exists?.should == false
    end
  end

  describe :to_response do

    it "should show reserved" do
      Yajl::Parser.parse(@res.to_response).symbolize_keys.should == {
        :expires => Time.now.to_i + 60,
        :status => 'reserved',
        :user => 'tester'
      }
    end

    it "should show available" do
      @res.destroy
      @res.get
      Yajl::Parser.parse(@res.to_response).symbolize_keys.should == {
        :status => 'available'
      }
    end
  end
end