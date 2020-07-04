module EventSource::TestHelper
  def prevent_event_dispatch
    stub_event_dispatch(nil)
  end

  def stub_event_dispatch(value)
    allow(EventSource::EventDispatcher).to(
      receive(:dispatch).and_return(value)
    )
  end
end
