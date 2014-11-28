class ShowController < UITableViewController
  attr_reader :reuseIdentifier
  attr_reader :offscreenCells

  def initWithPost(post)
    @post = post
    self.initWithNibName(nil, bundle: nil)
    self
  end

  def viewDidLoad
    super
    self.navigationItem.title = @post.title
    @reuseIdentifier = "DETAIL_CELL_IDENTIFIER"
    @offscreenCells = {}
    #self.tableView.estimatedRowHeight = 100

    @comments = []
    @post.seek do |comments|
      @comments = comments
      self.tableView.reloadData
    end
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    webView = UIWebView.alloc.initWithFrame(CGRectZero)
    webView.delegate = self
    webView.frame = cell.frame #CGRect.new(cell.frame.origin, [cell.frame.size.width, 300])
    webView.loadHTMLString @comments[indexPath.row].message, baseURL: nil

    cell.contentView.addSubview(webView)
    cell.sizeToFit

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @comments.count
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    100
  end

  def webViewDidFinishLoad(webView)
    webView.sizeToFit
  end
end

