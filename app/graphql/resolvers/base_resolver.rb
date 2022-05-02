module Resolvers
    class BaseResolver < GraphQL::Schema::Resolver
        class OutputType < Types::BaseObject
            class OrderType < Types::BaseObject
                field(:name, String, null: false)
                field(:by, String, null: false)
            end

            class PageType < Types::BaseObject
                field(:previous, Int, null: true)
                field(:number, Int, null: false)
                field(:next, Int, null: true)
                field(:count, Int, null: true)
                field(:total, Int, null: false)
                field(:pages, Int, null: false)
            end

            field(:page, PageType, null: true)
            field(:order, [OrderType], null: true)
        end

        class PageInputObject < Types::BaseInputObject
            argument(:number, Int, required: true,
                prepare: ->(v, c) {return [v, 0].max})
            argument(:count, Int, required: false,
                prepare: ->(v, c) {
                    return v.is_a?(NilClass) ? v : [v, 0].max
                })
        end

        class OrderInputObject < Types::BaseInputObject
            argument(:name, String, required: true)
            argument(:by, String, required: false, default_value: :asc)
        end

        class FilterInputObject < Types::BaseInputObject
            @@types = ["like", "in"]

            argument(:name, String, required: true)
            argument(:values, [String], required: true)
            argument(:type, String, required: false, default_value: @@types.first,
                prepare: ->(v, c) {
                    v = v.downcase()
                    v = @@types.first if !@@types.include?(v)
                    return v
                })
            argument(:not, Boolean, required: false, default_value: false)
        end

        argument(:page, PageInputObject, required: false)
        argument(:order, [OrderInputObject], required: false)
        argument(:filter, [FilterInputObject], required: false)
        
        private()

        def paginate(result, page=nil)
            return result if page.is_a?(NilClass)
            return result.page(page.number).per(page.count)
        end

        def order(result, order=nil)
            return result if order.is_a?(NilClass)
            os = {}.merge!(*order.map() {|e| {e.name => e.by}})
            return result.order(os)
        end

        def filter(result, filter=nil)
            return result if filter.is_a?(NilClass)
            values = []
            conds = filter.map() do |e|
                neg = e.not ? " not" : ""
                cond = "lower(#{e.name})" + neg
                vals = e.values
                if e.type == "in"
                    ps = (['?'] * vals.size).join(", ")
                    cond += " in (#{ps})"
                elsif e.type == "like"
                    vals = ["%#{vals.first}%"]
                    cond += " like ?"
                end
                values.append(*vals)
                cond
            end

            return result.where(
                conds.join(" or "),
                *values
            )
        end
    end
end
  