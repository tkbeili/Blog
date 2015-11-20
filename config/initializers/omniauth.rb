Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '844311299015070', '600f15fc578c067e116d90e1dc232fe0'
end
