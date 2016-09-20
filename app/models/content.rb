class Content < ActiveRecord::Base
  serialize :links, Array
  serialize :h1, Array
  serialize :h2, Array
  serialize :h3, Array
  serialize :h6, Array
  serialize :p, Array
  serialize :button, Array

  def as_json(options={})
    super(:only => [:url, :links, :h1, :h2, :h3, :h6, :p, :button])
  end
end
