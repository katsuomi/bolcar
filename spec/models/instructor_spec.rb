require 'rails_helper'

RSpec.describe Instructor, type: :model do
  let(:instructor){build(:instructor)}
  let(:created_instructor){create(:instructor, :created)}

  describe "バリデーション" do
    it "メールアドレスとパスワードで登録可能" do
      expect(instructor).to be_valid
    end
    it "メールアドレスがなければ登録できない" do
      instructor_without_email = instructor
      instructor_without_email.email = ""
      expect(instructor_without_email).not_to be_valid
    end
    it "パスワードがなければ登録できない" do
      instructor_without_pwd = instructor
      instructor_without_pwd.password = ""
      expect(instructor_without_pwd).not_to be_valid
    end
    it "名前がなければ更新できない" do
      instructor_without_name = created_instructor
      instructor_without_name.name = ""
      expect(instructor_without_name).not_to be_valid
    end
    it "必須項目が満たされていれば更新可能" do
      expect(created_instructor).to be_valid
    end
  end
end
