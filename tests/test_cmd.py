import unittest
import os
import subprocess
import shlex
from unittest.case import expectedFailure

class TestVersionsByCmd(unittest.TestCase):
  """test class to check some libraries to run commands
  """

  def test_cuda_version(self):
    """test cuda version
    """

    cmd = shlex.split("nvcc -V")
    actual = subprocess.run(cmd, stdout=subprocess.PIPE).stdout.decode("utf-8").splitlines()[3].split(",")[1].split()[1]

    base_cuda_version = os.environ["BASE_IMG_CUDA_VERSION"].split("-")[0]
    splited_base_cuda_version = base_cuda_version.split(".")
    expected = splited_base_cuda_version[0] + "." + splited_base_cuda_version[1]

    self.assertEqual(expected, actual)

  def test_optuna_cmd_version(self):
    """test optuna cmd version
    """

    cmd = shlex.split("optuna --version")
    actual = subprocess.run(cmd, stdout=subprocess.PIPE).stdout.decode("utf-8").splitlines()[0].split()[1]
    expected = os.environ["OPTUNA_VERSION"]
    self.assertEqual(expected, actual)

if __name__ == "__main__":
  unittest.main()
