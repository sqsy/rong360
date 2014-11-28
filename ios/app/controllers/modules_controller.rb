class ModulesController < UITableViewController
  def initWithModules(modules, current)
    @modules = modules
    @current = current
    self.initWithNibName(nil, bundle: nil)
    self
  end

  def viewDidLoad
    super
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "MODULE_CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    cell.textLabel.text = @modules[indexPath.row].name
    cell.textLabel.textColor = UIColor.blackColor
    if @current == @modules[indexPath.row]
      cell.textLabel.textColor = UIColor.blueColor
    end

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @modules.count
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    self.view.deselectRowAtIndexPath(indexPath, animated:false)

    p "#{@modules[indexPath.row].name} selected"
    @current = @modules[indexPath.row]
    self.tableView.reloadData

    # return to list view
    self.navigationController.popViewControllerAnimated(false)
  end


end
