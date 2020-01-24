Sequel.migration do
  change do
    create_table(:items) do
      primary_key :id, unique: true
      String :name, null: false
    end
  end
end