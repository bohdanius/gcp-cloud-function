import setuptools
import unittest

with open("README.md", "r") as fh:
    long_description = fh.read()

def fn_test_suite():
    test_loader = unittest.TestLoader()
    test_suite = test_loader.discover('.', pattern='*_test.py')
    return test_suite

setuptools.setup(
    name="cloud-function",
    version="0.0.1",
    author="Bohdan Andrusevych",
    author_email="Bohdan.Andrusevych@equifax.com.com",
    description="GCP Cloud Function",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/bohdanius/gcp-cloud-function",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.9',
    test_suite='setup.fn_test_suite',
)