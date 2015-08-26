require_relative 'questions_db'
require_relative 'replies'
require_relative 'questions'
require_relative 'question_joins'
require_relative 'users'

$ned = User.find_by_name("Ned", "Ruggeri")
$steve = User.find_by_name("Steve", "Zelaznik")
$robin = User.find_by_name("Robin", "Wu")
