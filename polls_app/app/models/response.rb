# == Schema Information
#
# Table name: responses
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer          not null
#  answer_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Response < ApplicationRecord
    validates :user_id, :answer_id, presence: true
    # validate :not_duplicate_response
    validate :not_author_response

    belongs_to :user,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User
        
    belongs_to :answer,
        primary_key: :id,
        foreign_key: :answer_id,
        class_name: :AnswerChoice

    has_one :question,
        through: :answer,
        source: :question

    has_one :poll,
        through: :question,
        source: :poll

    has_one :author,
        through: :poll,
        source: :author

    def sibling_responses
        self.question.responses.where.not(id: self.id)
    end

    def respondent_already_answered?
        self.sibling_responses.exists?(user_id: self.user_id)
    end

    private
    def not_duplicate_response
        if respondent_already_answered?
            errors[:answer_id] << 'user cant answer the same question twice'
        end
    end

    def not_author_response
        if self.user.id == self.author.id
            errors[:user_id] << 'author cannot answer her own question'
        end
    end

end
