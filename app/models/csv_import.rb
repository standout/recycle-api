require 'csv'

class CSVImport
  def initialize(file)
    @file = file
  end

  def import(source)
    case source
    when :fti then FTI.new(@file).import
    end
  end

  class FTI
    def initialize(file)
      @csv = CSV.parse(File.read(file), {
        headers:    true,
        converters: :numeric
      })
    end

    def import
      @csv.each { |row| create_from(row) }
    end

    private

    def kind(name)
      name.include?('ÅVC') ? :recycle_central : :recycle_station
    end

    def checked?(value)
      value == 'x'
    end

    def create_from(row)
      attributes = {}
      attributes[:name]      = row['Åvs']
      attributes[:city]      = row['Ort']
      attributes[:kind]      = kind(row['Åvs'])
      attributes[:latitude]  = row['Latitud decimal']
      attributes[:longitude] = row['Longitud decimal']
      attributes[:materials] = []
      attributes[:materials] << 'glass'     if checked?(row['Glas'])
      attributes[:materials] << 'cardboard' if checked?(row['Kartong'])
      attributes[:materials] << 'metal'     if checked?(row['Metall'])
      attributes[:materials] << 'plastic'   if checked?(row['Blandplast'])
      attributes[:materials] << 'magazines' if checked?(row['Tidningar'])

      RecycleLocation.create! attributes
    end
  end
end
