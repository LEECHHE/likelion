module Likelion
	class InstallGenerator < Rails::Generators::NamedBase
		@@path = File.dirname(__FILE__)	
	  	desc File.read("#{@@path}/USAGE")
 	
  		def copy_snippet
  			file_name = convert(file_name)
  			run("ruby #{@@path}/create_templates.rb #{file_name}")
  		end
	end
end
