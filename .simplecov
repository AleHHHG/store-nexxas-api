SimpleCov.minimum_coverage_by_file 95
SimpleCov.minimum_coverage 95

SimpleCov.start "rails" do
  add_group "Business", "app/business"
  add_group "Serializers", "app/serializable"

  add_filter "/features/"
end