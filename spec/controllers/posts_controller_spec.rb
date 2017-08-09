require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  render_views

  let(:user) { User.create!(username: 'Hello', join_date:"#{Date.today}", email: 'me@me.com', password: '123456') }

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
end
