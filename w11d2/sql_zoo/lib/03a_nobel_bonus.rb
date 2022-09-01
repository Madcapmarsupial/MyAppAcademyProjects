# == Schema Information
#
# Table name: nobels
#
#  yr          :integer
#  subject     :string
#  winner      :string

require_relative './sqlzoo.rb'

def physics_no_chemistry
  # In which years was the Physics prize awarded, but no Chemistry prize?
  execute(<<-SQL)
    SELECT
      DISTINCT a.yr
    FROM
      nobels AS a
        WHERE
          subject = 'Physics'
        AND 
          'Chemistry' NOT IN (
          SELECT
            subject 
          FROM
            nobels
          WHERE 
            a.yr = yr
        )
  SQL
end
