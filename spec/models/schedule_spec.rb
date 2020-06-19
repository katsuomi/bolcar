require 'rails_helper'

RSpec.describe Schedule, type: :model do
  let(:schedule){build(:schedule)}

  describe "バリデーション" do
    it "日時が3時間後以降であれば登録可能" do
      expect(schedule).to be_valid
    end
    it "今日より前のシフトは登録できない" do
      schedule_yesterday = schedule
      schedule_yesterday.date = Date.yesterday
      expect(schedule_yesterday).not_to be_valid
    end
    it "今から2時間後のシフトは登録できない" do
      schedule_in_2_hours = schedule
      schedule_in_2_hours.date = 2.hours.since
      schedule_in_2_hours.start_time = 2.hours.since
      expect(schedule_in_2_hours).not_to be_valid
    end
  end

  describe "#previous?" do
    it "2時間前と比較すると真" do
      schedule_2_hour_ago = schedule
      schedule_2_hour_ago.date = 2.hours.ago
      schedule_2_hour_ago.start_time = 2.hours.ago
      expect(schedule_2_hour_ago.previous?).to be_truthy
    end
    it "2時間後と比較すると偽" do
      schedule_in_2_hour = schedule
      schedule_in_2_hour.date = 2.hours.since
      schedule_in_2_hour.start_time = 2.hours.since
      expect(schedule_in_2_hour.previous?).to be_falsey
    end
  end
end
