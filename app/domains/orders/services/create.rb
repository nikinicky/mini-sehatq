module Orders
  module Services
    class Create
      def self.run(params)
        status, appointment = Appointments::Services::Create.run(params)

        if status != :created
          return status, nil
        end

        order = Order.new(
          code: Utilities::GenerateCode.for_order,
          appointment: appointment,
          payment_type: params[:payment_type],
          notes: params[:notes]
        )

        if order.save
          return :created, order
        else
          return :failed, order
        end
      end
    end
  end
end
