class Company < ApplicationRecord
  EMAIL_REGEX = /\w+@getmainstreet.com/.freeze
  has_rich_text :description
  before_save :update_city_and_state, if: :zip_code_changed?
  validate :validate_zip_code
  validate :validate_email, if: -> {email.present?}

  private

    def update_city_and_state
      self.city = @zip_code_details[:city]
      self.state = @zip_code_details[:state_code]
    end

    def validate_zip_code
      @zip_code_details = ZipCodes.identify(zip_code.to_s)
      errors.add("zip_code", "is invalid") unless @zip_code_details
    end

    def validate_email
      errors.add("Email", "should only be a @getmainstreet.com domain") unless email.match(EMAIL_REGEX)
    end

end
