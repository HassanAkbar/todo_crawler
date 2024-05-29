# frozen_string_literal: true

require "rspec"
require "json"

require_relative "../todo_crawler"

RSpec.describe TodoCrawler do
  let(:id) { 2 }
  let(:uri) { URI.parse("#{TodoCrawler::BASE_URI}/#{id}") }

  let(:todo2) do
    {
      "completed" => false,
      "id" => id,
      "title" => "quis ut nam facilis et officia qui",
      "userId" => 1
    }
  end

  describe ".call" do
    it "should create a new instance and call the instance method" do
      response = double({ body: todo2.to_json })

      allow(Net::HTTP)
        .to receive(:get_response)
        .and_return(response)

      expect_any_instance_of(TodoCrawler).to receive(:call)

      described_class.call(id)
    end
  end

  describe "#call" do
    context "when url hit is successful" do
      let(:expected_response) do
        {
          success: true,
          todo: todo2
        }
      end

      it "should return the correct todo" do
        response = double({ body: todo2.to_json })

        allow(Net::HTTP)
          .to receive(:get_response)
          .and_return(response)
        # allow(Net::HTTP)
        #   .to receive(:get_response)
        #   .and_raise(Net::ReadTimeout)

        response = described_class.new(id).call

        expect(response).to eq(expected_response)
      end
    end

    context "when url hit raises error" do
      let(:expected_response) do
        {
          success: false,
          error: "Net::ReadTimeout"
        }
      end

      it "should return the correct todo" do
        allow(Net::HTTP)
          .to receive(:get_response)
          .and_raise(Net::ReadTimeout)

        response = described_class.new(id).call

        expect(response).to eq(expected_response)
      end
    end
  end
end
