defmodule GforceWeb.RecognitionController do
    use GforceWeb, :controller
    require Logger
  
    def index(conn, params) do
      # TODO: Validate params with an Ecto Schemaless changeset
      Logger.info "RecognitionController called"

      feature_types = [
        "FACE_DETECTION", 
        "LOGO_DETECTION", 
        "LABEL_DETECTION", 
        "TEXT_DETECTION", 
        "SAFE_SEARCH_DETECTION",
        "OBJECT_LOCALIZATION"
      ]

      request = %GoogleApi.Vision.V1.Model.BatchAnnotateImagesRequest{
        requests: [
          %GoogleApi.Vision.V1.Model.AnnotateImageRequest{
            features: (for type <- feature_types, do: %GoogleApi.Vision.V1.Model.Feature{type: type}),
            image: %GoogleApi.Vision.V1.Model.Image{
              content: params["image"]
            }
          }
        ]
      }

      GoogleApi.Vision.V1.Connection.new()
      |> GoogleApi.Vision.V1.Api.Images.vision_images_annotate(key: params["key"], body: request)
      |> case do
        {:ok, response} ->
          conn
          |> put_status(:ok)
          |> render("response.json", response: response)
        {:error, info} ->
          Logger.error info
          conn
          |> put_status(:internal_server_error)
          |> render("500.json", info)
      end
    end
  end
  