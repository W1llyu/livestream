require "spec_helper"

RSpec.describe Livestream do
  it "has a version number" do
    expect(Livestream::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
