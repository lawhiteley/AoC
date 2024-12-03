import kotlin.math.abs

object Day2 : Day<Int>() {
    override val number = "002"

    override fun partOne(input: List<String>): Int = toReports(input).count { it.levelsAreOrdered() && it.levelsAreSafe() }

    override fun partTwo(input: List<String>): Int =
        toReports(input).count { report ->
            report.dampenedReports().any { it.levelsAreSafe() && it.levelsAreOrdered() }
        }

    private fun List<Int>.levelsAreOrdered() = this == this.sorted() || this == sortedDescending()

    private fun List<Int>.dampenedReports() = this.indices.map { index -> this.filterIndexed { i, _ -> i != index } }

    private fun List<Int>.levelsAreSafe() = this.zipWithNext().map { abs(it.second - it.first) }.all { it in 1..3 }

    private fun toReports(lines: List<String>) =
        lines.map { line ->
            line.split(" ").map { Integer.parseInt(it) }
        }
}
