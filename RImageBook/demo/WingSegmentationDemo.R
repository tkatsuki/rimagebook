x <- readImage(system.file("images/wildwg.png", package="RImageBook"))
x <- 1-x                       # �摜�̔��]
mask <- thresh(x, 5, 5, 0.03) # 臒l������2�l��
mask <- bwlabel(mask)          # ���x����
mm <- cmoments(mask, x)        # �I�u�W�F�N�g�̃��[�����g�����߂�
ll <- which(mm[,'m.pxs']<=500) # �ʐς�500�s�N�Z���ȉ��̃��x����I��
mask <- rmObjects(mask, ll)    # ��L�̃I�u�W�F�N�g������
mask <- mask > 0               # �ēx2�l��
mask <- closing(mask, makeBrush(5, shape="diamond")) # �����ӂ���
display(mask)
ske <- thinning(mask)       # �א���
display(ske)
display(normalize(x + ske)) # ���摜�ƍא�����̉摜���d�ˍ��킹�ă`�F�b�N
prunedske <- pruning(ske)   # �א�����Ђ��̏������s��
display(prunedske)
branch <- branch(prunedske)                 # ����_�̌��o
display(normalize(branch + prunedske))
branchpos <- which(branch==1, arr.ind=TRUE) # ����_�̍��W�𒊏o
                                            # ���ʂ�row�ō~���Ƀ\�[�g�����8�𓾂�
rescoord <- branchpos[order(branchpos[,'row'], decreasing = TRUE),][1:8,]
bg <- ske*0                                 # �w�i�摜�����
bg[rescoord] <- 1                           # ���o��������_�̍��W��1�ɂ���
                                            # ���₷�����邽�߂ɓ_��c��������
bg <- dilate(bg, makeBrush(5, shape="diamond"))
display(normalize(bg + x))                  # ����_�ƌ��摜���d�˂ĕ\��
# �א��𔽓]���ă��x�������邱�Ƃɂ�����̗̈扻���s��
wingarea <- normalize(bwlabel(1-ske)) 
display(wingarea)