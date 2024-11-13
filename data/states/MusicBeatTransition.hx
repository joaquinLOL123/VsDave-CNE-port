//
function create() {
    var out = newState != null;

    transitionTween.cancel();
    if (FlxG.save.data.transDither)
        transitionCamera.addShader(new CustomShader("DitherShader"));
    //shader lags the everliving shit out of the game, oh well.

    blackSpr.setPosition(out ? -transitionCamera.width : transitionCamera.width * 2, 0);
    transitionSprite.scale.x *= 2;
    transitionSprite.flipX = !out;
    transitionSprite.updateHitbox();
    
    

    transitionCamera.scroll.x = transitionCamera.width * 2;
    transitionCamera.scroll.y = 0;
    FlxTween.tween(transitionCamera.scroll, {x: -transitionCamera.width}, out ? 0.7 : 1, {
        onComplete: function(_) {
            finish();
        }
    });
}
