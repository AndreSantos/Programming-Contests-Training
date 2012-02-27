Contest.delete_all
cpas07 = Contest.new(:name => "cpas2007", :fullname => "CPAS 2007")
#cpas08 = Contest.new(:name => "cpas2008", :fullname => "CPAS 2008")
#cpas09 = Contest.new(:name => "cpas2009", :fullname => "CPAS 2009")

Problem.delete_all
["A", "B"].each do |n|
  p = Problem.new(:name => n, :total_inputs => 5)
  p.contest = cpas07
  p.save
end
#["A", "B"].each do |n|
#  p = Problem.new(:name => n)
#  p.contest = cpas08
#  p.save
#end