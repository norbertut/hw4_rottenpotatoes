require 'spec_helper'

describe MoviesController do
	describe 'find movies with same director' do
		fixtures :movies
		before :each do
			@fake_results = [movies(:star_wars_movie),movies(:thx1138_movie)]
			@input_movie = movies(:star_wars_movie)
		end

#modificar, no tiene que llamar al modelo si no al controller, o me equivoco? quizás un método find by director debería existir


		it 'should call the model method that finds movies with same director' do
			Movie.should_receive(:find_same_director).with(@input_movie.id.to_s)
			get :samedirector, id: @input_movie
		end

		it 'should render the template successfully' do
			Movie.stub(:find_same_director).and_return(@fake_results)
			response.should be_successful
			get :samedirector, id: @input_movie
		end

		it 'should make the same director results available to the template' do
			Movie.stub(:find_same_director).with("1").and_return(@fake_results)
			get :samedirector, id: @input_movie
			assigns(:movies).should == @fake_results
		end

	end
end