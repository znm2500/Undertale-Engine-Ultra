l=Battle_MakeBone(320,320,20,0,0,0,0,0,0,0)
var ml=new Animator(ANIM_TWEEN.CUBIC,ANIM_EASE.OUT);
ml.SetKeyframe(l,"length",[0,10],[0.1,200],[0.5,100],[0.8,500],[0.6,40],[0.8,300])
ml.Play(200,,1,ANIMATOR_PLAY_DIREATION.ALTERNATE,infinity,30,1)
