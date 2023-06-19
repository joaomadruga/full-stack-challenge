class Lend < ApplicationRecord
  belongs_to :book
  validate :return_date_must_be_greater_than_lend_date, :return_date_range_must_be_less_than_six_months
  validate :user_lends_must_be_less_than_two, on: :create

  def return_date_must_be_greater_than_lend_date
    if returned_book_at.present? && borrowed_book_at.present? && returned_book_at < borrowed_book_at
      errors.add(:returned_book_at, " must be greater than lend borrowed book date")
    end
  end

  def return_date_range_must_be_less_than_six_months
    if returned_book_at.present? && borrowed_book_at.present?
      max_borrow_book_date = borrowed_book_at + 6.months
      if returned_book_at >= max_borrow_book_date
        errors.add(:returned_book_at, " date range must be less than six months")
      end
    end
  end

  def user_lends_must_be_less_than_two
    not_returned_lends = Lend.where(user_email: user_email).where(returned_book_at: nil)

    Rails.logger.debug "The value of my_variable is: #{not_returned_lends.length}"
    email_counts = Lend.group(:user_email).count
    if not_returned_lends.length > 2
      errors.add(:user_email, ": there is more than two lends with #{user_email}")
    end
  end
end
