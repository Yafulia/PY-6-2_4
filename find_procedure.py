import os


migrations = 'Migrations'
current_dir = os.path.dirname(os.path.abspath(__file__))


def files_with_string(files):
	s = input('Введите строку: ')
	
	sql_files_true = []
	for sql_file in files:
		with open(os.path.join(current_dir, migrations, sql_file)) as f:
			if f.read().find(s) != -1:
				sql_files_true.append(sql_file)
				
	return sql_files_true


if __name__ == '__main__':
	sql_files = [file for file in os.listdir(os.path.join(current_dir, migrations))
		if os.path.splitext(file)[1] == '.sql']
	
	while True:
		sql_files = files_with_string(sql_files)
		for sql_file in sql_files:
			print(sql_file)
			
		print('Всего:', len(sql_files))