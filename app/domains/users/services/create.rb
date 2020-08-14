module Users
  module Services
    class Create
      def self.run(params)
        user = User.new(params)

        if user.save
          return :created, user
        else
          return :failed, user
        end
      end
    end
  end
end
