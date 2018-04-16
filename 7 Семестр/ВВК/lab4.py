l0 = 0.2
alpha = [60, 40, 1]
q = [16000, 5, 1]
k = [1, 5000, 100000]
u_ = 20
s_ = 400000

l = list(map(lambda a : l0 * a, alpha))
v_min = []
v = []
s = []
s_min = 0

for i, qi in enumerate(q):
	print("V_min({}) =".format(i), qi * l[i])
	v_min.append(qi * l[i])

for i, data in enumerate(zip(k, v_min)):
	ki, vi_min = data
	s_min += ki * vi_min
	print("S_min({}) = {}".format(i, ki*vi_min))

print("S_min =", s_min)

for i in range(len(l)):
	vi = l[i]*q[i] + (1 / (l0 * u_)) * (l[i]*q[i]/k[i])**0.5 * sum((li*qi*ki)**0.5 for li, qi, ki in zip(l, q, k))
	print("V({}) = {}".format(i, vi))
	v.append(vi)

for i, elems in enumerate(zip(k, v)):
	ki, vi = elems
	si = ki*vi
	print("S({}) = {}".format(i, si))
	s.append(si)

print("S =", sum(s))
print("S0 =", sum(s) - s_min)

v_min = []
for i, qi in enumerate(q):
	print("V_min({}) =".format(i), qi * alpha[i] * l0)
	v_min.append(qi * l[i])

v = []
for i in range(len(l)):
	vi = l0 * alpha[i] * q[i] + (s_/k[i]) * (k[i]*alpha[i]*q[i])**0.5 / sum((ki * ai * qi)**0.5 for ki, ai, qi in zip(k, alpha, q))
	print("V({}) = {}".format(i, vi))
	v.append(vi)

s_min = 0
for i, data in enumerate(zip(k, v_min)):
	ki, vi_min = data
	s_min += ki * vi_min
	print("S_min({}) = {}".format(i, ki*vi_min))

print("S_min =", s_min)
print("S0 =", s_ - s_min)

u = 1 / (s_ - s_min) * sum((ki * ai * qi)**0.5 for ki, ai, qi in zip(k, alpha, q))**2
print("U = {}".format(u))