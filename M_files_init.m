
PATH = '../signs/';

copyfile(strcat(PATH, 'stephen3/happy0.sign'), strcat(PATH,'stephen3/happy1.sign'), 'f');
copyfile(strcat(PATH, 'stephen4/wild0.sign'), strcat(PATH,'stephen3/wild1.sign'), 'f');
delete(strcat(PATH,'stephen1/cal-full-*.sign'));
delete(strcat(PATH,'stephen2/cal-full-*.sign'));
delete(strcat(PATH,'stephen3/cal-full-*.sign'));
delete(strcat(PATH,'stephen4/cal-full-*.sign'));
delete(strcat(PATH,'waleed1/cal-full-*.sign'));
delete(strcat(PATH,'waleed2/cal-full-*.sign'));
delete(strcat(PATH,'waleed3/cal-full-*.sign'));
delete(strcat(PATH,'waleed4/cal-full-*.sign'));