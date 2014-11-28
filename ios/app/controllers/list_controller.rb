class ListController < UITableViewController
  def initWithModule(current_module)
    @current_module = current_module
    self.initWithNibName(nil, bundle: nil)
    self
  end

  def viewDidLoad
    super
    self.navigationItem.title = @current_module.name

    @posts = []
    Post.list(module_id: @current_module.id) do |posts|
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

    controller = ShowController.alloc.initWithPost(@posts[indexPath.row])
    self.navigationController.pushViewController(controller, animated:true)
  end

end

