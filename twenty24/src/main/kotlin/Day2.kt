import kotlin.math.abs

object Day2 {
    fun countSafeReports(lines: List<String>) = toReports(lines).count { it.levelsAreOrdered() && it.levelsAreSafe() }

    fun countSafeReportsWithDampener(lines: List<String>) =
        toReports(lines).count { report ->
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
