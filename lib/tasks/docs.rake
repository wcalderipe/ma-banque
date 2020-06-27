namespace :docs do
  namespace :diagram do
    desc "Render PlantUML diagrams (uses a Docker container)"
    task render: :environment do
      # TODO: This might take a while depending on the number of files
      #       to render, therefore it might be interesting to have a
      #       task to render a single file.
      puts Dir.glob("./docs/*.puml").map { |filename|
        basename = File.basename(filename, ".puml")
        output_filename = "./docs/rendered-#{basename}.png"

        sh("cat #{filename} | docker run --rm -i think/plantuml -tpng > #{output_filename}")
      }
    end
  end
end
