class Problem < ActiveRecord::Base
  include ApplicationHelper
  
  belongs_to :contest
  FILECPP = "solution.cpp"
  FILEEXE = "solution"

  def compile_solution
    command = "g++ -lm #{directory("linux")}/#{FILECPP} -o #{directory("linux")}/#{FILEEXE}"
    execute_command(command)
  end

  def directory(os)
    if (os == "windows")
      slash = "\\"
    else
      slash = "/"
    end
    contest = Contest.find(self.contest_id).name
    "data#{slash}#{contest}#{slash}#{self.name}"
  end

  def execute_against(exer)
    executable  = directory("windows") + "\\" + FILEEXE + ".exe"
    exercise    = directory("windows") + "\\" + exer + ".txt"
    output      = outputname(exer)
    command = "( #{executable}  <  #{exercise} ) >  #{output}"
    execute_command(command)
  end

  def outputname(exercise)
    directory("windows") + "\\" + FILEEXE + exercise + ".txt"
  end

  def del_files
    command = "rm " + directory("linux") + "/" + FILEEXE + ".exe" + " " + directory("linux") + "/" + FILEEXE + "*.txt"
    execute_command(command)
  end
end
