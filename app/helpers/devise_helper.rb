module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map do |message| 
      message = <<-HTML
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
          #{message}
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      HTML
    end
    messages.join.html_safe
  end
end
