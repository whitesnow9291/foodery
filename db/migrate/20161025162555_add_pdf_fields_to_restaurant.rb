class AddPdfFieldsToRestaurant < ActiveRecord::Migration
  def change
    add_attachment :restaurants, :pdf_file_1
    add_attachment :restaurants, :pdf_file_2
    add_attachment :restaurants, :pdf_file_3
    add_attachment :restaurants, :pdf_file_4
  end
end
