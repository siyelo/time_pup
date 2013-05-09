require 'spec_helper'

describe TimePup::TimeParser do
  it "should return the reminder time - 12 hour format with period" do
    time = "10am"
    TimePup::TimeParser.parse(time).hour.should == 10
    TimePup::TimeParser.parse(time).min.should == 00
    time = "10pm"
    TimePup::TimeParser.parse(time).hour.should == 22
    TimePup::TimeParser.parse(time).min.should == 00
    time = "9pm"
    TimePup::TimeParser.parse(time).hour.should == 21
    TimePup::TimeParser.parse(time).min.should == 00
  end

  it "should return the reminder time - 12 hour format with period and minutes" do
    time = "1030am"
    TimePup::TimeParser.parse(time).hour.should == 10
    TimePup::TimeParser.parse(time).min.should == 30
    time = "1030pm"
    TimePup::TimeParser.parse(time).hour.should == 22
    TimePup::TimeParser.parse(time).min.should == 30
    time = "930pm"
    TimePup::TimeParser.parse(time).hour.should == 21
    TimePup::TimeParser.parse(time).min.should == 30
  end

  it "should return the reminder time - 24 hour format" do
    time = "22"
    TimePup::TimeParser.parse(time).hour.should == 22
    TimePup::TimeParser.parse(time).min.should == 00
    time = "10"
    TimePup::TimeParser.parse(time).hour.should == 10
    TimePup::TimeParser.parse(time).min.should == 00
    time = "9"
    TimePup::TimeParser.parse(time).hour.should == 9
    TimePup::TimeParser.parse(time).min.should == 00
  end

  it "should return the reminder time - 24 hour format with minutes" do
    time = "2230"
    TimePup::TimeParser.parse(time).hour.should == 22
    TimePup::TimeParser.parse(time).min.should == 30
    time = "1030"
    TimePup::TimeParser.parse(time).hour.should == 10
    TimePup::TimeParser.parse(time).min.should == 30
    time = "930"
    TimePup::TimeParser.parse(time).hour.should == 9
    TimePup::TimeParser.parse(time).min.should == 30
  end

  it "should set the time in the future" do
    time = (Time.now.utc.hour - 1).to_s
    TimePup::TimeParser.parse("#{time}am").day.should == Time.now.utc.day + 1
  end

  it "should adjust the UTC time based on the given time zone" do
    time = '10am'
    TimePup::TimeParser.parse(time, 'Harare').hour.should == 8 #10am CAT == 8am UTC
  end
end
