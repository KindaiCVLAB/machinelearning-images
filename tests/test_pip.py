import unittest
import os
import subprocess
import shlex
from distutils.version import LooseVersion

class TestVersionsByPip(unittest.TestCase):
  """test class to check some libraries by pip
  """

  def test_jupyter_version(self):
    """test jupyter version
    """

    actual = search_pkg_version("jupyterlab")
    expected = os.environ["JUPYTER_VERSION"]
    self.assertEqual(expected, actual)

  def test_torch_summary_version(self):
    """test torch summary version
    """

    actual = search_pkg_version("torchsummary")
    expected = os.environ["TORCH_SUMMARY_VERSION"]
    self.assertEqual(expected, actual)

  def test_tf_gpu(self):
    """test tensorflow gpu version
    """

    tf_type = os.environ["TF_TYPE"]
    actual = search_pkg_version(tf_type + "-gpu")
    expected = os.environ["TF_GPU_VERSION"]
    self.assertEqual(expected, actual)

  def test_keras(self):
    """test keras version
    """
    change_name_version = "2.6.0"

    expected = os.environ["KERAS_VERSION"]
    actual = search_pkg_version("keras" if LooseVersion(expected) >= LooseVersion(change_name_version) else "Keras")
    self.assertEqual(expected, actual)

  def test_cupy_cuda_version(self):
    """test cupy cuda version
    """

    # how to test cupy-cuda for old cuda drivers
    # if os.environ["CONTAINER_VERSION"] == "cuda11.3.0-cudnn8" or os.environ["CONTAINER_VERSION"] == "cuda11.3.1-cudnn8":
    #   actual = search_pkg_version("cupy-cuda112")
    # else:
    #   actual = search_pkg_version("cupy-cuda"+os.environ["CUDA_VERSION_FOR_CUPY"])

    actual = search_pkg_version("cupy-cuda"+os.environ["CUDA_VERSION_FOR_CUPY"])
    expected = os.environ["CUPY_CUDA_VERSION"]
    self.assertEqual(expected, actual)

  def test_opencv_minor_ver(self):
    """test opencv version
    """

    actual = search_pkg_version("opencv-python")
    expected = os.environ["OPENCV_VERSION"]
    self.assertEqual(expected, actual)


def search_pkg_version(target_pkg_name):
  pkg_list = get_pkg_list()

  for pkg in pkg_list:

    if "==" in pkg:
      pkg_name = pkg.split("==")[0]
      pkg_version = pkg.split("==")[1]

      if target_pkg_name == pkg_name:
        return pkg_version
    else:
      continue

def get_pkg_list():
  cmd = shlex.split("pip freeze")
  return subprocess.run(cmd, stdout=subprocess.PIPE).stdout.decode("utf-8").splitlines()

if __name__ == "__main__":
  unittest.main()