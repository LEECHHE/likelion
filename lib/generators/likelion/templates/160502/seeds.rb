Post.create(title: '안녕하세요', content: '첫 글 입니다.')
Post.create(:title => '두번째 글', :content => '두번째 글 입니다.')
new_post = Post.new
new_post.title = "셋째 글~!"
new_post.content = "이래도 동작함?"
new_post.save

Reply.create(:content => '댓글이당!', :post_id => 1)

reply = Reply.new
reply.content = '두번째 댓글'
reply.post_id = '1'
reply.save

reply = Reply.new
reply.content = '세번째 댓글'
reply.post = new_post
reply.save