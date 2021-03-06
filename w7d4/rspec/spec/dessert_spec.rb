require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  subject(:dessert) { Dessert.new("cake", 3, chef) }

  describe "#initialize" do
    it "sets a type" do 
      expect(dessert.type).to eq("cake")
    end

    it "sets a quantity" do 
      expect(dessert.quantity).to eq(3)
    end

    it "starts ingredients as an empty array" do 
      expect(dessert.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do 
      expect{ Dessert.new("cookie", "2", chef) }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do 
      dessert.add_ingredient("fish")
      expect(dessert.ingredients).to eq(["fish"])
    end
  end

  describe "#mix!" do
    before(:each) do
      dessert.add_ingredient("flour")
      dessert.add_ingredient("sugar")
      dessert.add_ingredient("eggs")
      dessert.add_ingredient("eggs")
      dessert.add_ingredient("eggs")
      dessert.add_ingredient("eggs")
    end

    it "shuffles the ingredient array" do
      dessert.mix!
      expect(dessert.ingredients).to_not eq(["flour", "sugar", "eggs", "eggs", "eggs", "eggs"])
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do 
      dessert.eat(1)
      expect(dessert.quantity).to eq(2)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect{dessert.eat(5)}.to raise_error("not enough left!")
    end
  end


  describe "#serve" do
    it "contains the titleized version of the chef's name" do 
      allow(chef).to receive(:titleize).and_return("Chef chef the Great Baker")

      expect(dessert.serve).to include("#{chef.titleize}")
    end

  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do 
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
