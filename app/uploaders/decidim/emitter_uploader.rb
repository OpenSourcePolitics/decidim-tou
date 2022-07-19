# frozen_string_literal: true

module Decidim
  # This class deals with uploading emitters logo to a Participatory process.
  class EmitterUploader < RecordImageUploader
    set_variants do
      {
        emitter: { resize_to_fill: [512, 82] },
      }
    end
  end
end

