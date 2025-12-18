function para calcular a o level baseado na experience que o individuo tem

```
func level(experience: int): 
	var BASE_LEVEL_XP = 100.0
	return floor(max(1.0, sqrt(experience / BASE_LEVEL_XP) + 0.5))
```
