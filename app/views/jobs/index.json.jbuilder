json.array!(@jobs) do |job|
  json.extract! job, :address, :notes
  json.url job_url(job, format: :json)
end
