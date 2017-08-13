require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  render_views

  let(:user) { User.create!(username: 'Hello', join_date:"#{Date.today}", email: 'me@me.com', password: '123456') }

  let(:post_params) { { title: 'hello', content: 'hi' } }

  describe 'GET #new' do
    it 'assigns a new post to @post' do
      sign_in(user)

      get :new

      expect(assigns(:post)).to be_a_new(Post)
    end

    it 'renders a form for the user to create a new post' do
      sign_in(user)

      get :new

      expect(response.body).to include('Create New Post')
      expect(response.body).to include('title')
      expect(response.body).to include('content')
    end
  end

  describe 'POST #create' do
    it 'creates a new post with the entered params' do
      sign_in(user)

      expect{ post :create, params: { user_id: user.to_param, post: post_params } }.to change{ Post.count }.by(1)
    end
  end

  describe 'GET #show' do
    it 'displays the current post' do
      sign_in(user)
      post_params[:user_id] = user.id
      post = Post.create!(post_params)

      get :show, params: { id: post.id }

      expect(response.body).to include('hello')
      expect(response.body).to include('hi')
    end
  end

  describe 'GET #edit' do
    it 'display a form for the user to edit the post' do
      sign_in(user)
      post_params[:user_id] = user.id
      post = Post.create!(post_params)

      get :edit, params: { id: post.id }

      expect(response.body).to include('Edit')
      expect(response.body).to include('hello')
      expect(response.body).to include('hi')
    end
  end

  describe 'PUT #update' do
    it 'updates the current post' do
      sign_in(user)
      post_params[:user_id] = user.id
      post = Post.create!(post_params)
      update_params = { title: 'hello again', content: 'new content'}

      put :update, params: { id: post.id, post: update_params }
      post.reload

      expect(post.title).to eq('hello again')
      expect(post.content).to eq('new content')
    end
  end
end
