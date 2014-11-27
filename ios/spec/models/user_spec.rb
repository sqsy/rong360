describe "User" do
  before do
    @user = User.new id: 1, name: "name", avatar_url: "http://example.com/avatar.png"
  end

  it "should access id" do
    @user.id.should == 1
  end

  it "should access name" do
    @user.name.should == "name"
  end

  it "should access avatar_url" do
    @user.avatar_url.should == "http://example.com/avatar.png"
  end

end
