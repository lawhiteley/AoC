abstract class Day<T> {
    abstract val number: String

    abstract fun partOne(input: List<String>): T

    abstract fun partTwo(input: List<String>): T
}
