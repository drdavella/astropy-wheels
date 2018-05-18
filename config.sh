# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

# Get extra wheels from Rackspace container
MANYLINUX_URL=https://5cf40426d9f06eb7461d-6fe47d9331aba7cd62fc36c7196769e4.ssl.cf2.rackcdn.com

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    :
}

function pip_opts {
    # Extra options for pip
    if [ -n "$IS_OSX" ]; then
        local suffix=scipy_installers
    else
        local suffix=manylinux
    fi
    echo "--only-binary matplotlib --find-links https://nipy.bic.berkeley.edu/$suffix"
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    python -c "import sys; import astropy; sys.exit(astropy.test(remote_data='none'))"
}
