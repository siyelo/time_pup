require 'spec_helper'

describe TimePup::IncrementalTime do
  def incremental_time(time)
    TimePup::IncrementalTime.parse(time).to_i
  end

  it "should detect the minutes" do
    incremental_time("2minutes").should == 2.minutes.from_now.to_i.to_i
  end

  it "should detect the minutes (m) (complex)" do
    incremental_time("5m").should == 5.minutes.from_now.to_i
  end

  it "should detect the minutes(mi) (complex)" do
    incremental_time("5mi").should == 5.minutes.from_now.to_i
  end

  it "should detect the minutes(min) (complex)" do
    incremental_time("5min").should == 5.minutes.from_now.to_i
  end

  it "should detect the hours" do
    incremental_time("2hours").should == 2.hours.from_now.to_i
  end

  it "should detect the hours (complex)" do
    incremental_time("5h").should == 5.hours.from_now.to_i
  end

  it "should detect the days" do
    incremental_time("2days").should == 2.days.from_now.to_i
  end

  it "should detect the days (complex)" do
    incremental_time("5d").should == 5.days.from_now.to_i
  end

  it "should detect the weeks" do
    incremental_time("2weeks").should == 2.weeks.from_now.to_i
  end

  it "should detect the weeks (complex)" do
    incremental_time("5w").should == 5.weeks.from_now.to_i
  end

  it "should detect the months" do
    incremental_time("2months").should == 2.months.from_now.to_i || 2.months.from_now.to_i + 1
  end

  it "should detect the months (complex)" do
    incremental_time("5mo").should == 5.months.from_now.to_i
  end

  it "should detect the years" do
    incremental_time("2years").should == 2.years.from_now.to_i
  end

  it "should detect the years (complex)" do
    incremental_time("5y").should == 5.years.from_now.to_i
  end

  context 'combinations' do
    let(:duration) { (2.years + 3.months + 12.days + 23.hours + 1.minute).from_now.to_i }
    it "should detect everything" do
      incremental_time("2years3months12days23hours1minute").to_i.
        should == duration
    end

    it "should work with composite times" do
      incremental_time("2y3mo12d23h1m").to_i.
        should == duration
    end

    it "should work with a mixture of composite and non times" do
      incremental_time("2years3mo12days23h1min").to_i.
      should == duration
    end
  end

  # if today is 30th day in a month of 31 days (and next month has 30 days)
  # then Time.now + 1.day + 1.month != Time.now + 1.month + 1.day
  # i.e.:
  # 30 March + 1.day  == 31 March
  # 31 March + 1.month = 30 April
  # -------------------------------
  # 30 March + 1.month == 30 April
  # 30 April + 1.day == 31 April

  it "should match increments in decending order (years to minutes) regardless of email order" do
    Time.stub(:now).and_return Time.parse '30-03-2011'
    incremental_time("1d1mo1y").to_i.
      should == Time.parse('31-04-2012').to_i
  end

  it "should return nil if unparseable" do
    TimePup::IncrementalTime.parse("jiosj").should be_nil
  end

  it "should not try parse Mar / March as minutes" do
    TimePup::IncrementalTime.parse("31mar").should be_nil
    TimePup::IncrementalTime.parse("31march").should be_nil
  end

  it "should downcase email before parsing" do
    incremental_time("5Min").should == 5.minutes.from_now.to_i
  end

  it "can parse decimals for days" do
    incremental_time('1.5d').should == (1.5).days.from_now.to_i
  end

  it "can parse decimals for days" do
    incremental_time('3.5h').should == (3.5).hours.from_now.to_i
  end
end
