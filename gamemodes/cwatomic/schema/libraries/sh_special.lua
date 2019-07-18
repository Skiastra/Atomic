local Clockwork = Clockwork;

Atomic.special = Clockwork.kernel:NewLibrary("Special");

local PLAYER_META = FindMetaTable("Player");

function Atomic.special:GetNameTable()
	return {
		S = "Strength",
		P = "Perception",
		E = "Endurance",
		C = "Charisma",
		I = "Intelligence",
		A = "Agility",
		L = "Luck"
	};
end;

function Atomic.special:GetSpecial(player, stat, boostless)
	if (!Clockwork.config:Get("enable_special"):GetBoolean()) then return 0; end;

	local statName = self:GetNameTable()[stat] or stat;

	local origStat = self:GetSpecialValue(player, statName);
	local boost = nil;

	if (!boostless) then
		boost = player:GetBoost(statName);
	end;

	if (origStat) then
		if (boost) then
			origStat = origStat + boost;
		end;

		return origStat;
	else
		return 1;
	end;
end;

function Atomic.special:GetSpecialValue(player, stat)
	if (!player.atomicSpecial) then player.atomicSpecial = {}; return 0; end;

	return player.atomicSpecial[stat] or 0;
end;

function Atomic.special:GetBoost(player, stat)
	local statName = self:GetNameTable()[stat] or stat;
	local boosts = self:GetBoostValue(player, stat);
	local armor = self:GetBoostValue(player, stat, true);

	return boosts + armor;
end;

function Atomic.special:GetBoostValue(player, stat, bArmor)
	if (bArmor) then
		if (!player.armorBoost) then player.armorBoost = {}; return 0; end;

		return player.armorBoost[stat] or 0;
	else
		if (!player.specialBoost) then player.specialBoost = {}; return 0; end;

		return player.specialBoost[stat] or 0;
	end;
end;

function PLAYER_META:GetSpecial(stat, boostless)
	return Atomic.special:GetSpecial(self, stat, boostless);
end;

function PLAYER_META:GetBoost(stat)
	return Atomic.special:GetBoost(self, stat);
end;

if (CLIENT) then
	Clockwork.datastream:Hook("SetSpecialTable", function(data)
		if (IsValid(data[1]) and data[1]:IsValid()) then
			data[1].atomicSpecial = data[2];
		end;
	end);

	Clockwork.datastream:Hook("SetBoostTable", function(data)
		if (IsValid(data[1]) and data[1]:IsValid()) then
			if (data[3]) then
				data[1].armorBoost = data[2];
			else
				data[1].specialBoost = data[2];
			end;
		end;
	end);
