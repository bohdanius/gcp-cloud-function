import shutil

def clean():
    try:
        # Remove the 'dist' directory containing distribution packages
        shutil.rmtree('dist')
    except FileNotFoundError:
        pass

    try:
        # Remove the '__pycache__' directory containing cached bytecode
        shutil.rmtree('__pycache__')
    except FileNotFoundError:
        pass

    # Add more cleanup actions as needed

if __name__ == "__main__":
    clean()
    print("Cleanup complete.")
