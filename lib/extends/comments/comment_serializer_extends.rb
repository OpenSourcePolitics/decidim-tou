require "active_support/concern"

module CommentSerializerExtends
  extend ActiveSupport::Concern

  included do
    def root_commentable_url
      @root_commentable_url ||= if resource.root_commentable.respond_to?(:polymorphic_resource_url)
                                  resource.root_commentable.polymorphic_resource_url({})
                                else
                                  Decidim::ResourceLocatorPresenter.new(resource.root_commentable).url
                                end
    end
  end
end

Decidim::Comments::CommentSerializer.include(CommentSerializerExtends)
