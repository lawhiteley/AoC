object Day4 : Day<Int>() {
    override val number = "004"

    override fun partOne(input: List<String>): Int {

        val horizontal = input.sumOf { it.occurrencesOf("XMAS") }
        val vertical = input.columns().sumOf { it.occurrencesOf("XMAS") }
        val diagonals = input.diagonals().sumOf { it.occurrencesOf("XMAS") }

        return horizontal + vertical + diagonals
    }

    override fun partTwo(input: List<String>): Int {
        // TODO: fix
        val trbl = input.topRightBottomLeft().flatMap { line ->
            val chars = line.map { it.second }.joinToString("")
            chars.centres().map { line.toList()[it] }
        }.toSet()

        val tlbr = input.topLeftBottomRight().flatMap { line ->
            val chars = line.map { it.second }.joinToString("")
            chars.centres().map { line.toList()[it] }
        }.toSet()

        return tlbr.intersect(trbl).size
    }

    private fun String.centres(pattern: String = "MAS|SAM") = generateSequence(pattern.toRegex().find(this)) {
        pattern.toRegex().find(this, it.range.first + 1)
    }.map { it.range.first + 1 }.toList()

    private fun List<String>.diagonals() = (topLeftBottomRight() + topRightBottomLeft())
        .map { it.map { pair -> pair.second }.joinToString("") }

    private fun List<String>.topLeftBottomRight() = this.indices.map {
        getDiagonal(it, 0, 1, 1)
    } + (1..<this.size).map {
        getDiagonal(0, it, 1, 1)
    }

    private fun List<String>.topRightBottomLeft() = this.indices.map {
        getDiagonal(it, this.size - 1, 1, -1)
    } + (0..<this.size - 1).map {
        getDiagonal(0, it, 1, -1)
    }

    private fun List<String>.getDiagonal(currentRow: Int, currentColumn: Int, nextRow: Int, nextColumn: Int) =
        generateSequence(currentRow to currentColumn) { (row, col) ->
            val nextR = row + nextRow
            val nextC = col + nextColumn
            if (nextR in this.indices && nextC in this[0].indices) nextR to nextC else null
        }.map { (row, col) -> Pair(col, row) to this[row][col] } // Off by one?

    private fun List<String>.columns() = this[0].indices.map { colIndex -> String(this.map { row -> row[colIndex] }.toCharArray()) }

    private fun String.occurrencesOf(other: String) = (this.splitToSequence(other).count() + this.reversed().splitToSequence(other).count()) - 2
}
