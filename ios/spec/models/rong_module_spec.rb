describe RongModule do
  extend WebStub::SpecHelpers
  before do
    disable_network_access!
    @result = nil
  end

  after do
    enable_network_access!
    reset_stubs
  end

  it "should fetch rong module list" do
    stub_request(:get, "http://bbs.rong360.com/api/mobile/index.php?module=forumindex&version=1&mobile=no").
      to_return(json: { "Variables" => { "forumlist" => [ { "fid" => 1, "name" => "交流" }] }})

    RongModule.list do |result|
      @result = result
      resume
    end

    wait_max 1.0 do
      @result.size.should == 1
      @result.last.is_a?(RongModule).should == true
    end
  end

end
