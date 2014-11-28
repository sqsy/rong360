class RongModule
  extend CommonModel

  attrs_with %w{ id name }

  def self.list(&block)
    url = "http://bbs.rong360.com/api/mobile/index.php?module=forumindex&version=1&mobile=no"
    AFMotion::JSON.get(url) do |result|
      modulelist = result.object["Variables"]["forumlist"]
      list = modulelist.map do |m|
        RongModule.new id: m["fid"], name: m["name"]
      end
      block.call(list)
    end
  end
end
