using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using EmploymentLibrary;

namespace TriangleCalculator.Tests
{
    [TestClass]
    public class TriangleAreaCalculatorTests
    {
        [TestMethod]
        public void GetTriangleArea_3and4and5_6returned()
        {
            double a = 3d;
            double b = 4d;
            double c = 5d;
            double expected = 6d;

            var triangleCalc = new TriangleAreaCalculator();
            var actual = triangleCalc.GetTriangleArea(a, b, c);

            Assert.AreEqual(expected, actual);
        }

        [TestMethod]
        [ExpectedException(typeof(ArgumentException), AllowDerivedTypes = false)]
        public void GetTriangleArea_ArgumentThrown()
        {
            double a = 3d;
            double b = 5d;
            //
            double c = 42d;

            var triangleCalc = new TriangleAreaCalculator();
            var actual = triangleCalc.GetTriangleArea(a, b, c);
        }

        [TestMethod]
        [ExpectedException(typeof(ArgumentOutOfRangeException), AllowDerivedTypes = false)]
        public void GetTriangleArea_ArgumentOutOfRangeThrown()
        {
            double a = -3d;
            double b = 5d;
            double c = Math.Pow(Math.Pow(a, 2) + Math.Pow(b, 2), 0.5d);

            var triangleCalc = new TriangleAreaCalculator();
            var actual = triangleCalc.GetTriangleArea(a, b, c);
        }
    }
}
