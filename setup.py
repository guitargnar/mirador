from setuptools import setup, find_packages

setup(
    name="ai_framework",
    version="0.1.0",
    packages=find_packages("src"),
    package_dir={"": "src"},
    install_requires=[
        # (you can mirror requirements.txt here)
    ],
    entry_points={
        "console_scripts": {
            "ai_framework=ai_framework.framework:main",
        },
    },
)
