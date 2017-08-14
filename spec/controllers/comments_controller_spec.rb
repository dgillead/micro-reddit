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

  describe 'GET #show' do
    it 'displays the newly created comment' do
      sign_in(user)
      comment = post_one.comments.create!(content: 'comment content')

      get :show, params: { post_id: post_one.id, id: comment.id }

      expect(response.body).to include('comment content')
      expect(response.body).to include('Post title')
    end
  end

  describe 'GET #edit' do
    it 'displays a form for the user to edit the comment' do
      sign_in(user)
      comment = post_one.comments.create!(content: 'comment content')

      get :edit, params: { post_id: post_one.id, id: comment.id }

      expect(response.body).to include('Edit Comment')
      expect(response.body).to include('comment content')
    end
  end

  describe 'PUT #update' do
    it 'updates the comment with the new text' do
      sign_in(user)
      comment = post_one.comments.create!(content: 'comment content')
      update_content = { content: 'new comment content' }

      put :update, params: { post_id: post_one.id, id: comment.id, comment: update_content }
      comment.reload

      expect(comment.content).to eq('new comment content')
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the selected comment' do
      sign_in(user)
      comment = post_one.comments.create!(content: 'comment content')

      expect{ delete :destroy, params: { post_id: post_one.id, id: comment.id } }.to change{ post_one.comments.count }.by(-1)
    end
  end
end
