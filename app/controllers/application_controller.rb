class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery
  before_filter :reset_flash
  
  def index
    problems_contests
  end
  
  def submit_solution
    problems_contests
    # Create solution
    problem = Problem.find(params["code"]["problem"])
    contest = Contest.find(params["code"]["contest"])
    solution = Solution.new(:contest => contest, :problem => problem)
    
    # Save file in /data
    solution.store_file(params["code"]["file"])
    
    # Compile file
    p = solution.compile
    unless p.nil?
      flash[:error] = p
      return render "index.html"
    end
    
    # Compile solution
    p "Compiling solution"
    problem.compile_solution

    # Test it
    p "Executing problem & solution"
    veredict = true
    problem.total_inputs.times do |ex|
      str = "ex" + (ex+1).to_s
      problem.execute_against(str)
      solution.execute_against(str)
      p "Veredict against test case ##{ex+1}: "
      res = diff(problem.outputname(str),solution.outputname(str))
      if res
        p "Passed!"
      else
        p "Wrong!"
      end
      veredict = false    if res == false
    end
    # Delete create exe's & outputs
    p "Delete executables & ouptuts"
    problem.del_files
    solution.del_files
    
    # Give veridict
    resp = solution.give_veredict(problem, contest, veredict)
    flash[resp.first] = resp.last

    render "index.html"
  end
  
  
  def problems_contests
    @contests = Contest.all
    @problems = Problem.all
  end
end
