require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.ignore_paths = ["spec/**/*.pp", "pkg/**/*.pp"]

desc "Validate manifests, templates, and ruby files"
task :validate do
  Dir['manifests/**/*.pp'].each do |manifest|
    sh "puppet parser validate --noop #{manifest}"
  end
  Dir['spec/**/*.rb','lib/**/*.rb'].each do |ruby_file|
    sh "ruby -c #{ruby_file}" unless ruby_file =~ /spec\/fixtures/
  end
  Dir['templates/**/*.erb'].each do |template|
    sh "erb -P -x -T '-' #{template} | ruby -c"
  end
end

namespace :puppet_git_hooks do
  desc "Install Puppet Git Hooks"
  task :install do
    begin
      hooks_rpath = File.dirname(File.readlink(".git/hooks/pre-commit"))
    rescue
      puts "Please enter the hook path [#{Dir.pwd}]"
      hook_path = $stdin.gets.strip
      if hook_path.to_s.empty?
        hook_clone = '.puppet-git-hooks'
      else
        hook_clone = "#{hook_path}/.puppet-git-hooks"
      end
      if File.directory?("#{hook_path}/.puppet-git-hooks")
        puts "Hooks already in path at #{hook_clone}. Linking"
        system("#{hook_clone}/deploy-git-hook -d . -c")
      else
        puts "Hooks not found in #{hook_path}. Cloning"
        system("git clone https://bitbucket.arin.net/scm/ghm/puppet-git-hooks.git #{hook_clone}")
        system("#{hook_clone}/deploy-git-hook -d . -c")
        puts "Done!"
      end
    else
      puts "Git hooks already installed at #{hooks_rpath}"
    end
  end

  desc "Update Puppet Git Hooks"
  task :update do
    puts 'Updating Puppet Git Hooks...'
    working_dir = Dir.pwd
    repo_dir = File.dirname(File.readlink(".git/hooks/pre-commit"))
    system("cd #{repo_dir} && git checkout master && git pull & cd #{working_dir}")
    puts "Done!"
  end
end
