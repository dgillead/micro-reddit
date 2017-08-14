require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  render_views

  let(:user) { User.create!(username: 'Hello', join_date:"#{Date.today}", email: 'me@me.com', password: '123456') }
  let(:post_one) { Post.create!(user_id: user.id, title: 'Post title', content: 'Post content') }

  let(:comment_params) { { content: 'Comment content' } }

  describe 'GET #new' do
    it 'assigns a new comment to @comment' do
      sign_in(user)

      get :new, params: { post_id: post_one.id }

      expect(assigns(:comment)).to be_a_new(Comment)
    end

    it 'renders a form for the user to create a new comment' do
      sign_in(user)

      get :new, params: { post_id: post_one.id }

      expect(response.body).to include('New Comment')
    end
  end

  describe 'POST #create' do
    it 'creates a new comment and saves it to database' do
      sign_in(user)

      expect{ post :create, params: { post_id: post_one.to_param, comment: comment_params } }.to change{ post_one.comments.count }.by(1)
    end
  end
end
