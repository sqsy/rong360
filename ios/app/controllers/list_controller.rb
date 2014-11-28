class ListController < UITableViewController
  def initWithModule(current_module)
    @current_module = current_module
    self.initWithNibName(nil, bundle: nil)
    self
  end

  def viewWillAppear(animated)
    super
    self.tableView.reloadData if self.respond_to?("tableView")
    self
  end

  def viewDidLoad
    super

    @posts = []
    #self.navigationItem.title = "Rong360"
    #path = File.join(File.dirname(__FILE__), "../../resources/arrowright_20x20.png")
    #image = UIImage.imageWithContentsOfFile(path)
    #rightButton = UIBarButtonItem.alloc.initWithImage(image,
                                                      #style: UIBarButtonItemStyleBordered,
                                                      #target: self,
                                                      #action: "pop_module_list")
    #self.navigationItem.rightBarButtonItem = rightButton
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

  def pop_module_list
    p "pop module list"
    RongModule.list do |modules|
      controller = ModulesController.alloc.initWithModules(modules, modules.first)
      self.navigationController.pushViewController(controller, animated: false)
      p modules
    end
  end

end

