import Util.readResource
import io.kotest.core.spec.style.FunSpec
import io.kotest.datatest.withData
import io.kotest.matchers.shouldBe

class Solutions : FunSpec({
    context("2024 Advent of Code") {
        withData(
            listOf(
//                Day1 to Answers(11, 1938424, 31, 22014209),
//                Day2 to Answers(2, 341, 4, 404),
                Day3 to Answers(2, 341, 4, 404),
            ),
        ) { (day, answers) ->
            this@context.context("Solutions for day ${day.number}") {
                val example = readResource("${day.number}-input.txt")
                val input = readResource("${day.number}-example.txt")

                test("example 1") {
                    day.partOne(example) shouldBe answers.firstExample
                }

                test("puzzle 1") {
                    day.partOne(input) shouldBe answers.secondExample
                }

                test("example 2") {
                    day.partTwo(example) shouldBe answers.firstPuzzle
                }

                test("puzzle 2") {
                    day.partTwo(input) shouldBe answers.secondPuzzle
                }
            }
        }
    }
})

data class Answers(
    val firstExample: Int,
    val secondExample: Int,
    val firstPuzzle: Int,
    val secondPuzzle: Int,
)