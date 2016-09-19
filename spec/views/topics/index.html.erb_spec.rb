require 'rails_helper'

RSpec.describe "topics/index", type: :view do
  before(:each) do
    assign(:topics, [
      Topic.create!(
        :tag => "Tag"
      ),
      Topic.create!(
        :tag => "Tag"
      )
    ])
  end

  it "renders a list of topics" do
    render
    assert_select "tr>td", :text => "Tag".to_s, :count => 2
  end
end
