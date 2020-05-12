class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  # ファイルサイズに対するバリデーションはRailsの既存のオプション (presenceやlengthなど)
  # にはない。手動でpicture_sizeという独自のバリデーションを定義。
  # 独自のバリデーションを定義するために、今まで使っていたvalidatesメソッドではなく、
  # validateメソッドを使用。
  validate  :picture_size


private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

end
