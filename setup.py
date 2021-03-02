from distutils.core import setup

setup(
    name='mortgage_imports',
    version='1.0',
    packages=['mortgage_imports'],
    url='',
    install_requires=['clickhouse-driver', 'numpy', 'pandas', 'setuptools_scm'],
    package_data={'mortgage_imports': ['sql/*']},
    use_scm_version=True,
    license='MIT',
    author='Will Alexander',
    author_email='will@InvertedV.com',
    description='Import mortgage data into clickhouse'
)
