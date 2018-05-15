# frozen_string_literal: true

require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe <%= controller_class_name %>Controller, <%= type_metatag(:controller) %> do
  # This should return the minimal set of attributes required to create a valid
  # <%= class_name %>. As you add validations to <%= class_name %>, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { skip('Add a hash of attributes valid for your model') }
  let(:invalid_attributes) { skip('Add a hash of attributes invalid for your model') }
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # <%= controller_class_name %>Controller. Be sure to keep this updated too.
  let(:valid_session) { {} }

<% unless options[:singleton] -%>
  describe 'GET #index' do
    it 'returns a success response' do
      <%= class_name %>.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end
<% end -%>

  describe 'GET #show' do
    let(:<%= file_name %>) { <%= class_name %>.create! valid_attributes }

    it 'returns a success response' do
      get :show, params: { id: <%= file_name %>.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    let(:<%= file_name %>) { <%= class_name %>.create! valid_attributes }

    it 'returns a success response' do
      get :edit, params: { id: <%= file_name %>.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      subject(:action) { post :create, params: { <%= ns_file_name %>: valid_attributes }, session: valid_session }

      it 'creates a new <%= class_name %>' do
        expect { action }.to change(<%= class_name %>, :count).by(1)
      end

      it 'redirects to the created <%= ns_file_name %>' do
        action
        expect(response).to redirect_to(<%= class_name %>.last)
      end
    end

    context 'with invalid params' do
      subject(:action) { post :create, params: { <%= ns_file_name %>: invalid_attributes }, session: valid_session }

      it 'returns a success response (i.e. to display the "new" template)' do
        action
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    let(:<%= file_name %>) { <%= class_name %>.create! valid_attributes }

    context 'with valid params' do
      let(:new_attributes) { skip('Add a hash of attributes valid for your model') }

      it 'updates the requested <%= ns_file_name %>' do
        put :update, params: { id: <%= file_name %>.to_param, <%= ns_file_name %>: new_attributes }, session: valid_session
        <%= file_name %>.reload
        skip('Add assertions for updated state')
      end
      it 'redirects to the <%= ns_file_name %>' do
        put :update, params: { id: <%= file_name %>.to_param, <%= ns_file_name %>: valid_attributes }, session: valid_session
        expect(response).to redirect_to(<%= file_name %>)
      end
    end
    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "edit" template)' do
        put :update, params: { id: <%= file_name %>.to_param, <%= ns_file_name %>: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    subject(:action) { delete :destroy, params: { id: <%= file_name %>.to_param }, session: valid_session }

    let(:<%= file_name %>) { <%= class_name %>.create! valid_attributes }

    it 'destroys the requested <%= ns_file_name %>' do
      expect { action }.to change(<%= class_name %>, :count).by(-1)
    end
    it 'redirects to the <%= table_name %> list' do
      action
      expect(response).to redirect_to(<%= index_helper %>_url)
    end
  end
end
<% end -%>