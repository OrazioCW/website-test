require 'utilities'

module PageModels
  class BlinkboxbooksSection < SitePrism::Section
    include RSpec::Matchers
    include WebUtilities
  end
end