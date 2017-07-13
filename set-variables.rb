require 'travis'

#organization = "IBM-Swift"
organization = "rolivieri"
puts "Initiating program to update environment variables in Travis CI jobs for organization '#{organization}'."
puts "#{organization}"

Travis.access_token = Travis.github_auth(ENV['TRAVIS_TOKEN'])
repos = Travis::Repository.find_all(owner_name: organization)
	.reject{|repo| repo.slug == 'rolivieri/travis-secrets-setter'}
	.reject{|repo| repo.slug == 'rolivieri/get-started-swift'}
	.select{|repo| Travis.user.admin_access.include?(repo)}
keys = ['swift-4-dev-snapshot', 'key2', 'key3']
repos.each do |repo|
	keys.each do |key|
		puts "Setting env var '#{key}' on project '#{repo.slug}'"
		repo.env_vars.upsert(key, "'#{ENV[key]}'", public: false)
	end
end
