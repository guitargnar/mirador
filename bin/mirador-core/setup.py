from setuptools import setup, find_packages

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setup(
    name="mirador-core",
    version="2.0.0",
    author="User",
    author_email="contact@userscott.com",
    description="Unified core library for the Mirador AI ecosystem",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/your-username/mirador",
    packages=find_packages(),
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "Topic :: Software Development :: Libraries :: Python Modules",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
    ],
    python_requires=">=3.8",
    install_requires=[
        "rich>=13.7.0",
        "streamlit>=1.28.0",
        "flask>=2.3.0",
        "plotly>=5.18.0",
        "pandas>=2.0.0",
        "sqlite3-api>=2.0.0",
        "requests>=2.31.0",
        "chromadb>=0.4.0",
        "sentence-transformers>=2.2.0",
        "tiktoken>=0.5.0",
        "watchdog>=3.0.0",
    ],
    extras_require={
        "dev": [
            "pytest>=7.4.0",
            "pytest-cov>=4.1.0",
            "black>=23.0.0",
            "flake8>=6.0.0",
            "mypy>=1.5.0",
        ],
        "web": [
            "gradio>=3.50.0",
            "fastapi>=0.100.0",
            "uvicorn>=0.23.0",
        ]
    },
)