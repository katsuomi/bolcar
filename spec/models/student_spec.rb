require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student){build(:student)}
  let(:created_student){create(:student, :created)}

  describe "バリデーション" do
    it "メールアドレスとパスワードで登録可能" do
      expect(student).to be_valid
    end
    it "メールアドレスがなければ登録できない" do
      student_without_email = student
      student_without_email.email = ""
      expect(student_without_email).not_to be_valid
    end
    it "パスワードがなければ登録できない" do
      student_without_pwd = student
      student_without_pwd.password = ""
      expect(student_without_pwd).not_to be_valid
    end
    it "名前がなければ更新できない" do
      student_without_name = created_student
      student_without_name.name = ""
      expect(student_without_name).not_to be_valid
    end
    it "必須項目が満たされていれば更新可能" do
      expect(created_student).to be_valid
    end
  end
end
