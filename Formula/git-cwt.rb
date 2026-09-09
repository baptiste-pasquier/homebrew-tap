class GitCwt < Formula
  desc "Remove the git worktrees whose branch has already been merged"
  homepage "https://github.com/baptiste-pasquier/homebrew-tap"
  url "https://github.com/baptiste-pasquier/homebrew-tap/archive/refs/tags/git-cwt-1.0.0.tar.gz"
  sha256 "PLACEHOLDER"
  license "MIT"

  # Squash-merged branches are only recognised through the GitHub API.
  depends_on "gh"

  def install
    bin.install "bin/git-cwt"
  end

  test do
    assert_match "usage: git cwt", shell_output("#{bin}/git-cwt --help")
    assert_match version.to_s, shell_output("#{bin}/git-cwt --version")

    # Outside a repository the tool must refuse to do anything.
    assert_match "not a git repository", shell_output("#{bin}/git-cwt 2>&1", 1)
  end
end
