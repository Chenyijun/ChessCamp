class Instructor < ActiveRecord::Migration
   def up
    instr = User.new
    instr.username = "Instr"
    instr.password = "secret"
    instr.password_confirmation = "secret"
    instr.role = "instructor"
    instr.save!
  end

  def down
    instr = User.find_by_username "Instr"
    User.delete instr
  end
end
