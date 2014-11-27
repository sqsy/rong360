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
    webView.frame = CGRect.new(cell.frame.origin, [cell.frame.size.width, 300])
    webView.loadHTMLString @comments[indexPath.row].message, baseURL: nil
    cell.sizeToFit

    cell.addSubview(webView)

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @comments.count
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    300
    #unless cell = @offscreenCells[@reuseIdentifier]
      #cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
      #@offscreenCells[@reuseIdentifier] = cell
    #end

    #webView = UIWebView.alloc.initWithFrame(CGRectZero)
    #webView.loadHTMLString @comments[indexPath.row].message, baseURL: nil

    #cell.addSubview(webView)
    #cell.bounds = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds))
    #cell.setNeedsLayout
    #cell.layoutIfNeeded

    #height = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height

    #return height + 1
  end
end

