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

  def sortable(column, title: nil, **options)
    title ||= column.titleize
    direction = column == params[:sort] && params[:direction] == 'asc' ? 'desc' : 'asc'
    link_to(title, params.permit(:not_decided).merge({ sort: column, direction: direction }), options)
  end

  def sort_icon(column)
    return 'fa-sort' unless sort_column == column

    sort_direction == 'asc' ? 'fa-sort-up' : 'fa-sort-down'
  end

  def filterable(filter_by, title: nil, **options)
    title ||= filter_by.titleize
    unfiltered = params[filter_by] != 'true'
    link_to(title,
            params.permit(:sort).merge({ filter_by.to_sym => unfiltered }),
            options.merge(class: "#{'active' unless unfiltered} #{options[:class]}"))
  end
end
