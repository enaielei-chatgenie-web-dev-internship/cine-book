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
            argument(:condition, String, required: true)
            argument(:values, [String], required: false, default_value: [])
        end

        argument(:page, PageInputObject, required: false)
        argument(:order, [OrderInputObject], required: false)
        argument(:filter, FilterInputObject, required: false)
        
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
            return result.where(
                filter.condition,
                *filter.values
            )
        end

        def process(result, filter=nil, order=nil, page=nil)
            result = self.filter(result, filter)
            result = self.order(result, order)
            result = self.paginate(result, page)
            rv = {result: result}
    
            rv["order"] ||= order
    
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
end
  