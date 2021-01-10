import unittest
import cv2
import os
import torch
import torchvision

class TestVersionsByImport(unittest.TestCase):
  """test class to check some libraries by to import
  """

  def test_opencv(self):
    """test opencv version
    """

    ver_list = os.environ["OPENCV_VERSION"].split(".")
    expected_ver = ver_list[0] + "." + ver_list[1] + "." + ver_list[2]

    actual = cv2.__version__
    expected = expected_ver
    self.assertEqual(expected, actual)

  def test_torch(self):
    """test torch version
    """

    actual = torch.__version__
    expected = os.environ["TORCH_VERSION"]
    self.assertEqual(expected, actual)

  def test_torchvision_version(self):
    """test torch vision version
    """

    actual = torchvision.__version__
    expected = os.environ["TORCH_VISION_VERSION"]
    self.assertEqual(expected, actual)

if __name__ == "__main__":
  unittest.main()