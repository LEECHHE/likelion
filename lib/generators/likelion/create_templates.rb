require 'thor'
require 'rails'
class CreateTemplates < Thor::Group
	include Thor::Actions

	raise ArgumentError, "The date should be input." if ARGV[0] == nil
	@@path = "#{File.dirname(__FILE__)}/templates/#{ARGV[0]}"
	
	def self.source_root
    	File.dirname(__FILE__)
  	end
	
	def process
		source_paths << @@path
		#모델, 컨트롤러 등 생성
		run_commands

		#view  생성
		create_views

		#application_controller.rb 주석 처리
		comment_application_controller
		#bootstrap 추가
		add_bootstraps
		#routes.rb 설정
		set_routes
	end

	def run_commands	
		File.open("#{@@path}/command.txt","r") do |infile|
			#command.txt 내에 있는 커맨드 읽기
			while( line = infile.gets )
				#주석은 통과
				if line[0] == '#'
					next
				end
				#Command 실행. Thor::Actions::run(cmd)
				run (line)
				#Model과 Controller인 경우 내용(method, attributes 등) 추가
				add_attributes(line)
			end
		end
	end

	def copy_file(src, dest)
		"cp -rf #{src} #{dest}"
	end
	def add_attributes(line)
		#TODO : Devise는...?
		# Thor::Actions::inject_into_class
		line = line.split
		if line[2].eql?"controller"
			run(copy_file("#{@@path}/#{line[3]}_controller.rb", \
				"app/controllers/#{line[3]}_controller.rb"))
		elsif line[2].eql?"model"
			if File.exist?("#{@@path}/#{line[3]}.rb")
				run(copy_file("#{@@path}/#{line[3]}.rb", \
					"app/models/#{line[3]}.rb"))
			end
			#데이터베이스 설정
			set_database(line[3].pluralize)
		end
	end

	def set_database(model_name)
		if not File.exist?("#{@@path}/create_#{model_name}.rb")
			return
		end
		db_file = Dir['db/migrate/*'].select { |f| f =~ /#{model_name}.rb$/ } 
		run(copy_file("#{@@path}/create_#{model_name}.rb",db_file[0]))
	end


	def comment_application_controller
		# appication_controller.rb에 protect_from_forgery 주석 처리
		# Thor::Actions::comment_lines
		comment_lines 'app/controllers/application_controller.rb', /protect_from_forgery with: :exception/
	end

	def add_bootstraps
		#Bootstrap CDN 추가
		# Thor::Actions::insert_into_file
		insert_into_file "app/views/layouts/application.html.erb", bootstrap_cdn, :before => "</head>\n"
	end

	def bootstrap_cdn
		'<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>'
	end

	def set_routes
		#routes.rb 내용을 복사
		run(copy_file("#{@@path}/routes.rb", "config/routes.rb"))
	end

	def create_views
		File.open("#{@@path}/views.txt","r") do |infile|
			while(filename = infile.gets)
				filename.rstrip!
				controller, view = filename.split('.',2)
				run(copy_file("#{@@path}/#{filename}", \
					"app/views/#{controller}/#{view}"))
			end
		end
	end
end

CreateTemplates.new.process