RSpec.configure do |config|
  config.before do
    stock_configuration = Spree::Core::StockConfiguration.new.tap do |stock_config|
      stock_config.estimator_class = 'SolidusEasypost::Estimator'
    end

    if Spree.solidus_gem_version >= Gem::Version.new('2.9.0')
      stub_spree_preferences(stock: stock_configuration)
    else
      # rubocop:disable RSpec/AnyInstance
      allow_any_instance_of(Spree::AppConfiguration).to receive(:stock)
        .and_return(stock_configuration)
      # rubocop:enable RSpec/AnyInstance
    end
  end
end
