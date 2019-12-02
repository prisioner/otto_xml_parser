class BatchFileParseJob < ApplicationJob
  queue_as :default

  def perform(batch_file_id)
    BatchFileParserService.call(BatchFile.find(batch_file_id))
  end
end
