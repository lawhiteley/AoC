import Util.readResource
import io.kotest.core.spec.style.StringSpec
import io.kotest.matchers.shouldBe

class Day2Test : StringSpec({

    val example = readResource("002-example-1.txt")
    val data = readResource("002.txt")

    "example 1" {
        Day2.countSafeReports(example) shouldBe 2
    }

    "puzzle 1" {
        Day2.countSafeReports(data) shouldBe 341
    }

    "example 2" {
        Day2.countSafeReportsWithDampener(example) shouldBe 4
    }

    "puzzle 2" {
        Day2.countSafeReportsWithDampener(data) shouldBe 404
    }
})
