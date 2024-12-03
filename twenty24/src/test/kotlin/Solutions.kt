import Util.readResource
import io.kotest.core.spec.style.FunSpec
import io.kotest.datatest.withData
import io.kotest.matchers.shouldBe

class Solutions : FunSpec({
    context("2024 Advent of Code") {
        withData(
            listOf(
                Day1 to Answers(e1 = 11, e2 = 31, p1 = 1938424, p2 = 22014209),
                Day2 to Answers(e1 = 2, e2 = 4, p1 = 341, p2 = 404),
                Day3 to Answers(e1 = 161, e2 = 48, p1 = 183380722, p2 = 82733683),
            ),
        ) { (day, answers) ->
            this@context.context("Solutions for day ${day.number}") {
                val exampleOne = readResource("${day.number}-example-1.txt")
                val exampleTwo = readResource("${day.number}-example-2.txt")
                val input = readResource("${day.number}-input.txt")

                test("example 1") {
                    day.partOne(exampleOne) shouldBe answers.e1
                }

                test("puzzle 1") {
                    day.partOne(input) shouldBe answers.p1
                }

                test("example 2") {
                    day.partTwo(exampleTwo) shouldBe answers.e2
                }

                test("puzzle 2") {
                    day.partTwo(input) shouldBe answers.p2
                }
            }
        }
    }
})

data class Answers(
    val e1: Any,
    val e2: Any,
    val p1: Any,
    val p2: Any,
)
