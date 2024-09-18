# frozen_string_literal: true

require "active_support/concern"

module CommentVoteSerializerExtends
  extend ActiveSupport::Concern

  included do
    def root_commentable_url
      @root_commentable_url ||= if resource.comment.root_commentable.respond_to?(:polymorphic_resource_url)
                                  resource.comment.root_commentable.polymorphic_resource_url({})
                                else
                                  Decidim::ResourceLocatorPresenter.new(resource.comment.root_commentable).url
                                end
    end
  end
end

Decidim::Comments::CommentVoteSerializer.include(CommentVoteSerializerExtends)
