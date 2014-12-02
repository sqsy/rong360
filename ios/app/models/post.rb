class Post
  extend CommonModel

  attrs_with %w{ id user_id title content post_at }
  attr_reader :comments

  BASE_URL = "http://www.1bd1.com/api/mobile/index.php" #http://bbs.rong360.com/api/mobile/index.php"

  def self.list(opts = {}, &block)
    url = "#{BASE_URL}?module=forumdisplay&version=1&fid=#{opts[:module_id]||50}&page=#{opts[:page]||1}&tpp=20&submodule=checkpost&orderby=lastpost&mobile=no"
    AFMotion::JSON.get(url) do |response|
      if response.success?
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
    url = "#{BASE_URL}?module=viewthread&version=1&tid=#{id}&page=1&ppp=16&submodule=checkpost&mobile=no"
    AFMotion::JSON.get(url) do |response|
      if response.success?
        comments = response.object["Variables"]["postlist"]
        @comments = comments.map do |comment|
          Comment.new id: comment["pid"], post_id: comment["tid"], user_id: comment["authorid"], message: comment["message"], comment_at: comment["dbdateline"]
        end
        block.call(@comments)
      end
    end
  end

end
