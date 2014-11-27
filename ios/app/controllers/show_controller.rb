class ShowController < UITableViewController

  def initWithPost(post)
    @post = post
    self.initWithNibName(nil, bundle: nil)
    self
  end

  def viewDidLoad
    super
    self.navigationItem.title = @post.title
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "DETAIL_CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    if indexPath.row == 0
      cell.textLabel.text = @post.content
      cell.textLabel.numberOfLines = 0
    else
      cell.textLabel.text = "评论#{indexPath.row + 1}"
    end

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    2
  end

end
