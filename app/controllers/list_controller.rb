class ListController < UITableViewController
  def viewDidLoad
    super

    self.navigationItem.title = "Rong360"

    @data = [
      "很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。",
      "很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。1",
      "很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。2",
      "很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。3",
      "很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。4",
      "很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。很长的一段话， 真的很长，要占满两行，起码。5",
    ]
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
      cell
    end

    cell.textLabel.text = @data[indexPath.row]
    cell.textLabel.numberOfLines = 3

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    self.view.deselectRowAtIndexPath(indexPath, animated:false)
    @controller = ShowController.alloc.init
    self.navigationController.pushViewController(@controller, animated:true)

    detail = @data[indexPath.row]
    @controller.binding_with_data(detail)
  end

end

