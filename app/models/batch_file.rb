class BatchFile < ApplicationRecord
  STATUSES = %w[duplicate error pending success].freeze

  has_many :invoices, dependent: :destroy
  has_one_attached :file

  scope :ordered, -> { order(created_at: :desc) }

  before_validation :set_initial_status, on: :create

  validates :status, inclusion: { in: STATUSES }

  def filepath
    ActiveStorage::Blob.service.path_for(file.key)
  end

  STATUSES.each do |status_name|
    define_method("#{status_name}?") do
      status == status_name
    end
  end

  private

  def set_initial_status
    self.status = :pending if status.blank?
  end
end
