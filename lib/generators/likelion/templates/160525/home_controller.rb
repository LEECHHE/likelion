class HomeController < ApplicationController
  def index
  	highschool = Student.multi 3, 4
	  one_student = Student.where(:name => "이두희").take

	  highschool = one_student.get_enter_year
  end

  def create_student
  	highschool = Student.multi 5, 8
  end

  def delete_student
  	highschool = Student.multi 2, 5
  end
end