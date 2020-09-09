require 'rails_helper'


RSpec.describe Contestant, type: :model do
  before :each do
    @challenge_1 = Challenge.create!(theme: "Recycled Material", project_budget: 1000)
    @project_1 = @challenge_1.projects.create!(name: "News Chic", material: "Newspaper")
    @project_2 = @challenge_1.projects.create!(name: "Cardboard Boxes", material: "Cardboard Boxes")
    @contestant_1 = Contestant.create!(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @contestant_1.projects << [@project_1, @project_2]
  end

  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_presence_of :hometown}
    it {should validate_presence_of :years_of_experience}
  end

  describe "relationships" do
    it {should have_many :contestant_projects}
    it {should have_many(:projects).through(:contestant_projects)}
  end

  describe "instance methods" do 
    it "can see list of projects for a contestant" do
     expect(@contestant_1.all_projects).to eq([@project_1.name, @project_2.name])
    end
  end
end
