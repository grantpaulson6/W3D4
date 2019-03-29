# == Schema Information
#
# Table name: questions
#
#  id         :bigint(8)        not null, primary key
#  text       :text
#  poll_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
    validates :poll_id, presence: true

    belongs_to :poll,
        primary_key: :id,
        foreign_key: :poll_id,
        class_name: :Poll

    has_many :answers,
        primary_key: :id,
        foreign_key: :question_id,
        class_name: :AnswerChoice

    has_many :responses,
        through: :answers,
        source: :responses

    # def results
    #     results = Hash.new(0)
    #     self.responses.each do |response|
    #         results[response.answer.answer] += 1
    #     end
    #     results
    # end

    def results
        data = self.responses.includes(:answer)
        results = Hash.new(0)
        data.each do |response|
            results[response.answer.answer] += 1
        end
        results
    end
end
