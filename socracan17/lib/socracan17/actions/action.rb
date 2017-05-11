module SocraCan17
  class ActionWithValidation
    def execute(params)
      result = validate(params)

      if result.failure?
        raise ArgumentError.new(result.errors(full: true).values.join(', '))
      end

      do_execute(result.to_h)
    end

    protected

    def validate(params)
    end

    def do_execute(params)
    end
  end
end
