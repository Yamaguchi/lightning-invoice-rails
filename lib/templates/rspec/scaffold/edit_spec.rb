# frozen_string_literal: true

require 'rails_helper'

<% output_attributes = attributes.reject{|attribute| [:datetime, :timestamp, :time, :date].index(attribute.type) } -%>
RSpec.describe '<%= ns_table_name %>/edit', <%= type_metatag(:view) %> do
  let(:<%= ns_file_name %>) { FactoryBot.create(:<%= ns_file_name %>) }

  before { assign(:<%= ns_file_name %>, <%= ns_file_name %>) }

  it 'renders the edit <%= ns_file_name %> form' do
    render
    assert_select 'form[action=?][method=?]', <%= ns_file_name %>_path(<%= ns_file_name %>), 'post' do <% for attribute in output_attributes -%><%- name = attribute.respond_to?(:column_name) ? attribute.column_name : attribute.name %>
      assert_select '<%= attribute.input_type -%>[name=?]', '<%= ns_file_name %>[<%= name %>]'
<% end -%>
    end
  end
end
