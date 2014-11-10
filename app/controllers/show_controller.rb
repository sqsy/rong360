class ShowController < UIViewController
  def viewDidLoad
    super

    self.title = "Detail"
    self.view.backgroundColor = UIColor.whiteColor

  end

  def binding_with_data data
    @data = data

    label = UILabel.alloc.initWithFrame(CGRectZero)
    label.text = data
    label.sizeToFit
    label.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)

    self.view.addSubview label
  end

end
