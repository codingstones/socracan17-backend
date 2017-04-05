module SocraCan17
  class Session
    attr_reader :title, :facilitator, :datetime, :place, :description

    def initialize(args)
      @title = args[:title]
      @facilitator = args[:facilitator]
      @datetime = args[:datetime]
      @place = args[:place]
      @description = args[:description]
    end
  end
end
