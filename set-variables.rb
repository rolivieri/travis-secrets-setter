require 'travis'

organization = "IBM-Swift"
puts "Initiating program to update environment variables in Travis CI jobs for organization '#{organization}'."


puts "#{organization}"
exit


Travis.access_token = Travis.github_auth(ENV['TRAVIS_TOKEN'])
repos = Travis::Repository.find_all(owner_name: organization)
	.reject{|repo| repo.slug == 'oehme/travis-secrets-setter'}
	.select{|repo| Travis.user.admin_access.include?(repo)}
keys = ['ORG_GRADLE_PROJECT_bintrayApiKey', 'ORG_GRADLE_PROJECT_signingPassword', 'ORG_GRADLE_PROJECT_sonatypePassword']
repos.each do |repo|
	keys.each do |key|
		puts "Setting env var '#{key}' on project '#{repo.slug}'"
		#repo.env_vars.upsert(key, "'#{ENV[key]}'", public: false)
	end
	#repo.env_vars.upsert("TERM", "'dumb'", public: true)
end
