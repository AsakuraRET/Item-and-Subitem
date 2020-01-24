Sequel.migration do
  change do
    create_table(:subitems) do
      primary_key :id, unique: true
      String :name, null: false
    end
  end
end
