class BlogPost < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_rich_text :body
  has_one_attached :audio_file
  has_one_attached :header_image

  acts_as_taggable_on :tags

  validates :body, presence: true
  validates :audio_file, content_type: %w[audio/mpeg]
  validates :header_image, content_type: %w[image/png image/jpeg image/jpg image/gif image/webp],
            dimension: {
              width: { min: 628, max: 628 },
              height: { min: 256, max: 256 },
              message: 'must be 628x256'
            },
            aspect_ratio: :landscape,
            size: { less_than: 50.kilobytes , message: 'must be < 50 kb' }
  validates :title, presence: true

  scope :sorted, -> { order(published_at: :asc) }
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
