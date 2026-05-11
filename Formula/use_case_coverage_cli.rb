class UseCaseCoverageCli < Formula
  desc "Command line interface for Use Case Coverage tool https://github.com/pedrovgs/UseCaseCoverage"
  homepage "https://github.com/pedrovgs/UseCaseCoverage"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.1.0/use_case_coverage_cli-aarch64-apple-darwin.tar.xz"
      sha256 "12ebd5bd0beea870e47e93df38d38315fdf629171c21863646a11291686656dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.1.0/use_case_coverage_cli-x86_64-apple-darwin.tar.xz"
      sha256 "412ab6dd8fa5b0c333dc25980461c7f97c1f6d4a93ad77a856eb3d30f13128ff"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.1.0/use_case_coverage_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1534e147840820291aecf26d77b9233d8aac808cf50bce64c664113ea053fb29"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.1.0/use_case_coverage_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6526b5deb69167c8df95da6aaa60b4c2cc92434326883b1ca4c79a45a0ecb5f2"
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
