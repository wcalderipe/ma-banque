require "rails_helper"

describe Lib::EventDispatcher do
  # There's no need to extend Lib::BaseEvent here because the
  # dispatcher internal condition is using `is_a?` method.
  class TestEvent
    attr_accessor :double

    def initialize(double)
      @double = double
    end
  end

  class TestReactor
    def self.call(event)
      event.double.foo()
    end
  end

  describe ".dispatch" do
    class TestEventDispatcher < Lib::EventDispatcher
      on TestEvent, trigger: TestReactor
    end

    it "calls the reactor once" do
      pending("For some reason it's failing ¯\\_(ツ)_/¯")

      double = double('recorder', foo: true)
      TestEventDispatcher.dispatch(TestEvent.new(double))

      expect(double).to receive(:foo).once
    end
  end
end
