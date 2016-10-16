require 'rails_helper'

RSpec.describe IndexUpdaterJob, type: :job do
  # let(:post) { create(:post) }
  let(:user){create(:user)}
  it 'calls the class method' do
    Post.create(user_id: user.id, body: "testing")
    expect(an_instance_of(Post.__elasticsearch__)).to have_received(:update_document)
  end
end
