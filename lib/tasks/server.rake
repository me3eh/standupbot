namespace :server do

  desc "Start development server"
  task :dev do
    system("RACK_ENV='development' foreman start")
  end

  desc "Start test server"
  task :test do
    system("RACK_ENV='test' foreman start")
  end
end
