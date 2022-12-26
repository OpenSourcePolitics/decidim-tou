Rails.configuration.to_prepare do
  Decidim.view_hooks.send(:hooks).delete(:upcoming_meeting_for_card)
  Decidim.view_hooks.register(:upcoming_meeting_for_card, priority: Decidim::ViewHooks::LOW_PRIORITY) do |view_context|
    published_components = Decidim::Component.where(participatory_space: view_context.current_participatory_space).published
    upcoming_meeting = Decidim::Meetings::Meeting.where(component: published_components).published.upcoming.order(:start_time, :end_time).first

    next unless upcoming_meeting

    view_context.render(
      partial: "decidim/participatory_spaces/upcoming_meeting_for_card.html",
      locals: {
        upcoming_meeting: upcoming_meeting
      }
    )
  end
end
