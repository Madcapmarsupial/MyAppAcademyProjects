require_relative '../lib/model_base'

describe ModelBase do
  before(:each) { QuestionsDatabase.reset! }
  after(:each) { QuestionsDatabase.reset! }

  describe "::find_by_id" do 

    it "works with each model class" do 
      expect(User.find_by_id(1).fname).to eql('Seamus')
      expect(Question.find_by_id(1).title).to eql('Why?')
      expect(QuestionFollow.find_by_id(1).user_id).to eql(2)
      expect(QuestionLike.find_by_id(1).user_id).to eql(2)
      expect(Reply.find_by_id(1).user_id).to eql(6)
    end

    it "finds an object by id" do 
      expect(User.find_by_id(1).id).to eql(1)
      expect(User.find_by_id(1)).to be_a(User)
    end

  end

end