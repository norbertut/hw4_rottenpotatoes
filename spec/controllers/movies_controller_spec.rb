require 'spec_helper'

describe MoviesController do
	describe 'find movies with same director' do
		fixtures :movies
		before :each do
			@fake_results = [movies(:star_wars_movie),movies(:thx1138_movie)]
		end

#modificar, no tiene que llamar al modelo si no al controller, o me equivoco? quizás un método find by director debería existir


		it 'should call the model method that finds movies with same director' do
			MoviesController.should_receive(:samedirector).with("1")
			get :samedirector, {:id => "1"}
		end

		it 'should select the Same Director template for rendering' do
			Movie.stub(:find_same_director).and_return(@fake_results)
			get :samedirector, {:id => "1"}
			response.should redirect_to('same_director')
		end

		it 'should make the same director results available to the template' do
			Movie.stub(:find_same_director).with("1").and_return(@fake_results)
			get :samedirector, {:id => "1"}
			assigns(:movies).should == @fake_results
		end

	end
end