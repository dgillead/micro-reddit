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

      expect{ post :create, params: { title: 'Hello', content: 'this is the content' } }.to change{ Post.count }.by(1)
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
end
