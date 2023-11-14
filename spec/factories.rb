# frozen_string_literal: true

%w(
  core
  proposals
  budgets
  blogs
  debates
  meetings
  accountability
  system
  participatory_processes
  verifications
  surveys
).each { |f| require "decidim/#{f}/test/factories" }
