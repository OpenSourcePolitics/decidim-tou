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
  let(:invalid_user_6) { build(:user, nickname: "foobar foo_bar", organization: organization) }
  let(:invalid_user_7) { build(:user, nickname: "", organization: organization) }

  context "when executing task" do
    before do
      (1..7).each do |i|
        send("invalid_user_#{i}").save(validate: false)
      end
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

        expect(invalid_user_1.reload.nickname).to eq("Foobar")
        expect(invalid_user_2.reload.nickname).to eq("FooMbar")
        expect(invalid_user_3.reload.nickname).to eq("Foo-Bar_fooo")
        expect(invalid_user_4.reload.nickname).to eq("foobarfoo")
        expect(invalid_user_5.reload.nickname).to eq("foobarfoo_bar")
      end

      context "when nickname is already taken" do
        it "adds a suffix to nicknames" do
          task_cmd

          expect(invalid_user_5.reload.nickname).to eq("foobarfoo_bar")
          expect(invalid_user_6.reload.nickname).to eq("foobarfoo_bar-#{invalid_user_6.id}")
        end
      end

      it "updates invalid nicknames to valid nicknames" do
        task_cmd

        expect(invalid_user_1.reload.valid?).to eq(true)
        expect(invalid_user_2.reload.valid?).to eq(true)
        expect(invalid_user_3.reload.valid?).to eq(true)
        expect(invalid_user_4.reload.valid?).to eq(true)
        expect(invalid_user_5.reload.valid?).to eq(true)
        expect(invalid_user_6.reload.valid?).to eq(true)
      end

      it "doesn't updates empty nicknames" do
        task_cmd

        expect(invalid_user_7.reload.nickname).to eq("")
      end
    end

    context "when env var is set to default (false)" do
      it "doesn't updates invalid nicknames" do
        task_cmd
        expect(invalid_user_1.reload.nickname).to eq("Foo bar")
        expect(invalid_user_2.reload.nickname).to eq("Foo M. bar")
        expect(invalid_user_3.reload.nickname).to eq("Foo-Bar_fooo$")
        expect(invalid_user_4.reload.nickname).to eq("foo.bar.foo")
        expect(invalid_user_5.reload.nickname).to eq(".foobar.foo_bar.")
        expect(invalid_user_6.reload.nickname).to eq("foobar foo_bar")
        expect(invalid_user_7.reload.nickname).to eq("")
      end
    end
  end
end
