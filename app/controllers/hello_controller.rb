class HelloController < ApplicationController
  def world
    flash[:notice] = "example"
  end
end
