require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
include Clockwork

module Clockwork
  # every(20.minutes, 'Queueing Newsletter job') { NewsletterWorker.perform_async }
  every(7.days, 'Queueing Newsletter Job', at: "Thursday 11:22") { NewsletterWorker.perform_async }
end