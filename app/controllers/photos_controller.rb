class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })

    render({ :template => "photo_templates/index" })
  end

  def show
    # Parameters: {"path_id"=>"777"}
    url_id = params.fetch("path_id")


    matching_photos = Photo.where({ :id => url_id})

    @the_photo = matching_photos.at(0)

    render({ :template => "photo_templates/show" })
  end

  def delete
    #  Parameters: {"path_id"=>"765"}

    the_id = params.fetch("path_id")

    matching_photos = Photo.where({ :id => the_id })

    the_photo = matching_photos.at(0)

    the_photo.destroy

    redirect_to("/photos")
  end

  def create

    input_image = params.fetch("query_image")
    input_caption = params.fetch("query_caption")
    input_owner_id = params.fetch("query_owner_id")

    a_new_photo = Photo.new
    a_new_photo.image = input_image
    a_new_photo.caption = input_caption
    a_new_photo.owner_id = input_owner_id

    a_new_photo.save

    next_url = "/photos/" + a_new_photo.id.to_s

    redirect_to(next_url)
  end

  def update
    #   Parameters: {"query_image"=>"https://www.78chicago.com/sites/g/files/ujywhv391/files/styles/three_quarter_image_desktop/public/2022-09/03_DPI%20HQ-Aerial%20View_OMA%20and%20Lucian%20R_Website_0.jpg?h=c44fcfa1&itok=XznrTO-31", "query_caption"=>"seven eight update", "path_id"=>"952"}
    the_id = params.fetch("path_id")

    matching_photos = Photo.where({ :id => the_id})
    
    the_photo = matching_photos.at(0)
    
    input_image = params.fetch("query_image")
    input_caption = params.fetch("query_caption")
    
    the_photo.image = input_image
    the_photo.caption = input_caption

    the_photo.save
    
    next_url = "/photos/" + the_photo.id.to_s

    redirect_to(next_url)

  end
end
