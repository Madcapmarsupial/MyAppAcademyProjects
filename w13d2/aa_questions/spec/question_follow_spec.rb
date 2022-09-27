require_relative '../lib/question_follow'
require_relative '../lib/questions_database'
require 'rspec'

describe QuestionFollow do 
  before(:each) {QuestionsDatabase.reset!}
  after(:each) {QuestionsDatabase.reset!}


  describe '::followers_for_question_id' do 
    it "returns a list of User objects" do 
      users = described_class.followers_for_question_id(2)
      expect(users).to all(be_an(User))
    end

    it "returns all users who follow the given question" do
      users = described_class.followers_for_question_id(2)
      expect(users.map(&:id)).to contain_exactly(4, 2, 1)
    end
  end

  describe "::followed_questions_for_user_id" do 
    let(:temp_id) {2}
    let(:questions_list) {described_class.followed_questions_for_user_id(temp_id)}

    it "returns a list of question objects" do 
      expect(questions_list).to all(be_an(Question))
    end

    it "contains only followed questions " do
         compare_list = questions_list.select do |question|
          followers = described_class.followers_for_question_id(question.id)
          followers.map(&:id).include?(temp_id)
         end
         expect(compare_list).to eql(questions_list)
    end
  end 

  describe "::most_followed_questions" do 
    n = 2
    it "lists the n most followed questions" do 
      expect(described_class.most_followed_questions(n).map(&:title)).to eql(["starwars","Who?"])
    end

end