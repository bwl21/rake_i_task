
#
# this is an interactive rake task
#
# (c) 2014 Bernhard Weichel
#
# todo: handle task arguments
#

Rake::TaskManager.record_task_metadata = true


require 'readline'

desc "Interactive rake console"
task :i  do |t, args|

  begin
    File.open(".rake_history").readlines.each{|l|
      Readline::HISTORY.push(l.strip)
    }
  rescue
    nil
  end

  tasks = Rake.application.tasks.select{|t|t.is_a? Rake::Task}
  tasks = tasks.select{|t| t.comment }
  tasknames = tasks.map{|t| t.name }

  name_width = tasks.map { |t| t.name_with_args.length }.max || 10
  max_column = Rake.application.terminal_width - 7


  show_tasks = lambda{
    tasks.each do |t|
      printf("%-#{name_width}s  # %s\n",
             "rake #{t.name_with_args}",
             max_column ? Rake.application.truncate(t.comment, max_column) : t.comment)
    end
  }

  show_help = lambda{
    puts %Q{This is interactive Rake

            exit    : end the session
            help    : show help
            }
  }

  comp = proc { |s|
    completions = tasknames.map{|taskname| taskname }
    completions = completions.grep( /^#{Regexp.escape(s)}/ )
    if completions.count == 1
      completions = [completions.first]
    end
    completions
  }


  unless args[:script].nil?
    commands = args[:script].split("&&")
    commands.each do |command|
      command.strip!
      begin
        STDOUT.puts "Executing: #{command}"
        Rake::Task[command].invoke
      rescue RuntimeError => e
        STDOUT.puts "Don't know how to build task '#{command}'"
      end
    end
  end



  str = ''

  while str != 'exit'
    Readline.completion_proc = comp
    Readline.completion_append_character = ''
    current_dir_short = File.basename(pwd)

    str = Readline.readline("#{current_dir_short} rake> ", true)

    Readline::HISTORY.pop if /^\s*$/ =~ str
    begin
      if Readline::HISTORY[-2] == str
        Readline::HISTORY.pop
      end
    rescue IndexError
    end


    str = 'help' if str.nil?

    tokens = str.split(" ")

    if tokens.first == 'exit' || str.nil?
      File.open(".rake_history", "w"){|f|
        Readline::HISTORY.each{|l| f.puts l
        }
      }
      break

    elsif (tokens.first == "help") or (tokens.empty?)
      show_help.call
      show_tasks.call

    elsif tokens.first == 'rake'
      begin
        Rake.application.tasks.each{|task|
          Rake::Task[task].reenable()
        }
        tokens[1 .. -1].each{|token|
          task_name, args = Rake.application.parse_task_string(token)
          puts "invoking #{task_name}";Rake::Task[task_name].invoke(*args)
        }
      rescue RuntimeError => e
        STDOUT.puts "Don't know how to build task '#{e.message}'"
      end

    elsif
      a = `#{str}` rescue "#{$!}"
      puts a
    end
  end
end

