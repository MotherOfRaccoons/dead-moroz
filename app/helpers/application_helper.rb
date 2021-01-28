module ApplicationHelper
  def show_link(object, link: nil, content: 'Show', **options)
    link_to(content, link || object, options) if can?(:show, object)
  end

  def edit_link(object, link: nil, content: 'Edit', **options)
    link_to(content, link || [:edit, object], options) if can?(:update, object)
  end

  def destroy_link(object, link: nil, content: 'Destroy', **options)
    current_options = { method: :delete, data: { confirm: 'Are you sure?' } }
    link_to(content, link || object, current_options.merge(options)) if can?(:destroy, object)
  end

  def create_link(object, link: nil, content: 'New', **options)
    if can?(:create, object)
      object_class = (object.is_a?(Class) ? object : object.class)
      link_to(content, link || [:new, object_class.name.underscore.to_sym], options)
    end
  end
end
