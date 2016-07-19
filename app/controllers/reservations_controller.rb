class ReservationsController < ApplicationController

	def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to :back, notice: "Reservation successfully created." }
      else
        redirect_to :back, alert: "Reservation was not created.  Please try again."
      end
    end
  end

  private

  def reservation_params
  	params.require(:reservation).permit(:start_date, :end_date, :location_id)
  end
end