class ReservationsController < ApplicationController

	def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        location = @reservation.location
        reservation_array =  (@reservation.start_date..@reservation.end_date - 1.day).to_a
        AvailableDate.where(location_id: location.id).where(available_date: reservation_array).update_all(reserved: true)
        format.html { redirect_to :back, notice: "Reservation successfully created." }
      else
        format.html {redirect_to :back, alert: "Some of the dates of your reservation are not 
      available.  Please try different dates."}
      end
    end
  end

  private

  def reservation_params
  	params.require(:reservation).permit(:start_date, :end_date, :location_id)
  end
end