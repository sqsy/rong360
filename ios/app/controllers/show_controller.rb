class ShowController < UITableViewController

  def initWithPost(post)
    @post = post
    self.initWithNibName(nil, bundle: nil)
    self
  end

  def viewDidLoad
    super
    self.navigationItem.title = @post.title

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

    cell.textLabel.text = @comments[indexPath.row].message
    cell.textLabel.numberOfLines = 0

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @comments.count
  end

end
