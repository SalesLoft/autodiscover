module Autodiscover
  class ServerVersionParser

    VERSIONS = {
      8 => {
        0 => "Exchange2007",
        1 => "Exchange2007_SP1",
        2 => "Exchange2007_SP1",
        3 => "Exchange2007_SP1",
      },
      14 => {
        0 => "Exchange2010",
        1 => "Exchange2010_SP1",
        2 => "Exchange2010_SP2",
        3 => "Exchange2010_SP2",
      },
      15 => {
        0 => "Exchange2013",
        1 => "Exchange2016",
        20 => "Exchange2017"
      }
    }

    def initialize(hexversion)
      if hexversion.nil?
        @version = "00000000000000000000000000000000"
      else
        @version = hexversion.hex.to_s(2).rjust(hexversion.size*4, '0')
      end
    end

    def major
      @version[4..9].to_i(2)
    end

    def minor
      @version[10..15].to_i(2)
    end

    def build
      @version[17..31].to_i(2)
    end

    def exchange_version
      VERSIONS.dig(major, minor) || VERSIONS[15][1]
    end

  end
end
