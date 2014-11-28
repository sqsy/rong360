describe "Post" do
  extend WebStub::SpecHelpers

  before do
    disable_network_access!
    @object = nil
    @result = nil
    @post = Post.new id: 1, title: "title", content: "content", post_at: Time.now
  end

  after do
    enable_network_access!
    reset_stubs
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

  it "should fetch forumlist" do
    stub_request(:get, "http://bbs.rong360.com/api/mobile/index.php?module=forumdisplay&version=1&fid=50&page=1&tpp=20&submodule=checkpost&orderby=lastpost&mobile=no").
      to_return(json: { "Variables" => { "forum_threadlist" => [{ "tid" => 1, "subject" => "hello", "authorid" => 100, "post_at" => "1321223311" }]}})

    Post.list do |posts|
      @result = posts
      resume
    end

    wait_max 1.0 do
      @result.size.should == 1
    end
  end

  it "sample request" do
    stub_request(:get, "http://baidu.com/").to_return(json: { "hello" => 1 })

    AFMotion::JSON.get("http://baidu.com/") do |result|
      @result = result
      @object = result.object
      resume
    end

    wait_max 1.0 do
      @object["hello"].should == 1
    end
  end

  it "should seek comments" do
    stub_request(:get, "http://bbs.rong360.com/api/mobile/index.php?module=viewthread&version=1&tid=#{@post.id}&page=1&ppp=16&submodule=checkpost&mobile=no").
      to_return(json: { "Variables" => { "postlist" => [ { "pid" => 1, "message" => "交流", "pid" => 100, "authorid" => 110, "dbdateline" => "123212345" }] }})

    @post.seek do |comments|
      @result = comments
      resume
    end

    wait_max 1.0 do
      @result.size.should == 1
      @result.last.is_a?(Comment).should == true
    end
  end

end
