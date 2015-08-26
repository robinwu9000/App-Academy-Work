# == Schema Information
#
# Table name: nobels
#
#  yr          :integer
#  subject     :string
#  winner      :string

require_relative './sqlzoo.rb'

# BONUS PROBLEM: requires sub-queries or joins. Attempt this after completing
# sections 04 and 07.

def physics_no_chemistry
  # In which years was the Physics prize awarded, but no Chemistry prize?Ω``
  execute(<<-SQL)
    SELECT DISTINCT
      nobels.yr
    FROM (
      SELECT
         yr, subject
      FROM
       nobels
      WHERE
       subject = 'Chemistry') chem_yr
    RIGHT OUTER JOIN
      nobels
    ON
      nobels.yr = chem_yr.yr
    WHERE
      chem_yr.yr is NULL AND nobels.subject = 'Physics'
  SQL
end
