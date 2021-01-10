import unittest
import os
import subprocess
import shlex
import unittest

class TestVersionsByCmd(unittest.TestCase):
  """test class to check some libraries to run commands
  """

  def test_anaconda(self):
    """test anaconda version
    """

    cmd = shlex.split("pyenv version")
    actual = subprocess.run(cmd, stdout=subprocess.PIPE).stdout.decode("utf-8").split()[0].split("-")[1]
    expected = os.environ["ANACONDA_VERSION"]
    self.assertEqual(expected, actual)

  def test_code_server_version(self):

    cmd = shlex.split("code-server --version")
    actual = subprocess.run(cmd, stdout=subprocess.PIPE).stdout.decode("utf-8").split()[0]
    expected = os.environ["CODE_SERVER_VERSION"]
    self.assertEqual(expected, actual)

  def test_nodejs_version(self):

    cmd = shlex.split("nodejs --version")
    actual = subprocess.run(cmd, stdout=subprocess.PIPE).stdout.decode("utf-8").split(".")[0]
    expected = "v" + os.environ["NODEJS_VERSION"]
    self.assertEqual(expected, actual)
    
if __name__ == "__main__":
  unittest.main()
