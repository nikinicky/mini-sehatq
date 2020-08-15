require 'factory_bot_rails'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

def build_attributes(*args)
  FactoryBot.build(*args).attributes.delete_if do |k, _v|
    %w(id created_at updated_at).member?(k)
  end
end
