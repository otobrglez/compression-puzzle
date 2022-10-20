import timeit

from compress_brodul import compress as compress_brodul
from compress_luka_faster import compress as compress_luka_faster
from compress_luka import compress as compress_luka
from compress_ob import compress as compress_ob
from compress_urban import compress_iterative, compress_recursive
from compression_romunov import compress_romunov
from compress_teo import compress_teo

number_of_executions = 10_000

print(
    "Brodul",
    timeit.timeit(
        "compress_brodul('AAABBAAC')", number=number_of_executions, globals=globals()
    ),
)
print(
    "Luka faster",
    timeit.timeit(
        "compress_luka_faster('AAABBAAC')",
        number=number_of_executions,
        globals=globals(),
    ),
)
print(
    "Luka",
    timeit.timeit(
        "compress_luka('AAABBAAC')", number=number_of_executions, globals=globals()
    ),
)
print(
    "Oto",
    timeit.timeit(
        "compress_ob('AAABBAAC')", number=number_of_executions, globals=globals()
    ),
)
print(
    "Urban, iterative",
    timeit.timeit(
        "compress_iterative('AAABBAAC')", number=number_of_executions, globals=globals()
    ),
)
print(
    "Urban, recursion",
    timeit.timeit(
        "compress_recursive('AAABBAAC')", number=number_of_executions, globals=globals()
    ),
)
print(
    "romunov, babysteps",
    timeit.timeit(
        'compress_romunov("AAABBAAC")', number=number_of_executions, globals=globals()
    )
)
print(
    "Teo, babysteps",
    timeit.timeit(
        'compress_teo("AAABBAAC")', number=number_of_executions, globals=globals()
    )
)
