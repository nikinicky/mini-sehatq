module Hospitals
  module Queries
    class All
      def self.run(params = {})
        hospitals = Hospital.all

        if hospitals.present?
          return :found, hospitals
        else
          return :not_found, nil
        end
      end
    end
  end
end
