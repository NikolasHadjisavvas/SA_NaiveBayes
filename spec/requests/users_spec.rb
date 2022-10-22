 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/users", type: :request do
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { givenname: 'My', sn: 'Name', ou: 'COM', email: 'my.name@sheffield.ac.uk' }
  }

  let(:invalid_attributes) {
    {givenname: 'My', sn: 'Name'}
  }

  let(:superuser)      { User.create(givenname: 'New', sn: 'User', ou: 'COM', email: 'new.user@sheffield.ac.uk', role: 'Superuser') }
  context 'As a Superuser' do

    before do
      login_as superuser
    end

    describe "GET /index" do
      it "renders a successful response" do
        get users_url
        expect(response).to be_successful
      end
    end

    describe "GET /show" do
      it "renders a successful response" do
        user = User.create! valid_attributes
        get user_url(user)
        expect(response).to be_successful
      end
    end

    describe "GET /new" do
      it "renders a successful response" do
        get new_user_url
        expect(response).to be_successful
      end
    end

    describe "GET /edit" do
      it "render a successful response" do
        user = User.create! valid_attributes
        get edit_user_url(user)
        expect(response).to be_successful
      end
    end

    describe "POST /create" do
      context "with valid parameters" do
        it "creates a new User" do
          expect {
            post users_url, params: { user: valid_attributes }
          }.to change(User, :count).by(1)
        end

        it "redirects to the created user" do
          post users_url, params: { user: valid_attributes }
          expect(response).to redirect_to(user_url(User.last))
        end
      end

      context "with invalid parameters" do
        it "does not create a new User" do
          expect {
            post users_url, params: { user: invalid_attributes }
          }.to change(User, :count).by(0)
        end

        it "renders a successful response (i.e. to display the 'new' template)" do
          post users_url, params: { user: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end

    describe "PATCH /update" do
      context "with valid parameters" do
        let(:new_attributes) {
          { givenname: 'My', sn: 'Name', ou: 'COM', email: 'my.name@sheffield.ac.uk', role: 'DLO' }
        }

        it "updates the requested user" do
          user = User.create! valid_attributes
          before_role = user.role
          patch user_url(user), params: { user: new_attributes }
          user.reload
          expect(user.role).not_to eq(before_role)
        end

        it "redirects to the user" do
          user = User.create! valid_attributes
          patch user_url(user), params: { user: new_attributes }
          user.reload
          expect(response).to redirect_to(user_url(user))
        end
      end

      context "with invalid parameters" do
        it "renders a successful response (i.e. to display the 'edit' template)" do
          user = User.create! valid_attributes
          patch user_url(user), xhr: true, params: { user: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested user" do
        user = User.create! valid_attributes
        expect {
          delete user_url(user)
        }.to change(User, :count).by(-1)
      end

      it "redirects to the users list" do
        user = User.create! valid_attributes
        delete user_url(user)
        expect(response).to redirect_to(users_url)
      end
    end
  end
end