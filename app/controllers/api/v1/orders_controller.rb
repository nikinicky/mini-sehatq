module Api
  module V1
    class OrdersController < Api::V1::BaseController
      before_action :set_order, only: [:checkout]
      skip_before_action :verify_authenticity_token

      def create
        status, @order = Orders::Services::Create.run(order_params)

        if status != :created
          render json: {message: "Something wrong! Can't create order."}, status: :unprocessable_entity
        end
      end

      def checkout
        @order.update(status: Order::PAID)
        @order.reload
      end

      private

      def order_params
        params.permit(:doctor_id, :user_id, :schedule_id, :payment_type, :notes)
      end

      def set_order
        @order = Order.find_by(id: params[:id])
      end
    end
  end
end
