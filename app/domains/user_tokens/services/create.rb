module UserTokens
  module Services
    class Create
      def self.run(user)
        token = UserToken.new(
          token: SecureRandom.hex(24),
          user: user,
          expires_in: token_will_expires_in
        )

        if token.save
          return :created, token
        else
          return :failed, token
        end
      end

      private

      def self.token_will_expires_in
        (Time.now + 1.month).to_i
      end
    end
  end
end
