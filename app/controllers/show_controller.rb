class ShowController < UIViewController
  BASE_URL = "http://bbs.rong360.com/forum.php?forumlist=1"

  def loadView
    self.view = UIWebView.alloc.init
  end

  def viewWillAppear(animated)
    navigationController.setNavigationBarHidden(false, animated:true)
  end

  def viewDidLoad
    super

    navigationItem.title = "Rong360"
    request = NSURLRequest.requestWithURL(NSURL.URLWithString(BASE_URL))
    view.loadRequest(request)
  end

end
