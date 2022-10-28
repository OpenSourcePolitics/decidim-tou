# frozen_string_literal: true

require "spec_helper"

describe "rake decidim:repare:nickname", type: :task do
  let!(:organization) { create(:organization) }
  let(:task_cmd) do
    Rails.application.load_tasks
    Rake::Task[:"decidim:repare:nickname"].reenable
    Rake::Task[:"decidim:repare:nickname"].invoke
  end

  let!(:user) { create(:user, organization: organization) }
  let!(:valid_user_2) { create(:user, nickname: "Azerty_Uiop123", organization: organization) }
  let(:invalid_user_1) { build(:user, nickname: "Foo bar", organization: organization) }
  let(:invalid_user_2) { build(:user, nickname: "Foo M. bar", organization: organization) }
  let(:invalid_user_3) { build(:user, nickname: "Foo-Bar_fooo$", organization: organization) }
  let(:invalid_user_4) { build(:user, nickname: "foo.bar.foo", organization: organization) }
  let(:invalid_user_5) { build(:user, nickname: ".foobar.foo_bar.", organization: organization) }

  context "when executing task" do
    before do
      invalid_user_1.save(validate: false)
      invalid_user_2.save(validate: false)
      invalid_user_3.save(validate: false)
      invalid_user_4.save(validate: false)
      invalid_user_5.save(validate: false)
    end

    it "exits without error" do
      expect { task_cmd }.not_to raise_error
    end

    context "when env var is set to true" do
      before do
        ENV["FORCE_NICKNAME_UPDATE"] = "true"
      end

      after do
        ENV["FORCE_NICKNAME_UPDATE"] = nil
      end

      it "updates invalid nicknames" do
        task_cmd

        invalid_user_1.reload
        expect(invalid_user_1.nickname).to eq("foobar")
        invalid_user_2.reload
        expect(invalid_user_2.nickname).to eq("foombar")
        invalid_user_3.reload
        expect(invalid_user_3.nickname).to eq("foobarfooo")
        invalid_user_4.reload
        expect(invalid_user_4.nickname).to eq("foobarfoo")
      end
    end

    context "when env var is set to default (false)" do
      it "updates invalid nicknames" do
        task_cmd

        invalid_user_1.reload
        expect(invalid_user_1.nickname).to eq("Foo bar")
        invalid_user_2.reload
        expect(invalid_user_2.nickname).to eq("Foo M. bar")
        invalid_user_3.reload
        expect(invalid_user_3.nickname).to eq("Foo-Bar_fooo$")
        invalid_user_4.reload
        expect(invalid_user_4.nickname).to eq("foo.bar.foo")
        invalid_user_5.reload
        expect(invalid_user_5.nickname).to eq(".foobar.foo_bar.")
      end
    end
  end
end
