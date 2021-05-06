--CÂU 1: ĐƯA RA MÓN ĂN ĐƯỢC YÊU THÍCH NHẤT QUÁN VÓI SỐ LẦN ĐẶT MÓN
--CÁCH 1:

CREATE OR REPLACE VIEW _monanyeuthich AS
SELECT m.tenmon,p.phucvuID
FROM MonAn m, PhieuDat p
WHERE (m.monID=p.monID);
EXPLAIN ANALYSE
SELECT tenmon "MON AN YEU THICH",COUNT(phucvuid) "SO LAN DAT MON"
FROM _monanyeuthich
GROUP BY tenmon
HAVING (COUNT(phucvuID) >= ALL (SELECT COUNT(phucvuID) FROM _monanyeuthich GROUP BY tenmon));

--CÁCH 2:
EXPLAIN ANALYSE
SELECT m.tenmon "MON AN YEU THICH", COUNT(p.phucvuid) "SO LAN DAT MON"
FROM monan m,phieudat p
WHERE m.monid = p.monid
GROUP BY m.monid
HAVING (COUNT(p.phucvuid)>= ALL (SELECT COUNT(phucvuid) FROM phieudat GROUP BY monid));
--nhận xét : cách 2 tối ưu hơn

--CÂU 2: DANH SÁCH NHỮNG MÓN ĂN KÉN KHÁCH ( KHÔNG ĐƯỢC KHÁCH CHỌN LẦN NÀO ) 
--CÁCH 1:
EXPLAIN ANALYSE
SELECT tenmon
FROM monan
EXCEPT
SELECT DISTINCT m.tenmon
FROM monan m,phieudat p
WHERE (m.monid=p.monid);

--CÁCH 2:
EXPLAIN ANALYSE
SELECT monan.tenmon
FROM monan
WHERE monan.tenmon NOT IN (
	SELECT m.tenmon 
	FROM monan m ,phieudat p 
	WHERE m.monid = p.monid);
--nhận xét : cách 2 tối ưu hơn
	
--CÂU 3: TẠO TRIGGER TỰ ĐỘNG TÍNH TIỀN VÀO BẢNG HÓA ĐƠN
CREATE OR REPLACE FUNCTION tf_hoadon_update1() RETURNS TRIGGER AS $$
DECLARE moneys int; 
DECLARE kiemtra character(8);
BEGIN
	kiemtra := ' ';
	IF (tg_op = 'INSERT' ) THEN 
	SELECT phucvuid
	FROM hoadon
	WHERE phucvuid = NEW.phucvuid
	INTO kiemtra;
	raise notice '%',kiemtra;
	IF (kiemtra = ' ') THEN 
		INSERT INTO hoadon VALUES(NEW.phucvuid,'8',0,current_date);
	    END IF;
	SELECT m.dongia
	FROM monan m
	WHERE m.monid = new.monid
	INTO moneys;
	--raise notice '%',moneys;
	--raise notice '%',new.soluong;
	UPDATE hoadon
	SET tongtien = tongtien+moneys*NEW.soluong
	WHERE NEW.phucvuid = hoadon.phucvuid ;
	ELSEIF (tg_op = 'DELETE') THEN 
	SELECT m.dongia
	FROM monan m
	WHERE m.monid = OLD.monid
	INTO moneys;
	UPDATE hoadon
	SET tongtien = tongtien - moneys*OLD.soluong
	WHERE OLD.phucvuid = hoadon.phucvuid ;
		
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER hoadon_update
AFTER INSERT OR DELETE ON phieudat
FOR EACH ROW
EXECUTE PROCEDURE tf_hoadon_update1();
--VI DU:
		INSERT INTO hoadon VALUES('40','8',0,'2021-01-17 09:46:15');
delete from hoadon where phucvuid = '40';
select * from hoadon;
select * from phieudat;
insert into phieudat values ('1','3',2,NULL);
insert into phieudat values('40','3',2,NULL);
delete from phieudat where phucvuid = '40' and monid = '3';

--CÂU 4 : GIẢ SỬ LƯƠNG NHÂN VIÊN = 4TR500 + 7% DOANH THU THÁNG ĐÓ. TÍNH LƯƠNG NHÂN VIÊN MỖI THÁNG TRONG NĂM 2020

