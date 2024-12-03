
object Day3 : Day<Int>() {
    override val number = "003"

    private val multiplyFunctionPattern = "mul\\((\\d+),(\\d+)\\)".toRegex()
    private val patternWithStartStop = "$multiplyFunctionPattern|(do\\(\\))|(don't\\(\\))".toRegex()

    override fun partOne(input: List<String>): Int =
        multiplyFunctionPattern.findAll(input.joinToString { it }).map {
            executeMultiplication(it.value)
        }.sum()

    override fun partTwo(input: List<String>) = patternWithStartStop.findAll(input.joinToString { it })
        .fold(Pair(false, mutableListOf<String>())) { (stopped, validCalls), item ->
            with(item.value) {
                when {
                    this == "don't()" -> true to validCalls
                    this == "do()" -> false to validCalls
                    !stopped -> false to validCalls.apply { add(this@with) }
                    else -> stopped to validCalls
                }
            }
        }.second.sumOf { executeMultiplication(it) }

    private fun executeMultiplication(functionCall: String): Int {
        val match = multiplyFunctionPattern.find(functionCall)
        val (_, a, b) = match?.groupValues!!

        return a.toInt() * b.toInt()
    }
}
