require 'mailgun'

class HomeController < ApplicationController
  def index
  end
  def write
    @title = params[:title]
    @receiver = params[:email]
    @content = params[:content]
    #mail_sending
    mg_client = Mailgun::Client.new("Api key")
    message_params =  {
                       from: 'master@example.com',
                       to:   @receiver,
                       subject: @title,
                       text:    @content
                      }
    
    result = mg_client.send_message('샌드박스', message_params).to_h!
    
    message_id = result['id']
    message = result['message']
  end
end