--CACH 1:
CREATE OR REPLACE VIEW VIEW_LUONGNV AS 
SELECT EXTRACT(MONTH FROM thoigian) "MONTH",SUM(tongtien)*0.07+4500000 "LUONG_NV"
FROM hoadon
WHERE EXTRACT(YEAR FROM thoigian)=2020
GROUP BY EXTRACT(MONTH FROM hoadon.thoigian);
SELECT * FROM VIEW_LUONGNV;
--CACH 2: VIET HAM
select SUM(TONGTIEN) from doanh_thu;

CREATE OR REPLACE FUNCTION LUONG_NV(in month)  AS
$$
BEGIN
	SELECT 
	
--CÂU 5 : VIẾT TRIGGER KIỂM TRA GHẾ KHÁCH ĐỊNH NGỒI ĐÃ CÓ AI NGỒI CHƯA ? NẾU RỒI THÌ KHÔNG CHO INSERT VÀO PHIEUDAT:
CREATE OR REPLACE FUNCTION TF_TG_CHECK() RETURNS TRIGGER AS $$
DECLARE kiemtra character(8);
BEGIN
	kiemtra := ' ';
	
	SELECT phucvuid
	FROM banpv
	WHERE EXTRACT(HOUR FROM thoigian) = EXTRACT(HOUR FROM NEW.thoigian)
	AND EXTRACT(DAY FROM thoigian) = EXTRACT(DAY FROM NEW.thoigian)
	AND EXTRACT(MONTH FROM thoigian) = EXTRACT(MONTH FROM NEW.thoigian)
	AND EXTRACT(YEAR FROM thoigian) = EXTRACT (YEAR FROM NEW.thoigian)
	AND banid = NEW.banid
    INTO kiemtra ;
	IF (kiemtra <> ' ') THEN 
	RAISE NOTICE 'KHÔNG THỂ CHÈN VÌ ĐÃ TRÙNG VỚI PHUCVUID %',KIEMTRA;
	RETURN null;
	END IF;
	RAISE NOTICE 'CHÈN THÀNH CÔNG';
	RETURN NEW;
	
END;
$$ 
LANGUAGE plpgsql;
CREATE TRIGGER TG_CHECK
BEFORE INSERT ON BANPV
FOR EACH ROW
EXECUTE PROCEDURE TF_TG_CHECK();

--VI DU:
SELECT * FROM BANPV
INSERT INTO BANPV VALUES ('33','1','2','3','2020-08-19 10:30:15');
insert into banpv values('40','1','2','3','2020-08-19 11:30:15');
insert into banpv values('43','2','5','5','2021-01-17 08:10:55')
insert into banpv values('42','2','4','3',current_date);
DELETE FROM BANPV WHERE PHUCVUID = '43';
select * from banpv;
insert into banpv values('41','1','2','3','2020-10-10 09:30:15');

--CÂU 6: ĐƯA RA DANH SÁCH TOP 3 NHÂN VIÊN LÀM VIỆC CHĂM CHỈ TRONG NĂM 2020 ĐÃ ĐƯỢC SẮP XẾP:
SELECT n.*,COUNT(b.phucvuid)
FROM nhanvien n, banpv b
WHERE n.nhanvienid = b.nhanvienid
AND EXTRACT(YEAR FROM thoigian)=2020
GROUP BY n.nhanvienid
ORDER BY COUNT(b.phucvuid) DESC
LIMIT 3;

--CÂU 7 : ĐƯA RA DANH SÁCH NHỮNG BÀN NÀO TRỐNG THỜI ĐIỂM HIỆN TẠI 
--CÂU 7: VIẾT HÀM ĐƯA RA DANH SÁCH BÀN TRỐNG VỚI ĐẦU VÀO LÀ THỜI ĐIỂM MUỐN TÌM KIẾM
CREATE OR REPLACE FUNCTION f_check_table(time_check timestamp) RETURNS TABLE(TENBAN character(8)) AS
$$
BEGIN
	RETURN QUERY SELECT banid
				 FROM ban
				 WHERE banid NOT IN 
				 (
					 SELECT banid 
					 FROM banpv
					 WHERE EXTRACT(YEAR FROM thoigian) = EXTRACT(YEAR FROM time_check)
					 AND EXTRACT (MONTH FROM thoigian) = EXTRACT(MONTH FROM time_check)
					 AND EXTRACT (DAY FROM thoigian) = EXTRACT (DAY FROM time_check)
					 AND EXTRACT (HOUR FROM thoigian) = EXTRACT (HOUR FROM time_check)
				 );
				 
