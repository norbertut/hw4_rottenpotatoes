require 'spec_helper'

describe MoviesController do
	describe 'find movies with same director' do
		fixtures :movies
		before :each do
			@fake_results = [movies(:star_wars_movie),movies(:thx1138_movie)]
			@input_movie = movies(:star_wars_movie)
		end

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

	describe 'play with a movie' do
		fixtures :movies
		before :each do
			@input_movie = movies(:star_wars_movie)
		end

		it 'should show a movie' do
			response.should be_successful
			get :show, id: @input_movie
		end

		it 'should destroy a movie' do
			response.should be_successful
			delete :destroy, id: @input_movie
		end

		it 'should edit a movie' do
			response.should be_successful
			get :edit, id: @input_movie
		end

		it 'should update a movie' do
			response.should be_successful
			put :update, id: @input_movie
		end

		it 'should show new view' do
			response.should be_successful
			get :new
		end

		it 'should show all movies' do
			response.should be_successful
			get :index
		end

		it 'should create a movie' do
			response.should be_successful
			post :create
		end

		it 'should show all movies sorted by title' do
			response.should be_successful
			get :index, :sort => 'title'
		end

		it 'should show all movies sorted by release_date' do
			response.should be_successful
			get :index, :sort => 'release_date'
		end

		it 'should show movies filtered by rating' do
			response.should be_successful
			get :index, :ratings => ['G']
		end


	end
end