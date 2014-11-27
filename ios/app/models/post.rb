class Post
  extend CommonModel

  attrs_with %w{ id user_id title content post_at }
  attr_reader :comments

  BASE_URL = "http://bbs.rong360.com/"
  LIST_URL = "api/mobile/index.php"
  DETAIL_URL = "api/mobile/index.php?module=viewthread&version=1&tid=5208&page=1&ppp=16&submodule=checkpost&mobile=no"

  def self.list(module_name = "forumdisplay", opts = {}, &block)
    url = "#{LIST_URL}?module=#{module_name}&version=1&fid=50&page=#{opts[:page]||1}&tpp=20&submodule=checkpost&orderby=lastpost&mobile=no"
    client.get(url) do |response|
      if response.success?
        p response.object
        forumlist = response.object["Variables"]["forum_threadlist"]
        @list = forumlist.map do |forum|
          Post.new id: forum["tid"], title: forum["subject"], user_id: forum["authorid"], post_at: forum["dbdateline"]
        end
        block.call(@list)
      elsif response.failure?
        p response.error.localizedDescription
      end
    end
  end

  def seek &block
    return if id.nil?
    url = "#{LIST_URL}?module=viewthread&version=1&tid=#{id}&page=1&ppp=16&submodule=checkpost&mobile=no"
    self.class.client.get(url) do |response|
      if response.success?
        p response.object
        comments = response.object["Variables"]["postlist"]
        @comments = comments.map do |comment|
          Comment.new id: comment["pid"], post_id: comment["tid"], user_id: comment["authorid"], message: comment["message"], comment_at: comment["dbdateline"]
        end
        block.call(@comments)
      end
    end
  end

  def self.client
   @client ||= AFMotion::SessionClient.build(BASE_URL) do
     session_configuration :default
     header "Accept", "application/json"
     response_serializer :json
   end
  end
end
