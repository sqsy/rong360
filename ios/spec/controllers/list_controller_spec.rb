describe "List Controller" do
  before do
    @controller = UIApplication.sharedApplication.delegate.instance_variable_get("@controller")
  end

  it "should set @posts" do
    @posts = @controller.instance_variable_get("@posts")
    @posts.size.should >= 1
    @posts[0].is_a?(Post).should == true
  end

end
