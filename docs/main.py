import os

text_to_prepend = "[GO BACK TO START](https://github.com/USEkipa/gra-logiczna/blob/main/docs/index.md)\n"

files = [f for f in os.listdir() if f.endswith('.md')]

for root, dirs, files in os.walk('.'):
    for file_name in files:
        if file_name.endswith('.md'):
            print(file_name)
            file_path = os.path.join(root, file_name)
            with open(file_path, 'r+') as f:
                content = f.read()
                f.seek(0, 0)
                f.write(text_to_prepend + content)