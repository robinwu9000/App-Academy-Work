class Course < ActiveRecord::Base
  has_many(
    :enrollments,
    class_name: "Enrollment",
    foreign_key: :course_id,
    primary_key: :id
  )

  has_many :enrolled_students, through: :enrollments, source: :user


  belongs_to :prerequisite, foreign_key: :prereq_id, primary_key: :id, class_name: "Course"
  belongs_to :instructor, foreign_key: :instructor_id, primary_key: :id, class_name: "User"
end
