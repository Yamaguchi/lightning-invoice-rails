# frozen_string_literal: true

json.set! :data do
  json.array! @<%= plural_table_name %> do |<%= singular_table_name %>|
    json.partial! '<%= plural_table_name %>/<%= singular_table_name %>', <%= singular_table_name %>: <%= singular_table_name %>
    json.url  "
              #{link_to t('views.show'), <%= model_resource_name %>}
              #{link_to t('views.deit'), edit_<%= singular_route_name %>_path(<%= singular_table_name %>)}
              #{link_to t('views.destroy'), <%= model_resource_name %>, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end
