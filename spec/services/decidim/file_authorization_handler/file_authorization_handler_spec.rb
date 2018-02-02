# frozen_string_literal: true

require "spec_helper"
RSpec.describe FileAuthorizationHandler do
  let(:organization) { FactoryBot.create(:organization) }
  let(:user) { FactoryBot.create(:user, organization: organization) }
  let(:dni) { "1234A" }
  let(:date) { Date.strptime("1990/11/21", "%Y/%m/%d") }
  let(:handler) do
    described_class.new(id_document: dni, birthdate: date)
                   .with_context(current_organization: organization)
  end

  let(:census_datum) do
    FactoryBot.create(:census_datum, id_document: dni,
                                     birthdate: date,
                                     organization: organization)
  end

  it "validates against database" do
    expect(handler.valid?).to be false
    census_datum
    expect(handler.valid?).to be true
  end

  it "normalizes the id document" do
    census_datum
    normalizer =
      described_class.new(id_document: "12-34-a", birthdate: date)
                     .with_context(current_organization: organization)
    expect(normalizer.valid?).to be true
  end

  it "generates birthdate metadata" do
    census_datum
    expect(handler.valid?).to be true
    expect(handler.metadata).to eq(birthdate: "1990/11/21")
  end

  it "works when no current_organization context is provided (but the user is)" do
    census_datum
    contextless_handler = described_class.new(user: user,
                                              id_document: dni,
                                              birthdate: date)
    expect(contextless_handler.valid?).to be true
  end
end