module ApplicationHelper
    $VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    $VALID_MOBILE_NUMBER_REGEX = /\A09\d{9}\z/i

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
end
