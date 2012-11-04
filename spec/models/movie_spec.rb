require 'spec_helper'

describe Movie do
	describe 'find movies with same director' do
		fixtures :movies
		before :each do
			@fake_results = [movies(:star_wars_movie),movies(:thx1138_movie)]
		end

		it 'should return movies with same director' do
			Movie.find_same_director("1").should == @fake_results
		end

		it 'should receive an id param' do   #how to improve this test?
			Movie.should_receive(:find_same_director).with("1")
			Movie.find_same_director("1")
		end
	end
end