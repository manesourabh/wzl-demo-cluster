class LeafFailure < ApplicationRecord
  belongs_to :user
  has_many :leaf_measures
  has_many :applied_measures, through: :leaf_measures, source: :leaf_measure_type
  belongs_to :leaf_failure_type

  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/sqlite3_adapter'

  def self.spc_import(file)
      # CSV.parse(file, col_sep: ';')
      xkm_data = []
      CSV.foreach(file.path, col_sep: ',', headers: true) do |row|
        puts row.to_h
        xkm_data << LeafFailure.new(row.to_h)
      end
      LeafFailure.import xkm_data, recursive: true
  end
end
