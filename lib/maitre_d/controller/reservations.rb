Application.class_eval do
  
  # /reservations/create

  # post: { seconds: 3600, environment: 'beta', user: 'winton' }
  # return:
  #   { status: 'reserved', expires: 'TIME', user: 'tung' }

  post '/reservations/create' do
    reservation = Reservation.find(params)

    create = 
      params[:force] ||
      !reservation.exists? ||
      reservation.user == params[:user]

    reservation = Reservation.new(params).create if create
    reservation.to_response
  end

  # /reservations/show

  # post: { environment: 'beta' }
  # return:
  #   { status: 'available' }
  #   { status: 'reserved', expires: 'TIME', user: 'tung' }

  get '/reservations/show' do
    Reservation.find(params).to_response
  end

  # /reservations/destroy

  # get: { environment: 'beta' }
  # return:
  #   { status: 'reserved', expires: 'TIME', user: 'tung' }

  get '/reservations/destroy' do
    reservation = Reservation.find(params)
    reservation.destroy
    reservation.to_response
  end
end