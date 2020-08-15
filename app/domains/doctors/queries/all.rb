module Doctors
  module Queries
    class All
      def self.run(params = {})
        doctors = User.where(is_doctor: true).includes(doctor_information: [:doctor_speciality])

        if doctors.present?
          return :found, doctors
        else
          return :not_found, nil
        end
      end
    end
  end
end
