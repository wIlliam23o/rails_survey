ActiveAdmin.register OptionTranslation do
  belongs_to :option
  permit_params :text, :language, :option_id
  actions :all, except: :new

  controller do
    defaults collection_name: 'translations'
  end
end
