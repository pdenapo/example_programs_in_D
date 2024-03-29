import std.stdio;

ulong print_primes(ulong limit)
{
  ulong p=2;
  ulong count =1;
  ulong[] primes;      
 
  writeln(p, " is prime");
  primes ~= p;

  while (p< limit)
  {
   p++;
   foreach(q;primes)
   {
        if (q*q>p)
        {
            writeln(p, " is prime");
            primes ~= p;
            count ++;
            break;   
         }
    
        if (p%q==0)
        {
       // if we find a divisor, p is not prime 
       break;
        }
    }
  }

  return count;
}

void main() {
  auto count = print_primes(100);
  write("We have found ",count," primes.");
}