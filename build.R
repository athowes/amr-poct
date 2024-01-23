# Generate notebook
rmarkdown::render(input = "notebooks/model.Rmd", output_dir = "docs", output_file = "model.html")

# Generate dashboard
shinylive::export("dashboard", "docs")
