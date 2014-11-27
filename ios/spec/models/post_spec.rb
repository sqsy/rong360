describe "Post" do
  before do
    @post = Post.new id: 1, title: "title", content: "content", post_at: Time.now
  end

  it "should access id" do
    @post.id.should == 1
  end

  it "should access title" do
    @post.title.should == "title"
  end

  it "should access content" do
    @post.content.should == "content"
  end

  it "should access post_at" do
    @post.post_at.is_a?(Time).should == true
  end

end
