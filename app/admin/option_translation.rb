ActiveAdmin.register OptionTranslation do
  menu priority: 10
  permit_params :text, :language, :option_id
end
