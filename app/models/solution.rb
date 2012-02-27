class Solution < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :contest
  belongs_to :problem
  attr_accessor :file
  FILECPP = "test.cpp"
  FILEEXE = "test"

  
  def store_file(file)
    # create the file path
    path = File.join(directory("linux"), FILECPP)
    # write the file
    File.open(path, "wb") { |f| f.write(file.read) }
  end

  def directory(os)
    if (os == "windows")
      slash = "\\"
    else
      slash = "/"
    end
    contest = Contest.find(self.contest_id).name
    problem = Problem.find(self.problem_id).name
    "data#{slash}#{contest}#{slash}#{problem}"
  end

  def outputname(exercise)
    directory("windows") + "\\" + FILEEXE + exercise + ".txt"
  end

  def compile
    command = "g++ -lm #{directory("linux")}/#{FILECPP} -o #{directory("linux")}/#{FILEEXE}"
    res = execute_command(command)
    if res == false
      "Problem " + Problem.find(self.problem_id).name +  " (" + Contest.find(self.contest_id).fullname + ") ==> Compile Error!"
    else
      nil
    end
  end

  def execute_against(exer)
    executable  = directory("windows") + "\\" + FILEEXE + ".exe"
    exercise    = directory("windows") + "\\" + exer + ".txt"
    output      = outputname(exer)
    command = "( #{executable}  <  #{exercise} ) >  #{output}"
    execute_command(command)
  end

  def del_files
    command = "rm " + directory("linux") + "/" + FILEEXE + ".exe"     # .exe
    command = command + " " + directory("linux") + "/" + FILECPP      # .cpp
    command = command + " " + directory("linux") + "/" + FILEEXE + "*.txt"
    execute_command(command)
  end

  def give_veredict(problem, contest, result)
    if result
      str = "Accepted"
      [:notice, "Problem " + problem.name +  " (" + contest.fullname + ") ==> #{str}!"]
    else
      str = "Wrong answer"
      [:error, "Problem " + problem.name +  " (" + contest.fullname + ") ==> #{str}!"]
    end
  end
end