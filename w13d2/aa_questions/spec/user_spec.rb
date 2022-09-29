require_relative '../lib/user'

describe User do 
  before(:each) {QuestionsDatabase.reset!}
  after(:each) {QuestionsDatabase.reset!}
    subject (:user)  { described_class.find_by_name('Bob', 'Hoskins') }


  describe "::find_by_name" do

    it "returns a User object" do 
      expect(user).to be_a(described_class)
    end

    it "returns the target user if in data base" do 
      expect(user.fname).to eql('Bob')
      expect(user.lname).to eql('Hoskins')
    end 

    it "raises error if not found in database" do 
      expect{ described_class.find_by_name('JACK', 'Pallets')}.to raise_error("Entry not found in database") 
    end 
  end

  describe "#followed_questions" do
    let(:follow) {class_double("QuestionFollow").as_stubbed_const}

    it "returns an array of Question objects" do 
      expect(user.followed_questions).to be_a(Array)
      expect(user.followed_questions).to all(be_an(Question))
    end

    it "calls QuestionFollow::followed_questions_for_user_id" do 
     expect(follow).to receive(:followed_questions_for_user_id).with(user.id)
     user.followed_questions
    end

  end

  describe "#authored questions" do 
    let(:test_question) {class_double("Question").as_stubbed_const}
  
    it "returns an array of Question objects" do 
      expect(user.authored_questions).to be_a(Array)
      expect(user.authored_questions).to all(be_an(Question))
    end

    it "calls Question::find_by_author_id" do 
     expect(test_question).to receive(:find_by_author_id).with(user.id)
     user.authored_questions
    end
  end

    describe "#liked_questions" do 
      let(:test_like) {class_double("QuestionLike").as_stubbed_const}

      it "returns an array of Question objects" do 
        expect(user.liked_questions).to be_a(Array)
        expect(user.liked_questions).to all(be_an(Question))
      end

      it "calls Question_like::liked_questions_for_user_id" do 
        expect(test_like).to receive(:liked_questions_for_user_id).with(user.id)
        user.liked_questions
      end
    end

    describe "#average_karma" do 
      let(:user_1) {User.find_by_name('Bob', 'Hoskins')}
      let(:user_2) {User.find_by_name('Jim', 'Jimson')}

      
      it "returns the average of likes on users authered questions" do 
        expect(user_1.average_karma).to eql(2.0)
      end

      it 'only hits the database once' do 
        user_test = described_class.find_by_id(2)
        data = QuestionsDatabase.instance
        expect(data).to receive(:execute).exactly(1).times.and_call_original
        user_test.average_karma
      end 
    end

end