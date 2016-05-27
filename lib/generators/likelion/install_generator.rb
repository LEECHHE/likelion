module Likelion
	class InstallGenerator < Rails::Generators::NamedBase
		@@path = File.dirname(__FILE__)	
	  	desc = "현재 생성 가능한 날짜는 [160408] 입니다"
  		def copy_snippet
  			run("ruby #{@@path}/create_templates.rb #{file_name}")
  		end
	end
end
