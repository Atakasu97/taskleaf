class Task < ApplicationRecord
  validates :name, presence: true
  validates :name, length: {maximum: 30}  
  validate :validate_name_not_includinf_comma

  # ransackの検索条件を絞る
  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  # CSVデータ出力機能
  def self.csv_attributes
   ["name", "description", "created_at", "updated_at"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
     csv << csv_attributes
     all.each do |task|
       csv << csv_attributes.map{|attr| task.send(attr) }
     end
    end
  end

  # CSVデータ入力機能
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      task = new
      task.attributes = row.to_hash.slice(*csv_attributes)
      task.save!
    end
  end

  belongs_to :user
  has_one_attached :image

  scope :recent, -> {order(created_at: :desc)}

  private

  def validate_name_not_includinf_comma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end
end
