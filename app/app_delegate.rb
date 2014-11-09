class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @controller = ListController.alloc.initWithNibName(nil, bundle: nil)
    @navigation_controller = UINavigationController.alloc.initWithRootViewController(@controller)

    @window.rootViewController = @navigation_controller
    @window.makeKeyAndVisible

    true
  end
end
