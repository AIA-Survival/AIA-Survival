from genericpath import isfile
import json
import shutil
from pathlib import Path
from typing import Dict, List
from treelib import Tree, Node
import argparse

class Context:
	def __init__(self) -> None:
		parser = argparse.ArgumentParser()
		parser.add_argument('-d', '--dry', action='store_true')
		parser.add_argument('-s', '--src', default='src', type=str)
		parser.add_argument('-a', '--autogen', default='autoGen', type=str)
		self.args = parser.parse_args()

		self.isDry = self.args.dry
		self.srcDir = self.args.src
		self.autogenDir = self.args.autogen
	def get_args(self):
		return self.args

class TexCollector:
	def __init__(self, c: Context) -> None:
		self.context = c
		self.rootPath = Path(self.context.srcDir)
		self.autogenPath = Path(self.context.autogenDir)
		self.rootName = "AIA-Survival"

		if not self.rootPath.exists():
			raise Exception("rootPath {} not exist".format(self.context.srcDir))

		if not self.autogenPath.exists():
			self.autogenPath.mkdir()

		self.tree = Tree()
		self.tree.create_node(self.rootName, self.rootName)

	def collect(self):
		self._collect(self.rootPath, self.rootName)
		
	def _collect(self, path: Path, parent: str):
		for file in path.iterdir():
			fileName: str = file.name
			if file.is_file() and fileName.endswith('.tex'):
				n = Node(fileName, data=path / fileName)
				self.tree.add_node(n, parent)
			elif file.is_dir():
				n = Node(fileName, data=path / fileName)
				self.tree.add_node(n, parent)
				self._collect(file, n.identifier)
	
	def make_autoGen(self, autogenFile: Path, genPath: Path, files: List, subDirs: List):
		lines = []
		for f in files[:-1]:
			fPath = str(genPath / f)
			lines.append('\input{' + fPath + '}\n')
		for d in subDirs:
			dPath = str(genPath / d)
			lines.append('\input{' + dPath + '/' + str(d) + '_autoGen.tex}\n')
		for f in files[-1:]:
			fPath = str(genPath / f)
			lines.append('\input{' + fPath + '}\n')

		with open(autogenFile, encoding='utf8', mode='w') as fd:
			fd.writelines(lines)

	def traverse(self):
		if self.autogenPath.exists:
			shutil.rmtree(self.autogenPath)
		self._traverse(self.autogenPath, self.rootPath, self._to_dict())
	
	def sort(item: str):
		order = None
		if item == 'pre.tex':
			order = -1
		elif item == 'post.tex':
			order = float('inf')
		else:
			pieces = item.split('-')
			try:
				order = int(pieces[0])
			except:
				order = float('inf') / 2
		return order
	
	def make_pre_post(self, genPath: Path, files: List):
		if 'pre.tex' not in files:
			files.append('pre.tex')
			(genPath / 'pre.tex').touch(exist_ok=True)
		if 'post.tex' not in files:
			files.append('post.tex')
			(genPath / 'post.tex').touch(exist_ok=True)
	
	def _traverse(self, genPath: Path, srcPath: Path, tree: Dict):
		assert(len(tree.keys()) == 1)

		relPath = genPath.relative_to(self.autogenPath)
		treeName = list(tree.keys())[0]
		data = tree[treeName]

		subDirs = []
		files = []

		# check validity
		isLeave, hasDir = False, False
		for child in data.get('children', {}):
			assert(len(child.keys()) == 1)

			childName: str = list(child.keys())[0]
			child_data = child[childName]
			child_path: Path = child_data['data']

			if child_path.is_file() and not childName.endswith('pre.tex') and not childName.endswith('post.tex'):
				isLeave = True
			elif child_path.is_dir():
				hasDir = True
			
			if child_path.is_file():
				files.append(childName)
			elif child_path.is_dir():
				subDirs.append(childName)

		if isLeave and hasDir:
			raise Exception("Not a Valid src Dir")
		
		genPath.mkdir(exist_ok=True)
		autogenFile: Path = genPath / (treeName + '_autoGen.tex')
		autogenFile.touch(exist_ok=True)
		self.make_pre_post(genPath, files)
		
		subDirs.sort(key=TexCollector.sort)
		files.sort(key=TexCollector.sort)

		if isLeave:
			for child in data.get('children', {}):
				assert(len(child.keys()) == 1)

				childName: str = list(child.keys())[0]
				child_data = child[childName]
				child_path: Path = child_data['data']

				if child_path.is_file():
					shutil.copy(child_path, genPath / childName)
		else:
			for child in data.get('children', {}):
				assert(len(child.keys()) == 1)

				childName: str = list(child.keys())[0]
				child_data = child[childName]
				child_path: Path = child_data['data']

				if child_path.is_dir():
					self._traverse(genPath / childName, child_path, child)
				else:
					shutil.copy(child_path, genPath / childName)

		self.make_autoGen(autogenFile, genPath, files, subDirs)

	def __str__(self) -> str:
		return str(self.tree)
	
	def print_structure(self):
		self.tree.show(filter=lambda x: not x.data or x.data.is_dir())
	
	def _to_dict(self) -> Dict:
		return self.tree.to_dict(with_data=True)

def main():
	c = Context()
	tc = TexCollector(c)
	tc.collect()
	tc.print_structure()
	tc.traverse()

if __name__ == '__main__':
	main()# 