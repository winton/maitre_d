Application.class_eval do

  Dir["#{root}/lib/maitre_d/controller/*.rb"].sort.each do |path|
    require path
  end
end