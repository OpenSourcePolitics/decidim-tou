# frozen_string_literal: true

# This class serializes a Meeting so can be exported to CSV, JSON or other
# formats.
module MeetingSerializerExtends
  # Public: Initializes the serializer with a meeting.
  def initialize(meeting, private_scope = false)
    @meeting = meeting
    @private_scope = private_scope
  end

  # Public: Exports a hash with the serialized data for this meeting.
  def serialize
    {
        id: meeting.id,
        category: {
            id: meeting.category.try(:id),
            name: meeting.category.try(:name)
        },
        scope: {
            id: meeting.scope.try(:id),
            name: meeting.scope.try(:name)
        },
        participatory_space: {
            id: meeting.participatory_space.id,
            url: Decidim::ResourceLocatorPresenter.new(meeting.participatory_space).url
        },
        component: { id: component.id },
        title: meeting.title,
        description: meeting.description,
        start_time: meeting.start_time.to_s(:db),
        end_time: meeting.end_time.to_s(:db),
        attendees: meeting.attendees_count.to_i,
        contributions: meeting.contributions_count.to_i,
        organizations: meeting.attending_organizations,
        address: meeting.address,
        location: meeting.location,
        reference: meeting.reference,
        comments: meeting.comments.count,
        attachments: meeting.attachments.count,
        followers: meeting.followers.count,
        url: url,
        related_proposals: related_proposals,
        related_results: related_results
    }
  end
end

Decidim::Meetings::MeetingSerializer.class_eval do
  prepend(MeetingSerializerExtends)
end
