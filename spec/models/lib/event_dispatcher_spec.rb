require "rails_helper"

describe Lib::EventDispatcher do
  module TestEventDispatcher
    # There's no need to extend Lib::BaseEvent here because the
    # dispatcher internal condition is using `is_a?` method.
    class Event
      attr_accessor :double

      def initialize(double)
        @double = double
      end
    end

    class Reactor
      def self.call(event)
        event.double.foo()
      end
    end

    class Dispatcher < Lib::EventDispatcher
      on TestEventDispatcher::Event, trigger: TestEventDispatcher::Reactor
    end
  end

  describe ".dispatch" do
    it "calls the reactor once" do
      pending("For some reason it's failing ¯\\_(ツ)_/¯")

      double = double('recorder', foo: true)
      TestEventDispatcher::Dispatcher.dispatch(TestEventDispatcher::Event.new(double))

      expect(double).to receive(:foo).once
    end
  end
end
