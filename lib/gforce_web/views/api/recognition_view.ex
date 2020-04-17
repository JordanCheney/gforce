defmodule GforceWeb.RecognitionView do
    use GforceWeb, :view

    def render("response.json", %{response: response}) do
      case response do
        nil -> 
          %{status: :ok, message: "No response from server"}
        _ ->
          Poison.decode!(Poison.encode!(response))
      end
    end

    # By default, Phoenix returns the status message from
    # the template name. For example, "404.html" becomes
    # "Not Found".
    def template_not_found(template, _assigns) do
      Phoenix.Controller.status_message_from_template(template)
    end
end
  