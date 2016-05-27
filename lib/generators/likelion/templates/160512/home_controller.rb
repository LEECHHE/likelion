class HomeController < ApplicationController
  def index
  end
  def upload
    file = params[:pic]
    
    uploader= LightUploader.new
    uploader.store!(file)
    
    flash[:notice]="전송되었습니다"
    redirect_to "/home/index"
  end
end