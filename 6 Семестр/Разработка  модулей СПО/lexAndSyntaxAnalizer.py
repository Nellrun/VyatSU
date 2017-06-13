import sys

class Lexer:
	LPAR, RPAR, NOT, DOT, COMMA, OR, ID, EOF = range(8)

	SYMBOLS = { "(" : LPAR, ")" : RPAR, "," : COMMA, "." : DOT, 
				"!" : NOT, "-" : NOT}
	WORDS = {"not" : NOT, "v" : OR, "or" : OR}

	ID_SYMBOLS = {"_", "-"}

	ch = " "
	ids = {}
	value = None
	sym = None
	line = 1
	column = 0

	def error(self, msg):
		print("Lexer error: ", msg, "at line", self.line, "column", self.column)
		exit(1)

	def getc(self):
		self.ch = sys.stdin.read(1)
		if self.ch == "\n":
			self.line += 1
			self.column = 0
		else:
			self.column += 1

	def nextTok(self):
		self.value = None
		self.sym = None

		while self.sym == None:
			if len(self.ch) == 0:
				self.sym = Lexer.EOF
			elif self.ch.isspace():
				self.getc()
			elif self.ch == "#":
				while self.ch != "\n" and len(self.ch) != 0:
					self.getc()
			elif self.ch in Lexer.SYMBOLS:
				self.sym = Lexer.SYMBOLS[self.ch]
				self.getc()
			elif self.ch.isalpha():
				ident = ""
				while self.ch.isalpha() or self.ch.isdigit() or self.ch in Lexer.ID_SYMBOLS:
					ident += self.ch
					self.getc()
				if ident in Lexer.WORDS:
					self.sym = Lexer.WORDS[ident]
				elif ident in self.ids:
					self.sym = Lexer.ID
					self.value = self.ids[ident]
				else:
					self.sym = Lexer.ID
					self.value = len(self.ids)
					self.ids[ident] = len(self.ids)
			else:
				self.error("unexpected symbol \"" + self.ch + "\"")

		# if self.sym != self.ID:
		# print(self.sym, self.value)
		# else:
			# print(self.sym, self.ids[])

class Node:
	kinds = { 0 : "FUNC",  1: "VAR",  2 : "CONST", 
	3 : "PREDICAT", 4 : "OR",  5 : "NOT", 
	6 : "EXPR", 7 : "PROG", 8 : "DOT"}

	def __init__(self, kind, value = None, ops = None):
		self.kind = kind
		self.value = value
		self.ops = ops

	def drawTree(self, depth = -1, pos = 7, l = None):
		if l == None:
			l = []
		if depth != 0:
			print("\t" * pos, self.kinds[self.kind], self.value)
			if self.ops == None:
				return
			for i, elem in enumerate(self.ops):
				# print("\t" * (pos - 1 + i), self.kinds[elem.kind], elem.value)
				elem.drawTree(depth - 1, pos - 1 + i)

class Syntaxer:

	FUNC, VAR, CONST, PREDICAT, OR, NOT, EXPR, PROG, DOT = range(9)

	"""docstring for Syntaxer"""
	def __init__(self, lexer):
		self.lexer = lexer

	def error(self, msg):
		print("Syntax error:", msg, "at line", self.lexer.line, "column", self.lexer.column)
		exit(1)

	def term(self):
		if self.lexer.sym == Lexer.ID:
			value = self.lexer.value
			self.lexer.nextTok()
			if (self.lexer.sym == Lexer.LPAR):
				return Node(self.FUNC, value, [self.parenExpr()])
			else:
				name = ""
				for key in self.lexer.ids.keys():
					if (self.lexer.ids[key] == value):
						name = key
						break
				if (name[0].isupper()):
					return Node(self.CONST, value)
				else:
					return Node(self.VAR, value)
		else:
			self.error("symbol expected")

	def parenExpr(self):
		if self.lexer.sym != Lexer.LPAR:
			self.error('"(" expected')
		self.lexer.nextTok()
		n = self.expr()
		if self.lexer.sym != Lexer.RPAR:
			self.error('")" expected')
		self.lexer.nextTok()
		return n

	def expr(self):
		ops = [self.term()]
		while self.lexer.sym == Lexer.COMMA:
			self.lexer.nextTok()
			ops.append(self.term())
		return Node(self.EXPR, ops = ops)

	def predicat(self):
		if self.lexer.sym == Lexer.ID:
			value = self.lexer.value
			self.lexer.nextTok()
			return Node(self.PREDICAT, value, [self.parenExpr()])
		elif self.lexer.sym == Lexer.NOT:
			self.lexer.nextTok()
			if self.lexer.sym == Lexer.ID:
				return Node(self.NOT, ops = [self.predicat()])
			else:
				self.error("predicat expected")
		else:
			self.error("unexpected symbol")

	def statement(self):
		n = self.predicat()
		if self.lexer.sym == Lexer.OR:
			self.lexer.nextTok()
			return Node(self.OR, ops = [n, self.statement()])
		elif self.lexer.sym == Lexer.DOT:
			self.lexer.nextTok()
			return n
		else:
			self.error('"." expected')

	def program(self):
		self.lexer.nextTok()
		ops = [self.statement()]
		while self.lexer.sym != Lexer.EOF:
			ops.append(self.statement())
		return Node(self.PROG, ops = ops)


s = Syntaxer(Lexer())
s.program().drawTree(-1)