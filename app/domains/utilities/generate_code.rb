module Utilities
  class GenerateCode
    def self.for_order(length: 6, prefix: '', source: [*('A'..'Z'), *('0'..'9')])
      begin
        code = run(length, prefix, source)
      end while Order.where(code: code).any?

      return code
    end

    private

    def self.run(length, prefix, source)
      code = source.sample(length).join
      code = prefix + code if prefix.present?

      return code
    end
  end
end