END;
$$
LANGUAGE plpgsql;
SELECT * FROM f_check_table('2020-08-19 10:23:54');
select * from banpv
select *
from ban
where banid not in ( select banid from banpv where  extract(year from thoigian) = extract(year from current_date)
and extract (month from thoigian) = extract(month from current_date)
and extract (day from thoigian) = extract (day from current_date));
and extract (hour from thoigian)=extract (hour from current_date));
update banpv
set thoigian = '2021-01-17 08:55:55'
where phucvuid = '42';
--CÂU 8 : ĐƯA RA DANH SÁCH KHÁCH HÀNG DÙNG MÓN TRONG NGÀY HÔM NAY
update  banpv
set thoigian = '2021-01-16 20:57:15'
where phucvuid = '42';
SELECT * from banpv;
EXPLAIN ANALYSE
SELECT b.phucvuid,k.*,b.thoigian
FROM khachhang k, banpv b
WHERE k.khachhangid = b.khachhangid
AND extract(year from b.thoigian) = extract(year from current_date)
and extract (month from b.thoigian) = extract(month from current_date)
and extract (day from b.thoigian) = extract (day from current_date);

--CÂU 9 : SỬ DỤNG TRIGGER KIỂM TRA VÀ XÓA MÓN ĂN NẾU MÓN CHƯA ĐƯỢC CHỌN LẦN NÀO 
CREATE OR REPLACE FUNCTION f_check_delete() RETURNS TRIGGER AS
$$
DECLARE kiemtra character(8);
BEGIN
	kiemtra := ' ';
	SELECT monid
	FROM phieudat
	WHERE monid = OLD.monid
	INTO kiemtra;
	IF (kiemtra <> ' ') THEN
	RAISE NOTICE 'KHÔNG THỂ XÓA MÓN ĂN CÓ monid = %',OLD.monid;
	RETURN null;
	END IF;
	RAISE NOTICE 'MÓN ĂN ĐÃ ĐƯỢC XÓA KHỎI BẢNG monan';
	RETURN OLD;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER check_delete
BEFORE DELETE ON monan
FOR EACH ROW
EXECUTE PROCEDURE f_check_delete();
--VI DU
delete from monan
where monid = '8';
insert into monan values('8','thi tho rang muoi',150000,NULL);
insert into monan values('9','oc xao me',120000,NULL);

select * from monan;
select tenmon
from monan
where monid not in (select monid from phieudat )

--CÂU 10 : VIẾT HÀM TÍNH TOÁN THỜI ĐIỂM NÀO TRONG NGÀY LÀ ĐÔNG KHÁCH NHẤT
--cach 1:
select count(phucvuid), extract(hour from thoigian)
from banpv
group by extract(hour from thoigian)
having count(phucvuid) >= all(select count(phucvuid)
							  from banpv
							  group by extract(hour from thoigian));
CREATE OR REPLACE FUNCTION f_max() RETURNS void AS
$$
DECLARE soluong bigint;
DECLARE thang double precision;
BEGIN
	SELECT COUNT(phucvuid), EXTRACT(HOUR FROM thoigian)
    FROM banpv
    GROUP BY EXTRACT(HOUR FROM thoigian)
    HAVING COUNT(phucvuid) >= ALL(SELECT COUNT(phucvuid)
							  FROM banpv
							  GROUP BY EXTRACT(HOUR FROM thoigian))
	INTO soluong,thang;
	RAISE NOTICE 'THỜI GIAN KHÁCH HÀNG HAY ĐẾN ĂN NHẤT LÀ LÚC % GIỜ VỚI SỐ LƯỢNG PHUCVUID LÀ %' ,thang,soluong;
END;
$$
LANGUAGE plpgsql;

SELECT FROM f_max();
insert into banpv values ('45','1','2','7','2021-01-17 14:08:15');
select * from banpv



