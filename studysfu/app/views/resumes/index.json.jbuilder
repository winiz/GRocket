json.array!(@resumes) do |resume|
 json.extract! @resume, :id, :name, :email, :phone, :p1, :p2, :p3, :p4, :p5, :p6, :p7
  json.url link_url(resume, format: :json)
end
