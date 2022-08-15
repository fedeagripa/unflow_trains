class HomeController < ApplicationController
  def index
    destinations
  end

  def question
    stations = destinations.map{|d| d['StationDesc'] }
    query = params["query"]
    if stations.include?(query)
      response = DartService.new.next_trains(query)
    else
      response = "Sorry, I don't know how to answer that"
    end
    respond_to do |format|
      format.turbo_stream  do
        render turbo_stream: turbo_stream.update("responses",
                partial: "trains/search_results", locals: { trains: response })
      end
    end
  end

  def destinations
    @destinations ||= DartService.new.destinations
  end
end
