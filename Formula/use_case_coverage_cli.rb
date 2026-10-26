class UseCaseCoverageCli < Formula
  desc "Command line interface for Use Case Coverage tool https://github.com/pedrovgs/UseCaseCoverage"
  homepage "https://github.com/pedrovgs/UseCaseCoverage"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.5.2/use_case_coverage_cli-aarch64-apple-darwin.tar.xz"
      sha256 "7b820ec4bc4c0f298f15ad0df9f91924c5ada872a11947bcc572332ed93c9a1e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.5.2/use_case_coverage_cli-x86_64-apple-darwin.tar.xz"
      sha256 "24073d3fee407e436b75b56a62d9a6e67436b5656f9b6223c586f577a0c25c79"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.5.2/use_case_coverage_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9917ac026c2dffb18ad3c694480bf8ea43a3a950a711db77836f2fa6f66066eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.5.2/use_case_coverage_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a55a5e183c0283704133754bd93cadc84d974ff7ba2deebda7c406ae38a8e1ad"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "ucc"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ucc"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ucc"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ucc"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
