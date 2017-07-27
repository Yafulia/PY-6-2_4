import os


migrations = 'Migrations'
current_dir = os.path.dirname(os.path.abspath(__file__))


def def_files_with_string(files):
	sql_files_true = []
	
	for sql_file in files:
		with open(os.path.join(*[current_dir, migrations], sql_file)) as f:
			for line in f:
				if s in line:
					sql_files_true.append(sql_file)
					break
			else:
				files.remove(sql_file)
	return sql_files_true


if __name__ == '__main__':
	all_files = os.listdir(os.path.join(current_dir, migrations))
	sql_files = [file for file in all_files if file.split('.')[-1] == 'sql']
	
	while True:
		print('Введите строку:', end=' ')
		s = input()
		
		files_to_print = def_files_with_string(sql_files)
					
		for file_to_print in files_to_print:
			print(file_to_print)
			
		print('Всего:', len(files_to_print))