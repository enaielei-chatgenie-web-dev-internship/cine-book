module ApplicationHelper
    $VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    $VALID_MOBILE_NUMBER_REGEX = /\A09\d{9}\z/i
    
    $VALID_IMAGE_UPLOAD = "image/*"

    $TITLE = "CineBook"
    $SUBTITLE = "Your companion for movie booking"
    $AUTHOR = "Nommel Isanar L. Amolat"

    def page_link(properties={})
        props = properties
        options = props[:options] || {}
        html_options = props[:html_options] || {}

        body = props[:body] || ""
        return link_to(body || page.to_s(), options, html_options)
    end

    def get_placeholder(text="?")
        text = text.split(" ").join("+")
        return "https://via.placeholder.com/100/a34c13/fff?text=#{text}"
    end
end
