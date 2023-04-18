ActiveAdmin.register Article do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description, :user_id

  # my comments---Ashish

  # show, edit, view actions allow to show on index or not
  # actions :all, except: [:update, :destroy, :edit, :show]


  # completely remove filters
  # config.filters = false

  # only filter those we basically required
  # filter :user, as: :check_boxes

  # You can also add a filter and still preserve the default filters:
  # preserve_default_filters!
  # filter :user, as: :check_boxes

  # Or you can also remove a filter and still preserve the default filters:
  # preserve_default_filters!
  # remove_filter :user

  #https://activeadmin.info/3-index-pages.html

  # my comments ends 

  #Ex:- :default =>''
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
