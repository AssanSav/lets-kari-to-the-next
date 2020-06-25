class Api::V1::AvatarsController < ApplicationController

    def update
        user = User.find(params[:user_id])
        if params[:file] != ""
            # binding.pry
            user.avatar.attach(params[:file])
            photo = url_for(user.avatar)
        elsif params[:camera]
            blob = ActiveStorage::Blob.create_after_upload!(
                io: StringIO.new((Base64.decode64(params[:camera].split(",")[1]))),
                filename: "user.png",
                content_type: "image/png",
            )
            user.avatar.attach(blob)
            photo = url_for(user.avatar)
        else
            photo = photo_params[:photo]
        end
            if user.update(image: photo)
            render json: {
                status: 200,
                user: UserSerializer.new(user),
                interests: user.interests
            }
        end

    end

    private 

    def avatar_params
        params.permit(:id, :user_id, :camera, :file)
    end
end






























#