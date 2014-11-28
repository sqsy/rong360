class ShowController < UIViewController
  BASE_URL = "http://bbs.rong360.com/forum.php"

  def loadView
   self.view = UIWebView.alloc.init
   self.view.delegate = self
  end

  def initWithPost(post)
    @post = post
    self.initWithNibName(nil, bundle: nil)
    self
  end

  def viewDidLoad
    super

    url = "#{BASE_URL}?mod=viewthread&tid=#{@post.id}&extra=page%3D1&mobile=2"
    request = NSURLRequest.requestWithURL(NSURL.URLWithString(url))
    view.loadRequest(request)
  end

  def webViewDidFinishLoad(webView)
    p webView.stringByEvaluatingJavaScriptFromString("window.location.href")
  end

end

