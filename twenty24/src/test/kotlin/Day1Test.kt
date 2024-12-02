import Util.readResource
import io.kotest.core.spec.style.StringSpec
import io.kotest.matchers.shouldBe

class Day1Test : StringSpec({

    val example = readResource("001-example-1.txt")
    val data = readResource("001.txt")

    "example 1" {
        Day1.calculateDistances(example) shouldBe 11
    }

    "puzzle 1" {
        Day1.calculateDistances(data) shouldBe 1938424
    }

    "example 2" {
        Day1.calculateSimilarities(example) shouldBe 31
    }

    "puzzle 2" {
        Day1.calculateSimilarities(data) shouldBe 22014209
    }
})
