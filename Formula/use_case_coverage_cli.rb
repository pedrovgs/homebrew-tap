class UseCaseCoverageCli < Formula
  desc "Command line interface for Use Case Coverage tool https://github.com/pedrovgs/UseCaseCoverage"
  homepage "https://github.com/pedrovgs/UseCaseCoverage"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.5.1/use_case_coverage_cli-aarch64-apple-darwin.tar.xz"
      sha256 "82423d36050f8aa42423ff7d6abb2fb0e081bd6f2c2dd4a81552edcc2d9eeafc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.5.1/use_case_coverage_cli-x86_64-apple-darwin.tar.xz"
      sha256 "6d32c7724879106b0d53c55cec0bbd47d8848e38e408294a551c0e6b51840bac"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.5.1/use_case_coverage_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7c8d3c25692b639d7b6a78a4cdec4a28207da1f0f0772e7a04033d484aeb9b86"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.5.1/use_case_coverage_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ad39c0ec9388841e470564f0680c3443113a376b12edad6ba066fb6526e3eaf1"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "ucc" if OS.mac? && Hardware::CPU.arm?
    bin.install "ucc" if OS.mac? && Hardware::CPU.intel?
    bin.install "ucc" if OS.linux? && Hardware::CPU.arm?
    bin.install "ucc" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
