require 'travis'

organization = "IBM-Swift"
#organization = "rolivieri"

puts "About to update public environment variable(s) in Travis CI jobs for organization '#{organization}'."

Travis.access_token = Travis.github_auth(ENV['TRAVIS_TOKEN'])
repos = Travis::Repository.find_all(owner_name: organization)
  .select{|repo| repo.slug == 'IBM-Swift/CloudConfiguration'}
	#.select{|repo| repo.slug == 'rolivieri/db-test'}
	#.reject{|repo| repo.slug == 'rolivieri/travis-secrets-setter'}
	#.reject{|repo| repo.slug == 'rolivieri/get-started-swift'}
	#.select{|repo| Travis.user.admin_access.include?(repo)}
keys = ['swift_4_dev_snapshot']
repos.each do |repo|
	keys.each do |key|
		puts "Setting env var '#{key}' to '#{ENV[key]}' on project '#{repo.slug}'"
		repo.env_vars.upsert(key, "#{ENV[key]}", public: true)
	end
end
