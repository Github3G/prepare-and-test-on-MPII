load('res_offi.mat')
load('mpii_human_pose_v1_u12_1.mat')
predicted_keypoints = preds;
% pred = a.pred
% imgs_id = a.imgs_id

annolist_test = RELEASE.annolist(RELEASE.img_train == 0);
rectidxs = RELEASE.single_person(RELEASE.img_train == 0);
pred = annolist_test;

body_id = 1;
for imgidx = 1:length(annolist_test)
    rects = rectidxs(imgidx,1);
    ridx = rects{:,1};
    for num = 1:length(ridx)
        rid = ridx(num);
        for point = 1:16
            pred(imgidx).annorect(rid).annopoints.point(point).x ...
                = predicted_keypoints(body_id,point,1);
            
            pred(imgidx).annorect(rid).annopoints.point(point).y ...
                = predicted_keypoints(body_id,point,2);
            
            pred(imgidx).annorect(rid).annopoints.point(point).id ...
                = point-1;    
        end
        body_id = body_id + 1;
    end
end

save('pred_keypoints_mpii.mat','pred');
