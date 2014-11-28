class ModulesController < UITableViewController
  def initWithModules(modules, current)
    @modules = modules
    self.initWithNibName(nil, bundle: nil)
    self
  end

  def viewDidLoad
    super
    self.navigationItem.title = "Rong360"
    @modules = []

    RongModule.list do |modules|
      @modules = modules
      self.tableView.reloadData
    end
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "MODULE_CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
      cell
    end

    cell.textLabel.text = @modules[indexPath.row].name

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @modules.count
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    self.view.deselectRowAtIndexPath(indexPath, animated:false)

    p "#{@modules[indexPath.row].name} selected"

    controller = ListController.alloc.initWithModule(@modules[indexPath.row])
    self.navigationController.pushViewController(controller, animated: true)
  end


end
