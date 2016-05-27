module Likelion
	class InstallGenerator < Rails::Generators::NamedBase
		@@path = File.dirname(__FILE__)	
	  	desc = "#{@@path}/USAGE"
  		def copy_snippet
  			run("ruby #{@@path}/create_templates.rb #{file_name}")
  		end
	end
end
