class Resolvers::UsersResolver < Resolvers::BaseResolver
    class UsersOutputType < OutputType
        field(:result, [Types::UserType], null: false)
    end
    
    type(UsersOutputType, null: false)

    def resolve(filter: nil, order: nil, page: nil)
        return self.process(User.all, filter, order, page)
    end
end