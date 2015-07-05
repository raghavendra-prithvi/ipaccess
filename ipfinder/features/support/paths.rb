module NavigationHelpers
  def path_to(page_name)
    "/devices/#{page_name}"
  end
end

World(NavigationHelpers)