# frozen_string_literal: true

require "spec_helper"

describe "rake decidim:repare:nickname", type: :task do
  let!(:organization) { create(:organization) }
<<<<<<< HEAD
  let(:task_cmd) do
    Rails.application.load_tasks
    Rake::Task[:"decidim:repare:nickname"].reenable
    Rake::Task[:"decidim:repare:nickname"].invoke
  end
=======
  let(:task_cmd) { :"decidim:repare:nickname" }
>>>>>>> develop

  let!(:user) { create(:user, organization: organization) }
  let!(:valid_user_2) { create(:user, nickname: "Azerty_Uiop123", organization: organization) }
  let(:invalid_user_1) { build(:user, nickname: "Foo bar", organization: organization) }
  let(:invalid_user_2) { build(:user, nickname: "Foo M. bar", organization: organization) }
  let(:invalid_user_3) { build(:user, nickname: "Foo-Bar_fooo$", organization: organization) }
  let(:invalid_user_4) { build(:user, nickname: "foo.bar.foo", organization: organization) }
  let(:invalid_user_5) { build(:user, nickname: ".foobar.foo_bar.", organization: organization) }
<<<<<<< HEAD
  let(:invalid_user_6) { build(:user, nickname: "foobar foo_bar", organization: organization) }
  let(:invalid_user_7) { build(:user, nickname: "", organization: organization) }
  let(:invalid_user_8) { build(:user, nickname: "François", organization: organization) }
  let(:invalid_user_9) { build(:user, nickname: "Solèné", organization: organization) }

  context "when executing task" do
    before do
      (1..9).each do |i|
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
        expect(invalid_user_8.reload.nickname).to eq("Francois")
        expect(invalid_user_9.reload.nickname).to eq("Solene")
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
=======

  context "when executing task" do
    before do
      invalid_user_1.save(validate: false)
      invalid_user_2.save(validate: false)
      invalid_user_3.save(validate: false)
      invalid_user_4.save(validate: false)
      invalid_user_5.save(validate: false)
    end

    it "exits with 0 code" do
      allow($stdin).to receive(:gets).and_return("y")

      expect { Rake::Task[task_cmd].invoke }.to raise_error(SystemExit) do |error|
        expect(error.status).to eq(0)
      end
    end

    context "when user accepts update" do
      it "updates invalid nicknames" do
        allow($stdin).to receive(:gets).and_return("y")

        expect { Rake::Task[task_cmd].invoke }.to change(invalid_user_1, :nickname).from("Foo bar").to("foobar")

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

    context "when user refuses update" do
      it "updates invalid nicknames" do
        allow($stdin).to receive(:gets).and_return("n")

        expect { Rake::Task[task_cmd].invoke }.not_to change(invalid_user_1, :nickname)

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
>>>>>>> develop
      end
    end
  end
end
