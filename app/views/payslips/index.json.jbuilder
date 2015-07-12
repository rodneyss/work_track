json.array!(@payslips) do |payslip|
  json.extract! payslip, :id
  json.url payslip_url(payslip, format: :json)
end
