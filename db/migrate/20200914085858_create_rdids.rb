class CreateRdids < ActiveRecord::Migration[6.0]
  def change
    create_table :rdids do |t|
      t.string :reportId
      t.string :datasetId

      t.timestamps
    end
  end
end
