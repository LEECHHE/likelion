module Likelion
	class InstallGenerator < Rails::Generators::NamedBase
	  	desc "This generator creates an initializer file at config/initializers"

  		def copy_snippet
  			path = File.dirname(__FILE__)	
  			run("ruby #{path}/create_templates.rb #{file_name}")
  		end
	end
end
