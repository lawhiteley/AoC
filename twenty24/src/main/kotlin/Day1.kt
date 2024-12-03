import kotlin.math.abs

object Day1 : Day<Int>() {
    override val number = "001"

    override fun partOne(input: List<String>): Int {
        val pairs = toPairs(input)

        val left = pairs.map { it.first() }.sorted()
        val right = pairs.map { it.last() }.sorted()

        return left.zip(right).sumOf { (a, b) -> abs(b - a) }
    }

    override fun partTwo(input: List<String>): Int {
        val pairs = toPairs(input)

        val frequencies = pairs.map { it.last() }.groupingBy { it }.eachCount()

        return pairs.map { it.first() }.sumOf { it * (frequencies[it] ?: 0) }
    }

    private fun toPairs(lines: List<String>) =
        lines.map { line ->
            line.split("   ").map { Integer.parseInt(it) }
        }
}
