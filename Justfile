root_dir := justfile_directory()
src_dir := root_dir / "src"
build_dir := root_dir / "build"

build:
    rm -rf {{ build_dir }}
    mkdir -p {{ build_dir }}
    pandoc {{ src_dir / "blogpost.md" }} --from=markdown --to=html --output={{ build_dir / "blogpost.html" }}
    cp {{ src_dir / "metadata.toml" }} {{ build_dir }}
    cp -r {{ src_dir / "*.webp" }} {{ build_dir }}

[private]
install:
    cp -r {{ build_dir }} {{ env("out") }}