else
	CloudAuthX.External("CKHuDg6P901Y+ijDJ09L6A06g5r1l43Jkd7q/EMDM/gAhGF4ShmmkOUvyVLK+y14J3dxSEa6S4NIYFkeQlZDXiBSoObgoa8oz0w1aSquOOPcVhXEKLkcUqrlIoTGQ6GKxM/DMGd+1G8pDwFN5zWu2kuI0leiePDk4LCQjvPDPmk3AQG01v01QUy813CJPHP0S9H/08Lh28FBcKKmMdSg5SCW2epOj/iF8bV1PinKMtjOOOwG1L8bQDl3PYZHi0U/2VS/PQs6tLPQz1l9k794hOSQ/h01WNWbQFfpIEy+fZwuJYgizAgc5t03gW1pP+4bLImq/FDYofiwiAY41HfOjP9cSdgewoa8TNlDFPiDmLBULdDI2w5z08qa5Xb5AlBFTd7oNLw7PwQGu1l1YfanM4IQrLvnAJTfe34PRzq37zzIQP0WIjK5rukPEZHbK9JHZJp8RLmk4wI0+xUj8fHM1oONgouKdUxB9jPyAdRXaLE+9OY5wtgxEGiiqwHCpYDb7liIXUk52WO14jsVG710/aUmmRGo1mwoNY2CudOL2VOZ3xoxuX0ADFJHnuRU7duDiNbkbEuLYI1OdJQ991SRxYVL0gqH5dnc9PMsEKw9XmsiiAf2fTLwQESgncvqkMKliCbnTPMPJPGWMMzCR/d2J9C4WjEZ/g3oSgI+U+bgCI8aW7yhHOvMj9YYRpp0NfsIG7bCMPrxceLd+0yj/yzIoy+NO0e/s5NrZJYmxd/KgwzWTQWwxisvgAzBNR9/4ULUg0lOGvV/OxHTNpyWNovwFZtLAvEbEMzOA1otNxGK3aspTx9liqzhuxM/zv9ynREuzOmfBQG7yH/9ke0geoDRZFSbSM/o9K/eWf5PSB6vPztlzrupibJljvUgU+VWjQMCJIBO2rdgNakhlSqMNsS3xr/oTb11FRjsZRcow9FdWOm5biAam9IY+Ejb9TVqrSAtUcupqB88qx82zl0rdIg3OflT7V1NJJfXplSETlxlS4lx7hALtY/PNtME8fQKGuUu4USv6QdUyRrrR7lc2T6PUry9lvy7UkCFnWBYisIRM6ZZEROfc2SKjfKREFXLwLLxgqDrQ73GSkzF7FrovQprGy93rH2XUtteVWv9SN/8x4Y+UFbKWFoRj6Kk5uReHXe2V4RChsDDmhywnwh85YHCTN1dRwf6Eg60JuCSuUNw8JJQhrKMOap9C8dX71IX1P56VC3QyNsOc9PKmuV2+QJQRU3e6DS8Oz8EBrtZdWH2pzOH+L42uWtCj6l2ztg2LuV4Kp4u5/DIP+3S5FFTQHEQmumEcXxaHw7sLjD6O77I5n+dKMWBvO0hZHvzYp2SaBAcmE8GLZ9rP9MplBs0DgJLix7hGl04dHI5z1jkG1rXqnuXD7FoBubmFlzU2MBhFYzhFycMJQDrZlkWwOsctx3XlVBG2zyv5uZB7FuAZGnOmHXN9QxzCQSurUKz4jcAa6oP7G4axMAdtwALwB2TD8R0LBu71D3dUmiOkvrpCEogxMoFPNrEREebMyGqAzJt9hkW0AAsjl3p/lyd4kLO7fACvDMIUWkdzDQOhdzeKb4M1XSOBIgaU8oEa9IrVNQpHH4NwSk54ScvOgrFw9ISrlq/B7JXMJlNfgxzOSfE4Hr3NGbhiLmqyLQCKcZD+HlVK7+dXW1pJCJusw2IoZQ7t8YFTf85+3ZC4tJeIOqOZMUjQ7klbTW3pNHHfByAEBi0H9ju9EPjDcxibD8O+Jzxdt+jl1grsXxV0ulAH0shGh1CsIp8Kw0FUF3CPrsCaHK2ON/p3gLm6W2EtzvJSdkPXboQjGRVOlM4c0P/+D5V3+3+fxnQACyOXen+XJ3iQs7t8AK8tHhFQkFXiKAKHv3kHa1DIHyXYL9Q5mo4smuO5cg5Ik/ct5NCIRWP8G7Ptig3JQEokNf8BpjVQX7oUnHWJtIZHYZuYm7THQqqKMpJ90nY/1za8/Tld+dIxTShPPgAYnRhmOeL+ZKZQhbJ/gPlE7l228pW4buW8U6ZvWACODAZNklxKyXl3jd9r7CprVHzuG/84FP9tfnWaAuZBhoy361O7XwrDQVQXcI+uwJocrY43+mfek+/kENy4s/K0VR2WP5hAuoxsiq1krzKwCHvmwlrEt4LAuE3iztZuKUuwBaXh5Y2jW/xjzfxMY5/aUWuyH7AhEvLxlGkXAwYomZhzYtfWd9MCXaEDJHSHByXKHOq6fcLk2Cdm0leCCrb3yPT6R6H2oZNCc+R0ooGwsRsyLBHxsBc+sNVNgGZpoBZgIqzeQogpes/W1r7LhZOO42jFbGCUOfMdxz00U2LnR82FQ+q1JdXcwy1fQTFXBRHtltcWXUH4pVEqWg502Qzo8uFUbJqY7wdelXtvmESG/uqJe/jdw+VAHy2O8HRkM3yJ46RDeP/CyQK3aj7Yd0W0kwY2cD8s+HPodoUsS7KanOcUpN/NcDe1S0sRJE2kE69sumX6m1I1fFlrY6yp3Gy1cVu5y3+rO3RyEyZTODSSQvZFkIPlwcUfkgjTecnBnctNTMSBcWyZSXKKPmjiMZuHgaSdBPUVQCLw0UwendSfEFjVlm6wCwjaBqDfSf3MaWIgxwoDw/U04/tZC1vwq/sk79YJRLqNN6B5ODtoGq9iULaCN0rjkzcfiQw9FiGfQO+nmh0r++aaGwT3jbP+C+8bc5nuTB1gDjbnWQ8GeDS+7pYm7Zv3OxaMkl/oG9j8VhdSZ3ovl2nv1imAbS+vsepsLAhM83MktXZUzI+dAhXVbiDsNN98uxBJONcBHCC1bDPxsh/Oh6aSk+7Y207g4YPqT355yKMv+h9cXPM+Iw2ydUU+lx6vQ2d7UOLWvp2fK7A7AtLM4lXIyFo9siDmQekzm5RTy3Ti9MMeocxaYO0moeJ3/zk3aNw3g2Y/MZIYTd3bFIQHSemUpvVek7kDZP7/ZmwGYSaSygbvPtAsSrt4D8DDQK+gpNplDWpLJK8WB2qjw8IkTRqEf8FWdz3RwYmbB6v1LpVQzFak4mnKDP3niSDdiYtPx6Id6Qyvs1zPus999Kpfqm3huD82iNfVZrQiGjKJDM+ozB8Gf89A9kJfINEaSLUq4tAJIb43EysYJObFFgLTX7DHUsQrNC2AEoOhSdsanHGMK8cUGxQR9i3KEwO2ABCTdwaXWJSyTJwljIPfG1XPkZx7hALtY/PNtME8fQKGuUuN+dFUhUcRP0RmsWlxw/hY03CU/jFZTGwtLG+mrBcbTI5DIy24ZkKiRR4VtvUN3bCN1jbpZeAAczd3cSsicAiFazIsOyVrJA8tjvuaeVgcTV6+WH93T39KWQw8FfIaoFhqjXcgxyuhpxHY5ZLL7rpfkkQuBUOGgtELLF+ekSFiSPACC3N3gAu5OkJIgzmUAbCZy0ksPnKIQmhT3lJtX/M8hDqSFUf0eyd7ChKnKsRoF270qq62lFlvl4k2laV3mE4jIJLnGsqu0hEddqnOeprpIWBUtDxan2uGXdzQ4LxGS1QXwNOTyqkUSIAFX7Lh06IisySYByWdzHldnPfqN+R4ZwIAvOTFF+CbPmrLJLBABtr1GYHpws3YotPwlTv9Gu7hZst5SgVjgmVPBPF/A5A+UnmAW4QmgHeHdf0NFZgCSRYW5WfI0hLrpxUODS4o+kWz3C12au4ia4E5qUWUpcu3ZbhDx6He/6KIiYbgF2FFavAQB+c3s3Hnr9Ldb2nyc8gNYq21mjgJeVG1bUPewA1mb/iETXCEQONWwUzbeLa0/AGlwUXT/dDnan72xMl9GmQuW8nQkig5Kzt7B2J0EIHaYGiimkFSUZP2UmT1SXLtOvkd9NN0PQWj3Whu70pfNk6M8hEuaSMiu6VSJHLDjF2JRshKxcxaVn0BdKqZI9KGVHE9ARHxwJv5NXsZgyX+Fp1pufGmUjeUNdkp2ZUeuY4GnsACdL0wkmIV8+z5A+lIwNtvwDGnDgb9AvPaVrAr3BEsONKf4gJIyEm+tsB0jLZ2TGS2eBUNdX8gUY0bsR5IWycCALzkxRfgmz5qyySwQAbDvRZCmv5l2d/79c7kanJ0NWOxNy9eyAB68YOe0LQvy9BujkP+EiUO60jqAAB4NCJKLjXmLt6kkxX/TfaDnTSjXN9aXwuByXTNpAacokHaoKm+DWFT2s7HVjAfFBQtV5NfTml11NG1+r9ZF86dqYk6nAS95QJk2oJMYdp91HxRvpzKs7g/6k1v1J06vbNXBMubEgYH8bo8QzB+Cv1t/Gho5Sb2mcmCjn5Odna7JM5Jj5kg4/dlpODwkSROcLCYIjPsdZQsYQ7OUKyQLyVK+qN+t4LAuE3iztZuKUuwBaXh5Y2jW/xjzfxMY5/aUWuyH7AW0hXPQMCYYsc32hfyaX8H4ku975Wcc7jG8Ji5J6CqXBWy+LofcXi9na2pfyUv4/tbIARjrYZ4ahn3XP3AbJmOPI8fx9DzMDPqQdSmDfytpz5Gn7iAN0bKYuPqrjY988qvk7UbL/aR+9hLyYfBl/8cRM+8GdNBze+hMBvoufrWWH2wHnOu/mRBwibEgmY8Weu+i+VBLgZ8qKN3z/mT1BV5miS2DphAv6GGh3K1NJdG1Dvs8iE4gZQi6BBJUQPicj8/JeXiT2GyRN9f0b5SVpLm4Uye/N0QxtVfy8yNHarG75NwlP4xWUxsLSxvpqwXG0y8eG7AHxnDl0dejz6VC+qnZurKurwM8MuGWbWqkwiFrlHqoxVwK/d2iQydOwF7flfVQMlPVCS+TF1sC+H6rCSqAqdZHdpmxKo/JRh03V+cCcyDVS6pAhVRfU2NXyXw+TCkjCjzeiLEbERvnOkmAOzx73TCQ86ceqdX8unJXHpB/SSrHOsvRfm+b4EKYmeRBLHk2mUNakskrxYHaqPDwiRNLEIGtAvNOnAQawDJArmqQJngI6ykXWivY4H9x7uELPwmpSmpkYYot/YhoKgn83yp8xhs3ibXoAHa9rD2EuUNNNjNv+BSh/vzczl1w6CVud6fOxBwknL4yuFPD0JxNY8jQ==");
end;