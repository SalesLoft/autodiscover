module Autodiscover
  class PoxResponse

    attr_reader :response

    def initialize(response)
      raise ArgumentError, "Response must be an XML string" if(response.nil? || response.empty?)
      @response = Nori.new(parser: :nokogiri).parse(response)["Autodiscover"]["Response"]
    end

    def exchange_version
      server_version = exch_proto["ServerVersion"]
      return "Exchange2016" if server_version.nil?
      ServerVersionParser.new(server_version).exchange_version
    end

    def ews_url
      expr_proto["EwsUrl"]
    end

    def exch_proto
      @exch_proto ||= protocols.find { |p| p["Type"] == "EXCH" } || {}
    end

    def expr_proto
      @expr_proto ||= protocols.find { |p| p["Type"] == "EXPR" } || {}
    end

    def web_proto
      @web_proto ||= protocols.find { |p| p["Type"] == "WEB" } || {}
    end

    private

    def protocols
      response["Account"]["Protocol"] || []
    end

  end
end
