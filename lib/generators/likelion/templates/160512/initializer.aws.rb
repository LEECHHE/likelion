CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS', 
    aws_access_key_id:     '자신의 id',        
    aws_secret_access_key: '자신의 key',        
    region:                'ap-northeast-2',    
    endpoint:              'http://s3.ap-northeast-2.amazonaws.com' 
}
  config.fog_directory  = '자신의 bucket 이름'                     
  config.fog_attributes = {} # optional, defaults to {}
end