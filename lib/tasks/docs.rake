namespace :docs do
  namespace :diagram do
    desc "Build Docker contaienr including the styles (from the root directory)"
    task build_container: :environment do
      sh("docker build --tag ma-banque-plantuml --file docs/Dockerfile docs")
    end

    desc "Render PlantUML diagrams (uses a Docker container)"
    task render: :environment do
      # TODO: This might take a while depending on the number of files
      # to render, therefore it might be interesting to have a task to
      # render a single file.
      #
      # There's also a command option to recurse `-r` through
      # directories.
      Dir.glob("./docs/*.puml").each { |filename|
        basename = File.basename(filename, ".puml")

        next if basename.eql?("styles")

        output_filename = "./docs/rendered-#{basename}.png"

        # This is to prevent "file exists" errors since PlantUML CLI
        # overwrite option isn't working as expected.
        File.delete(output_filename) if File.exist?(output_filename)

        sh("cat #{filename} | docker run --rm -i ma-banque-plantuml -tpng > #{output_filename}")
      }
    end
  end
end
