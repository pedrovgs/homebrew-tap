class UseCaseCoverageCli < Formula
  desc "Command line interface for Use Case Coverage tool https://github.com/pedrovgs/UseCaseCoverage"
  homepage "https://github.com/pedrovgs/UseCaseCoverage"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.2.0/use_case_coverage_cli-aarch64-apple-darwin.tar.xz"
      sha256 "901317d8e49beb9598b2625bc2b353ac726d70d9db9b897eb69afb871ccf1b3a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.2.0/use_case_coverage_cli-x86_64-apple-darwin.tar.xz"
      sha256 "aaa76c7f6585c68ad09d5ca12ecc8076dccdfb02259549709536b18c880a1cc1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.2.0/use_case_coverage_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "93a5606c9a043e5a07ac5ce28f6b032b9ef935139ae645910f49735818c739ff"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.2.0/use_case_coverage_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d7d1d2103d5009ae08415167acd5cfee8853511f1890671cc51e553a03750f35"
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
