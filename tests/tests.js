exports.defineAutoTests = function () {
    describe('Appaloosa Plugin (window.Appaloosa)', function () {
        it("should exist", function () {
            expect(window.Appaloosa).toBeDefined();
        });

    });
};

exports.defineManualTests = function (contentEl, createActionButton) {
    // TODO : If manuals tests are needed
};