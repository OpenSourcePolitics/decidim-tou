# frozen_string_literal: true

module CommentSerializerExtends
  def serialize
    {
        id: resource.id,
        created_at: resource.created_at,
        body: resource.body,
        author: {
            id: resource.author.id,
            name: resource.author.name,
            registration_metadata: resource.author.registration_metadata
        },
        alignment: resource.alignment,
        depth: resource.depth,
        user_group: {
            id: resource.user_group.try(:id),
            name: resource.user_group.try(:name) || empty_translatable
        },
        commentable_id: resource.decidim_commentable_id,
        commentable_type: resource.decidim_commentable_type,
        root_commentable_url: root_commentable_url
    }
  end
end

Decidim::Comments::CommentSerializer.class_eval do
  prepend(CommentSerializerExtends)
end
