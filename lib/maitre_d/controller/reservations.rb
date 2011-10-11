Application.class_eval do

  get '/reservations/create' do
    reservation = Reservation.find(params)

    create = 
      params[:force] ||
      !reservation.exists? ||
      reservation.user == params[:user]

    reservation = Reservation.new(params).create if create
    reservation.to_response
  end

  get '/reservations/show' do
    Reservation.find(params).to_response
  end

  get '/reservations/destroy' do
    reservation = Reservation.find(params)
    reservation.destroy
    reservation.to_response
  end
end