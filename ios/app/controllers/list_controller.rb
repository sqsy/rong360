class ListController < UITableViewController
  def viewWillAppear(animated)
    super
    p "viewWillAppear"
    self.tableView.reloadData if self.respond_to?("tableView")
    self
  end

  def viewDidLoad
    super
    p "viewDidLoad"

    @posts = []
    self.navigationItem.title = "Rong360"
    Post.list do |posts|
      @posts = posts
      self.tableView.reloadData
    end
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
      cell
    end

    cell.textLabel.text = @posts[indexPath.row].title

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @posts.count
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    self.view.deselectRowAtIndexPath(indexPath, animated:false)

    @controller = ShowController.alloc.initWithPost(@posts[indexPath.row])
    self.navigationController.pushViewController(@controller, animated:true)
  end

end

