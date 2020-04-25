class StaticPagesController < ApplicationController
  layout 'application_home'
  skip_before_action :login_required

  def home
  end

  def help
  end
end
