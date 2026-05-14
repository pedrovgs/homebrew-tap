class UseCaseCoverageCli < Formula
  desc "Command line interface for Use Case Coverage tool https://github.com/pedrovgs/UseCaseCoverage"
  homepage "https://github.com/pedrovgs/UseCaseCoverage"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.4.0/use_case_coverage_cli-aarch64-apple-darwin.tar.xz"
      sha256 "c786da59493060de679ac196c6a73c097c5ee0e7d6918da1dfe43e0e45bb28d8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.4.0/use_case_coverage_cli-x86_64-apple-darwin.tar.xz"
      sha256 "01cc6de6ca575a2eaa979a5d52b3cd03b4dba98248f9ced72d911d69e09172e3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.4.0/use_case_coverage_cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f7634a474eaf0cc764044abafedd8c262d29c622c4f82af28e94bf3fb14a88eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/pedrovgs/UseCaseCoverage/releases/download/v0.4.0/use_case_coverage_cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8d5496deced5d7658990bc318013eb56b3e64a4f575ad85e708d6cd3b2f0b8ca"
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
