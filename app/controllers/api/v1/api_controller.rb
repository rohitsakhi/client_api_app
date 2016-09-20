class Api::V1::ApiController < ActionController::Base
  require 'nokogiri'
  require 'open-uri'
   
  def fetch_api_data
  	data = Content.new(url: params[:url])
    doc = Nokogiri::HTML(open(params[:url]))
    a =  doc.search("//a")
	  h1 = doc.search("//h1")
    h2 = doc.search("//h2")
    h3 = doc.search("//h3")
    h6 = doc.search("//h6")
    p  = doc.search("//p")
    button = doc.search("//button")

    data.links = a.map{|e| e.attributes["href"]}.compact.map(&:value)
    data.h1 = h1.map{|e| e.children.first.text}
    data.h2 = h2.map{|e| e.children.first.text}
    data.h3 = h3.map{|e| e.children.first.text}
    data.h6 = h6.map{|e| e.children.first.text}
    data.p =  p.map{|e| e.children.first.text}
    data.button = button.map{|e| e.children.first.text}
    data.save
    render json: { response: data.as_json, status: true, errorList: [] }
  end  

  def get_all_contents
    urls = Content.all
    unless urls.blank?
      render json: { response: [list: urls.map{|e| [urls: e.url.as_json, h1: e.h1.as_json, h2: e.h2.as_json, h3:e.h3.as_json, h6: e.h6.as_json, p: e.p.as_json, button: e.button.as_json ]}], status: true, errorList: [] }
    else
      render json: {response: [ { list: [] }], status: false, errorList: [" Data not present"] }
    end
  end                               

  private

  def params_client
	params.require(:content).permit(:url,:h1,:h2,:h3,:h6,:p,:button)
  end
end
