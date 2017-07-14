require 'travis'

organization = "IBM-Swift"
#organization = "rolivieri"
#
puts "Initiating program to update environment variables in Travis CI jobs for organization '#{organization}'."
puts "#{organization}"

Travis.access_token = Travis.github_auth(ENV['TRAVIS_TOKEN'])
repos = Travis::Repository.find_all(owner_name: organization)
  .select{|repo| repo.slug == 'IBM-Swift/CloudConfiguration'}
	#.select{|repo| repo.slug == 'rolivieri/db-test'}
	#.reject{|repo| repo.slug == 'rolivieri/travis-secrets-setter'}
	#.reject{|repo| repo.slug == 'rolivieri/get-started-swift'}
	#.select{|repo| Travis.user.admin_access.include?(repo)}
keys = ['swift-4-dev-snapshot', 'swift4', 'swift4-dev']
repos.each do |repo|
	keys.each do |key|
		puts "Setting env var '#{key}' to '#{ENV['key']}' on project '#{repo.slug}'"
		repo.env_vars.upsert(key, "'#{ENV['key']}'", public: true)
	end
end
