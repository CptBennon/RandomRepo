//       |\
//       | \
//       |  \
//       |   \
//     A |    \ C
//       |     \
//       |      \
//       |_ _ _ _\
//          B
//
using System;

namespace EmploymentLibrary
{
    /// <summary>
    /// Self-explanatory class name
    /// </summary>
    public class TriangleAreaCalculator
    {
        /// <summary>
        /// Self-explanatory method name
        /// </summary>
        /// <param name="a">side a</param>
        /// <param name="b">side b</param>
        /// <param name="c"> side c</param>
        /// <returns>Area of given triangle</returns>
        public double GetTriangleArea(double a, double b, double c)
        {
            if (a < 0d || b < 0d || c < 0d)
            {
                throw new ArgumentOutOfRangeException("One of arguments has negative length value");
            }

            if (Math.Pow(c, 2) != Math.Pow(a, 2) + Math.Pow(b, 2))
            {
                throw new ArgumentException($"Triangle is not right. Variable c doesn't corresponds the rule: c^2 = a^2 + b^2; a={a}, b={a}, c={c}");
            }

            return (a * b) / 2;
        }

    }
}
