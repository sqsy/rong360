class ShowController < UITableViewController
  BASE_URL = "http://www.1bd1.com/forum.php"

  def initWithPost(post)
    @post = post
    self.initWithNibName(nil, bundle: nil)
    self
  end

  def viewDidLoad
    super

    self.navigationItem.title = @post.title

    #self.tableView.rowHeight = 100
    @comments = []
    @post.seek do |comments|
      @comments = comments
      self.tableView.reloadData
    end
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "DETAIL_CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    p @comments[indexPath.row].message

    attributed_string = @comments[indexPath.row].message.attributed_html
    textView = UITextView.alloc.init
    textView.AttributedText = attributed_string
    rect = attributed_string.boundingRectWithSize(CGSizeMake(cell.frame.size.width, 10000), options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading, context:nil)
    textView.frame = rect
    textView.scrollEnabled = false
    textView.editable = false

    cell.contentView.addSubview(textView)

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @comments.count
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
    attributed_string = @comments[indexPath.row].message.attributed_html
    rect = attributed_string.boundingRectWithSize(CGSizeMake(cell.frame.size.width, 10000), options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading, context:nil)
    return rect.size.height
  end

end

