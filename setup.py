from distutils.core import setup

# see https://www.remarkablyrestrained.com/python-setuptools-manifest-in/
setup(
    name='mortgage_imports',
    version='1.0',
    packages=['mortgage_imports'],
    url='',
    install_requires=['clickhouse-driver', 'numpy', 'pandas', 'setuptools_scm', 'muti'],
    package_data={'mortgage_imports': ['sql/*']},
    include_package_data = True,
    use_scm_version=True,
    license='MIT',
    author='Will Alexander',
    author_email='will@InvertedV.com',
    description='Import mortgage data into clickhouse'
)
