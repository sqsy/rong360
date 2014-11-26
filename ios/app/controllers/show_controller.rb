class ShowController < UITableViewController

  def setData(data)
    @data = data
    self.navigationItem.title = @data[0..10]
  end

  def viewDidLoad
    super

  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "DETAIL_CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    if indexPath = 0
      cell.textLabel.text = @data
      cell.textLabel.numberOfLines = 0
    else
      cell.textLabel.text = "评论#{indexPath + 1}"
    end

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    1
  end

end
