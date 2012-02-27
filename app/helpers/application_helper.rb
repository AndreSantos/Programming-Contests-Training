module ApplicationHelper
  def execute_command(command)
    case ENV['RAILS_ENV']
      when /development|test/
        system command
      when /production/
        exec command
    end
  end

  def diff(file1,file2)
    command = "diff -r #{file1} #{file2}"
    execute_command(command)
  end

  def reset_flash
    flash.clear
  end
end
