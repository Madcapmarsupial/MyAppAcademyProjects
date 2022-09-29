require_relative '../lib/question'
require_relative '../lib/questions_database'
require 'rspec'

describe Question do 
  before(:each) {QuestionsDatabase.reset!}
  after(:each) {QuestionsDatabase.reset!}
  subject(:test_q) {described_class.new("id" => 15, "title" => "Who?", "body" => "Who did that?", "user_id" => 2)}


  describe '::find_by_author_id' do
    let(:question_list) {described_class.find_by_author_id(2) }

    it 'returns an array of the given class' do
      expect(question_list).to all(be_a(described_class))
    end

    it "only returns Question objects with the given id" do 
      expect(question_list.all? { |question| question.user_id == 2 } ).to be(true)
    end
  end

  describe "::most_followed" do 
    let (:list) {described_class.most_followed(2)} 

    it "returns a list of n length" do 
      expect(list.count).to eq(2)
    end

    it "returns only questions objects" do 
      expect(list).to all(be_an(described_class)) 
    end

    it "returns a descending list" do 
      expect(list[0].followers.count > list[1].followers.count).to be(true)
    end
  end

  describe "::most_liked" do 
    let(:questionlike) { class_double('QuestionLike').as_stubbed_const }

    it "calls QuestionLike::most_liked_questions" do 
        expect(questionlike).to receive(:most_liked_questions).with(2)
        described_class.most_liked(2)
    end
  end

  describe "#author" do
    let (:user) {class_double('User').as_stubbed_const }

    it "calls User::find_by_id" do
        expect(user).to receive(:find_by_id).with(2)
        test_q.author
    end
  end

  describe "#replies" do 
    let(:reply) {class_double('Reply').as_stubbed_const }
    
    it "calls Reply::find_by_question_id" do 
      expect(reply).to receive(:find_by_question_id).with(15)
      test_q.replies
    end
  end

  describe "#followers" do 
    let(:follower) {class_double('QuestionFollow').as_stubbed_const }

    it "calls QuestionFollow::followers_for_question_id" do 
      expect(follower).to receive(:followers_for_question_id).with(15)
      test_q.followers
    end
  end

  describe "#likers" do 
    let(:like) {class_double('QuestionLike').as_stubbed_const }

    it "calls QuestionLike::likers_for_question_id" do 
      expect(like).to receive(:likers_for_question_id).with(15)
      test_q.likers
    end
  end

  describe "#num_likes" do 
    let(:like) {class_double('QuestionLike').as_stubbed_const }

    it "calls QuestionLike::num_likes_for_question_id" do 
      expect(like).to receive(:num_likes_for_question_id).with(15)
      test_q.num_likes
    end
  end




end

