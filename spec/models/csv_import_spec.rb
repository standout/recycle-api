require 'rails_helper'

describe CSVImport, type: :model do
  describe 'Importing from FTI AB' do
    it 'imports CSV rows successfully' do
      csv_import = CSVImport.new(fixture_file_path('csv/import/fti.csv'))

      expect { csv_import.import(:fti) }
        .to change { RecycleLocation.count }.by 1
    end
  end
end
