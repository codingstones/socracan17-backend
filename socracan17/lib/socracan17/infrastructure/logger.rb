require 'logger'

module SocraCan17
  module Infrastructure
    class Logger
      def initialize(logdev, shift_age = 0, shift_size = 1048576)
        @logger = ::Logger.new(logdev, shift_age, shift_size)
      end

      def level=(severity)
        @logger.level = severity
      end

      def info(progname = nil, &block)
        @logger.info(progname, &block)
      end

      def debug(progname = nil, &block)
        @logger.debug(progname, &block)
      end

      def error(progname = nil, &block)
        @logger.error(progname, &block)
      end
    end
  end
end
