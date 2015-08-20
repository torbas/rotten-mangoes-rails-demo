class Movie < ActiveRecord::Base

  has_many :reviews

  mount_uploader :poster, PosterUploader

  validates :title, presence: true

  validates :director, presence: true

  validates :runtime_in_minutes, numericality: { only_integer: true }

  validates :description, presence: true

  #validates :poster_image_url, presence: true

  validates :release_date, presence: true

  validate :release_date_is_in_the_future

  scope :with_title_or_director, ->(query_title) { where('lower(title) like ? or lower(director) like ?' , "%#{query_title.downcase}%", "%#{query_title.downcase}%") }
  scope :short_running_time, -> { where('runtime_in_minutes < 90') }
  scope :medium_running_time, -> { where('runtime_in_minutes >= 90 AND runtime_in_minutes <= 120') }
  scope :long_running_time, -> { where('runtime_in_minutes > 120') }

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size if reviews.size > 0
  end

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end
end
