guard 'rspec', cmd: "bundle exec rake" do
  watch(%r{^spec/(.+).rb$}) { |m| "spec/#{m[1]}.rb" }
  watch(%r{^lib/(.+).rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { "spec" }
end