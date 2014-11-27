class Post
  extend CommonModel

  attrs_with %w{ id user_id title content post_at }

  BASE_URL = "http://bbs.rong360.com/api/mobile/index.php"

  def self.list(module_name = "forumdisplay", &block)
    BubbleWrap::HTTP.get("#{BASE_URL}?module=#{module_name}&version=1&fid=50&page=1&tpp=20&submodule=checkpost&orderby=lastpost&mobile=no") do |response|
      result = BW::JSON.parse(response.body.to_s)
      formlist = result["Variables"]["forum_threadlist"]
      posts = formlist.map do |form|
        Post.new id: form["tid"], title: form["subject"], user_id: form["authorid"], post_at: form["dbdateline"]
      end
      block.call(posts)
    end
  end
end
