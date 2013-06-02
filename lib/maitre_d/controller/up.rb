Application.class_eval do
  
  get '/up' do
    "#{self.class.environment} OK"
  end

  get '/up/elb' do
    "#{self.class.environment} OK"
  end

  get '/up/sms' do
    "#{self.class.environment} OK"
  end
end