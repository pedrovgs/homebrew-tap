class UseCaseCoverageCli < Formula
  desc "Command line interface for Use Case Coverage tool https://github.com/pedrovgs/UseCaseCoverage"
  homepage "https://github.com/pedrovgs/UseCaseCoverage"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.5.0/use_case_coverage_cli-aarch64-apple-darwin.tar.xz"
      sha256 "5876ceade915536b3d4df0b3fb798c5c19d0b81806248f3a4ce35f116f49507c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.5.0/use_case_coverage_cli-x86_64-apple-darwin.tar.xz"
      sha256 "ce3357159f137a3ed92956b32ecc5d4848bfe3b4ffd9af1cd73c9668d68ed97a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.5.0/use_case_coverage_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bb21410ab35a027f13c25ccc2e352257ffbaec589ba8472399c24622e436ae44"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.5.0/use_case_coverage_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e9fea3af99d7a0520faa72239b74201c4fe42050376d27261221355ebfc700fb"
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
