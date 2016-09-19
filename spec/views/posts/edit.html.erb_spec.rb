require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
  before(:each) do
    @post = assign(:post, Post.create!(
      :body => "MyText",
      :created_by => 1
    ))
  end

  it "renders the edit post form" do
    render

    assert_select "form[action=?][method=?]", post_path(@post), "post" do

      assert_select "textarea#post_body[name=?]", "post[body]"

      assert_select "input#post_created_by[name=?]", "post[created_by]"
    end
  end
end
