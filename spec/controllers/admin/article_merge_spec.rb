require 'spec_helper'
describe Admin::ContentController do
  describe 'with admin connection' do
    before :each do
      Factory(:blog)
      #TODO delete this after remove fixture
      Profile.delete_all
      @user = Factory(:user, :text_filter => Factory(:markdown), :profile => Factory(:profile_admin, :label => Profile::ADMIN))
      @user.editor = 'simple'
      @user.save
      @article = Factory(:article)
      request.session = { :user => @user.id }
    end
    describe 'Article merges' do
      before :each do
        @article2 = Factory(:second_article)
      end
      it 'should only merge valid articles' do
        Article.should_receive(:find_by_id).with(@article.id).and_return(@article)
        Article.should_receive(:find_by_id).with(999).and_return(nil)
        get :merge, :merge_with => 999, :id => @article.id
      end

      it 'should not merge an article with itself!' do
        get :merge, :merge_with => @article.id, :id => @article.id
        request.flash[:error].should_not be_empty
      end

      it 'should call merge on the base article passing the other' do
        @new_article = Factory(:article)
        Article.should_receive(:find_by_id).with(@article.id).and_return(@article)
        Article.should_receive(:find_by_id).with(@article2.id).and_return(@article2)
        @article.should_receive(:merge).with(@article2).and_return(@new_article)
        get :merge, :merge_with => @article2.id, :id => @article.id
      end
    end
  end
end
