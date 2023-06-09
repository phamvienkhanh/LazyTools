import QtQuick
import QtTest

import LazyTools

TestCase {
    name: "TestTools"

    Rectangle {
        width: 100
        height: 100
        color: "red"
    }

    function initTestCase() {

    }    

    function test_delay_call() {
        let checkCallback = false
        LazyTools.delayCall(100, function () {
            checkCallback = true
        })

        wait(200)

        verify(checkCallback, "test delay call")
    }

    function cleanupTestCase() {
        wait(2000)
    }
}
