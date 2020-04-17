defmodule GforceWeb.ErrorView do
  use GforceWeb, :view
  require Logger

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.html", _assigns) do
  #   "Internal Server Error"
  # end

  def render("404.json", _assigns) do
    %{errors: %{detail: "Page Not Found"}}
  end
  def render("500.json", _assigns) do
    Logger.info "Calling render 500.json"
    %{errors: %{detail: "Internal Server Error"}}
  end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Logger.info "Calling template not found"
    Phoenix.Controller.status_message_from_template(template)
  end
end
