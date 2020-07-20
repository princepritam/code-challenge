class AddCityAndStateToCompany < ActiveRecord::Migration[6.0]
  def up
    unless column_exists?(:companies, :city, :string)
      add_column :companies, :city, :string
    end

    unless column_exists?(:companies, :state, :string)
      add_column :companies, :state, :string
    end
  end

  def down
    if column_exists?(:companies, :city)
      remove_column :companies, :city
    end

    if column_exists?(:companies, :state)
      remove_column :companies, :state
    end
  end
end
