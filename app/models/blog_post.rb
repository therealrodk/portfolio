class BlogPost < ApplicationRecord
  has_rich_text :body
  has_one_attached :header_image

  validates :body, presence: true
  validates :header_image, content_type: %w[image/png image/jpeg image/jpg image/gif image/webp],
            dimension: {
              width: { min: 1024, max: 1024 },
              height: { min: 256, max: 256 },
              message: 'must be 1024x256'
            },
            aspect_ratio: :landscape,
            size: { less_than: 100.megabytes , message: 'must be < 50 kb' }
  validates :title, presence: true

  scope :sorted, -> { order(published_at: :desc, title: :asc) }
  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :scheduled, -> { where("published_at > ?", Time.current) }

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end
end
