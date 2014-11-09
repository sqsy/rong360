class ListController < UIViewController

  def viewDidLoad
    super

    self.title = "Rong360"
    self.view.backgroundColor = UIColor.whiteColor

    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    self.view.addSubview @table

    @table.dataSource = self

    @data = [
      "很长的一段话， 真的很长，要占满两行，起码。",
      "很长的一段话， 真的很长，要占满两行，起码。1",
      "很长的一段话， 真的很长，要占满两行，起码。2",
      "很长的一段话， 真的很长，要占满两行，起码。3",
      "很长的一段话， 真的很长，要占满两行，起码。4",
      "很长的一段话， 真的很长，要占满两行，起码。5",
      "很长的一段话， 真的很长，要占满两行，起码。6",
      "很长的一段话， 真的很长，要占满两行，起码。7"
    ]
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    cell.textLabel.text = @data[indexPath.row]

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end

end

