class Report < ActiveRecord::Base
  attr_accessible :content, :user_id
  belongs_to :user

   def self.inherited(child)
    child.instance_eval do
      def model_name
        Report.model_name
      end
    end
    super
  end

  def self.factory(type, params = nil)
      type ||= 'Report'
      class_name = type
    if defined? class_name.constantize
      class_name.constantize.new(params)
    else
      Report.new(params)
    end
  end

end
