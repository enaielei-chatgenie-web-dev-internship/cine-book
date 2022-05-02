class Resolvers::UsersResolver < Resolvers::BaseResolver
    class UsersOutputType < OutputType
        field(:result, [Types::UserType], null: false)
    end
    
    type(UsersOutputType, null: false)

    def resolve(page: nil, order: nil, filter: nil)
        result = self.filter(User.all, filter)
        result = self.order(result, order)
        result = self.paginate(result, page)
        rv = {result: result}

        rv["page"] = {
            count: result.limit_value,
            next: result.next_page,
            number: result.current_page,
            pages: result.total_pages,
            previous: result.prev_page,
            total: result.total_count,
        } if page
        
        return rv
    end
end