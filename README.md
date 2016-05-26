# Likelion
멋쟁이 사자처럼 수업 때 사용된 코드들을 생성하는 Gem 입니다.
수업 종료할 때 작성된 코드를 생성합니다.

## Dependency
- Ruby 2.1.2
	- 현재 2.2버젼 이상에선 오류가 나고 있습니다ㅠㅠ Thor때문인 거 같은데 도와주세요

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'likelion', git: 'https://github.com/LEECHHE/likelion'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install likelion

## Usage

Gem을 설치한 후 아래와 같이 사용합니다.

	$ rails generate likelion:install [날짜]

날짜는 'YYMMDD' 형식으로 입력됩니다. 예를 들어 16년 4월 8일에 진행된 수업의 코드는

	$ rails generate likelion:install 160408

와 같이 불러올 수 있습니다.

## Contributing
이 Gem은 누구든지 추가할 수 있습니다. 내용을 추가하기 위해선 생성하고자 하는 폴더의 상위 폴더에서 아래의 명령어를 실행합니다.

	$ git clone 'https://github.com/LEECHHE/likelion'
    $ cd likelion

Gem의 파일 중 lib에 파일을 추가합니다. 구조는 아래와 같습니다.

	└── lib
		└── generators
			└── likelion
				└──  create_templates.rb
				├── install_generator.rb
				├── USAGE
				└── templates
					└── 160408
						└── command.txt
		          		├── [CONTROLLER].rb (ex. home_controller.rb)
		          		├── routes.rb
		          		├── views.txt
		          		├── [CONTROLLER_NAME].[METHOD].html.erb (ex. home.index.html.erb)
		          		├── ....

            
- install_generator.rb
 	- create_templates.rb를 실행하며 rails generator를 생성합니다.

- create_templates.rb
 - Model, Controller, View, 파일 복사 등을 담당합니다.

### Templates
Templates 폴더는 'YYMMDD' 형식으로 된 날짜를 이름으로 갖는 폴더로 구성되어 있습니다. 이 날짜는 강의를 한 날짜에 해당합니다. 각 파일들은 위와 같이 5가지 종류의 파일로 구성되어 있습니다. 
- command.txt : 커맨드 창에 직접 입력한 명령어 중 Model과 Controller 관련 내용입니다. ##은 주석으로 간주되며 실행하지 않습니다.

```
## 컨트롤러 생성
rails g controller home
```

- [CONTROLLER].rb : Controller에 작성한 내용 중 <b>클래스의 메소드만</b> 작성한 것입니다. 각 라인마다 Tab으로 한 칸씩 띄워야하며 마지막 end 뒤에 Enter를 입력해 새로운 줄로 끝내야 합니다.


```ruby
	def index
	end
	def write
		@almond = params[:title]
		@anchovy = params[:content]
	end

```

- routes.rb : routes.rb에 추가해야할 내용입니다. Devise는 자동으로 routes가 추가되므로 이 곳에 작성하지 않습니다. 마찬가지로 각 라인은 Tab으로 한 칸 띄우고 새로운 줄로 끝내야 합니다.


```ruby
	root 'home#index'

	get '/' => 'home#index'
	post '/write' => 'home#write'


```

- views.txt : view 파일들의 목록입니다. 주의할 점은 [컨트롤러 이름].[메소드 이름].html.erb 로 앞에 컨트롤러 이름이 추가된 점입니다. 예를 들어 home_controller.rb의 index 메소드와 연관된 view는 home.index.html.erb 입니다.


```
home.index.html.erb
home.write.html.erb

```

- [CONTROLLER_NAME].[METHOD].html.erb : View 파일입니다. 앞에 컨트롤러 이름이 붙는 것에 유의해주시기 바랍니다. 16년 4월 8일에 진행된 강의에서 index.html.erb는 아래와 같습니다.

```erb
<div class="container">
  <h1>게시판입니다.</h1>
  <form action="/write" method="POST">
    <div class="form-group">
      <label for="exampleInputEmail1">글 제목</label>
      <input type="text" class="form-control" id="exampleInputEmail1" name="title">
    </div>
    <div class="form-group">
      <label for="exampleInputPassword1">글 내용</label>
      <textarea name="content" class="form-control" id="exampleInputPassword1">
    </div>
    <button type="submit" class="btn btn-default">전송완료</button>
  </form>
</div>
```

#### 생성 순서
create_templates::process에서 실행되며 순서는 아래와 같습니다.

1. views.txt를 한 줄 씩 읽으며 view를 추가합니다.
2. command.txt를 한 줄 씩 읽으며 model과 controller를 생성합니다.
3. application_controller.rb 에 protect_from_forgery를 주석 처리합니다.
4. Bootstrap CDN을 application.html.erb에 추가합니다.
5. routes.rb를 읽어 routes 설정을 합니다.

## Testing
추가한 코드가 제대로 동작하는지 테스트해볼 수 있습니다. 작성한 파일의 Commit을 완료한 상태에서

	$ gem build likelion.gemspec
    
위 명령어를 입력하면 likelion-[VERSION].gem 이 생성됩니다. 2016년 5월 27일 기준으로 likelion-0.1.1.gem 이 생성됩니다. 새로운 rails application을 만들어 테스트해봅시다.

	$ cd ..
    $ rails new blog
    $ cd ./blog
    
Gemfile 에 아래와 같은 내용을 추가합니다.
```ruby
gem 'likelion', path:"../likelion"
```
Gem을 설치합니다.

    $ bundle install


이제 만든 Gem을 테스트해볼 수 있습니다. Usage를 참고하여 아래와 같은 명령어를 입력합니다.

	$ rails generate likelion:install 160408

위 명령어의 날짜에 추가한 날의 날짜를 넣으면 아래와 같이 추가됩니다.

```ruby
➜  blog rails g likelion:install 160408
Running via Spring preloader in process 70972
         run  ruby /Users/leechhe/Documents/Development/likelion/lib/generators/likelion/create_templates.rb 160408 from "."
      create  app/views/home/index.html.erb
      create  app/views/home/write.html.erb
         run  rails g controller home from "."
Running via Spring preloader in process 70978
      create  app/controllers/home_controller.rb
      invoke  erb
       exist    app/views/home
      invoke  test_unit
      create    test/controllers/home_controller_test.rb
      invoke  helper
      create    app/helpers/home_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/home.coffee
      invoke    scss
      create      app/assets/stylesheets/home.scss
      insert  app/controllers/home_controller.rb
        gsub  app/controllers/application_controller.rb
      insert  app/views/layouts/application.html.erb
      insert  config/routes.rb
```


Bug reports and pull requests are welcome on GitHub at https://github.com/LEECHHE/likelion. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

