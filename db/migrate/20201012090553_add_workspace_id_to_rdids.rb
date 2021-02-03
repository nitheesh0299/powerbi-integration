class AddWorkspaceIdToRdids < ActiveRecord::Migration[6.0]
  def change
    add_column :rdids, :workspaceId, :string
  end
end
