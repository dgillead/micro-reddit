require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  render_views

  let(:user) { User.create!(username: 'Hello', join_date:"#{Date.today}", email: 'me@me.com', password: '123456') }
  let(:post) { Post.create!(user_id: user.id, title: 'Post title', content: 'Post content') }

  describe 'GET #new' do
    it 'assigns a new comment to @comment' do
      sign_in(user)

      get :new

      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end


end
