# frozen_string_literal: true
<<<<<<< HEAD:db/migrate/20191115143832_add_comments_max_length_to_decidim_organization.decidim.rb

# This migration comes from decidim (originally 20191010140240)
=======
# This migration comes from decidim (originally 20200707132401)
>>>>>>> develop:db/migrate/20210615155720_add_comments_max_length_to_decidim_organization.decidim.rb

class AddCommentsMaxLengthToDecidimOrganization < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_organizations, :comments_max_length, :integer, default: 1000
  end
end
