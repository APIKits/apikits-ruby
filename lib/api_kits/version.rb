module ApiKits
  module Version
    Major = 1
    Minor = 0
    Tiny  = 0
    Pre   = nil

    Compact = [Major, Minor, Tiny, Pre].compact.join('.')
    Summary = "ApikitsClient v#{Compact}"
    Description = ""
  end
end
