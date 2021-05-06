--CÂU 1: ĐƯA RA MÓN ĂN ĐƯỢC YÊU THÍCH NHẤT QUÁN VÓI SỐ LẦN ĐẶT MÓN
--CÂU 2: DANH SÁCH NHỮNG MÓN ĂN KÉN KHÁCH ( KHÔNG ĐƯỢC KHÁCH CHỌN LẦN NÀO ) 
--CÂU 5: TẠO TRIGGER TỰ ĐỘNG TÍNH TIỀN VÀO BẢNG HÓA ĐƠN
--CÂU 7 : GIẢ SỬ LƯƠNG NHÂN VIÊN = 4TR500 + 7% DOANH THU THÁNG ĐÓ. VIẾT HÀM TÍNH LƯƠNG NHÂN VIÊN MỖI THÁNG TRONG NĂM 2020
--CÂU 8 : VIẾT TRIGGER KIỂM TRA GHẾ KHÁCH ĐỊNH NGỒI ĐÃ CÓ AI NGỒI CHƯA ? NẾU RỒI THÌ KHÔNG CHO INSERT VÀO PHIEUDAT:
--CÂU 9: ĐƯA RA DANH SÁCH TOP 3 NHÂN VIÊN LÀM VIỆC CHĂM CHỈ TRONG NĂM 2020 ĐÃ ĐƯỢC SẮP XẾP:
--CÂU 13 : ĐƯA RA DANH SÁCH NHỮNG BÀN NÀO TRỐNG THỜI ĐIỂM HIỆN TẠI 
--CÂU 14 : ĐƯA RA DANH SÁCH KHÁCH HÀNG ĐANG DÙNG MÓN THỜI ĐIỂM HIỆN TẠI
--CÂU 15 : SỬ DỤNG TRIGGER KIỂM TRA VÀ XÓA MÓN ĂN NẾU MÓN CHƯA ĐƯỢC CHỌN LẦN NÀO 
--CÂU 16 : VIẾT HÀM TÍNH TOÁN THỜI ĐIỂM NÀO TRONG NGÀY LÀ ĐÔNG KHÁCH NHẤT

/*
1. NhanVien (nhanvienID,hoten,gioitinh,ngaysinh,sdt)
2. KhachHang (khachhangID,hoten,diachi,sdt,diemtichluy)
3. Ban (banID,soghe,ghichu)
4. MonAn (monID,tenmon,dongia,maloai)
5. Banpv (phucvuID,banID,khachhangID,nhanvienID,thoigian)
6. PhieuDat (phucvuID,monID,soluong,ghichu)
7. HoaDon (phucvuID,nhanvienID,tongtien,thoigian)
*/
select * from banpv;
--CÂU 1: ĐƯA RA MÓN ĂN ĐƯỢC YÊU THÍCH NHẤT QUÁN VÓI SỐ LẦN ĐẶT MÓN
--CÁCH 1:
CREATE OR REPLACE VIEW _monanyeuthich AS
SELECT m.tenmon,p.phucvuID
FROM MonAn m, PhieuDat p
WHERE (m.monID=p.monID);

SELECT tenmon "MON AN YEU THICH",COUNT(phucvuid) "SO LAN DAT MON"
FROM _monanyeuthich
GROUP BY tenmon
HAVING (COUNT(phucvuID) >= ALL (SELECT COUNT(phucvuID) FROM _monanyeuthich GROUP BY tenmon));

--CÁCH 2:
SELECT m.tenmon "MON AN YEU THICH", COUNT(p.phucvuid) "SO LAN DAT MON"
FROM monan m,phieudat p
WHERE m.monid = p.monid
GROUP BY m.monid
HAVING (COUNT(p.phucvuid)>= ALL (SELECT COUNT(phucvuid) FROM phieudat GROUP BY monid));
--CÂU 2: DANH SÁCH NHỮNG MÓN ĂN KÉN KHÁCH ( KHÔNG ĐƯỢC KHÁCH CHỌN LẦN NÀO ) :

--CÁCH 1:
SELECT tenmon
FROM monan
EXCEPT
SELECT DISTINCT m.tenmon
FROM monan m,phieudat p
WHERE (m.monid=p.monid);
select * from hoadon

--CÁCH 2:
SELECT monan.tenmon
FROM monan
WHERE monan.tenmon NOT IN (
	SELECT m.tenmon 
	FROM monan m ,phieudat p 
	WHERE m.monid = p.monid);
	
--CÂU 3 : THỐNG KÊ DOANH THU CỦA TỪNG THÁNG TRONG NĂM 2020
SELECT EXTRACT(MONTH FROM thoigian) "MONTH",SUM(tongtien) "DOANH THU"
FROM hoadon
WHERE EXTRACT(YEAR FROM thoigian)=2020
GROUP BY EXTRACT(MONTH FROM hoadon.thoigian);

--CÂU 4 :LIỆT KÊ DANH SÁCH KHÁCH HÀNG (TÊN + ĐỊA CHỈ + SĐT) THƯỜNG XUYÊN DÙNG BỮA TẠI CỬA HÀNG (SỐ LẦN ĐẾN ĂN >= 4)

SELECT k.hoten, k.diachi, k.sdt
FROM khachhang k, banpv b
WHERE k.khachhangid = b.khachhangid
GROUP BY k.khachhangid
HAVING COUNT(phucvuid) >= 4;


--- cau 5 : tao trigger tu dong tinh tien
create or replace function tf_hoadon_update() returns trigger as $$
declare numberss int;
declare moneys int; 
begin
	select m.dongia
	from monan m
	where m.monid = new.monid
	into moneys;
	update hoadon
	set tongtien = tongtien+moneys*new.soluong
	where new.phucvuid = hoadon.phucvuid ;
	return null;
end;
$$ language plpgsql;

create trigger hoadon_update1
after insert on phieudat
for each row
execute procedure tf_hoadon_update();

create or replace function tf_hoadon_delete() returns trigger as $$
declare numberss int;
declare moneys int; 
begin
	select m.dongia
	from monan m
	where m.monid = old.monid
	into moneys;
	update hoadon
	set tongtien = tongtien-moneys*old.soluong
	where old.phucvuid = hoadon.phucvuid ;
	return null;
end;
$$ language plpgsql;

create trigger hoadon_update2
after delete on phieudat
for each row
execute procedure tf_hoadon_delete();

drop trigger hoadon_update2 on phieudat;
delete from phieudat 
where phucvuid = '1'
and monid = '6';
select * from banpv;
select * from phieudat;
DROP TRIGGER  hoadon_update1 ON phieudat
select * from hoadon ;
update hoadon 
set tongtien = 1130000
where phucvuid = '1';


create or replace function tf_hoadon_update1() returns trigger as $$
declare moneys int; 
declare kiemtra character(8);
begin
	kiemtra := ' ';
	raise notice '%',tg_op;
	if (tg_op = 'INSERT' ) then 
	select phucvuid
	from hoadon
	where phucvuid = new.phucvuid
	into kiemtra;
	raise notice '%',kiemtra;
	if (kiemtra = ' ') then 
		insert into hoadon values(new.phucvuid,'8',0,current_date);
	    end if;
	select m.dongia
	from monan m
	where m.monid = new.monid
	into moneys;
	raise notice '%',moneys;
	raise notice '%',new.soluong;
	update hoadon
	set tongtien = tongtien+moneys*new.soluong
	where new.phucvuid = hoadon.phucvuid ;
	--return new;
	elseif (tg_op = 'DELETE') then 
	select m.dongia
	from monan m
	where m.monid = old.monid
	into moneys;
	update hoadon
	set tongtien = tongtien - moneys*old.soluong
	where old.phucvuid = hoadon.phucvuid ;
	--return old;
		
	end if;
	return new;
end;
$$ language plpgsql;

create trigger hoadon_update
after insert or delete on phieudat
for each row
execute procedure tf_hoadon_update1();

drop trigger hoadon_update on phieudat;
insert into phieudat values ('1','5',3,NULL);
insert into phieudat values ('1','1',4,NULL);
insert into phieudat values ('1','2',2,NULL);
insert into phieudat values('40','2',3,NULL);
insert into hoadon values ('40','8',0,current_date);
delete from phieudat
where phucvuid = '40'
and monid = '2'
and soluong = 3;
delete from phieudat
where phucvuid = '1'
and monid = '5'
and soluong = 3;
delete from hoadon
where phucvuid = '40';
select * from banpv;
select * from phieudat;
select * from hoadon;
select * from monan;
delete from phieudat
where phucvuid = '1';
update hoadon
set tongtien = 0
where phucvuid = '1';
----cau 6 : thong ke diem tich luy cua khach hang, tao trigger tu dong cong diem tich luy cho khach hang

select * from khachhang;
select * from banpv;
--CACH 1:
SELECT k.hoten,k.khachhangid,COUNT(b.phucvuid) "diem tich luy"
FROM khachhang k ,banpv b
WHERE k.khachhangid = b.khachhangid
GROUP BY k.khachhangid
ORDER BY COUNT(b.phucvuid);
--CACH 2:
SELECT k.hoten,k.khachhangid,COUNT(b.phucvuid) "diem tich luy"
FROM khachhang k
LEFT JOIN banpv b
ON k.khachhangid = b.khachhangid
GROUP BY k.khachhangid
ORDER BY COUNT(b.phucvuid);


insert into banpv values ('31','3','6','2','2020-12-19 11:23:15');
insert into banpv values ('32','4','1','3','2020-12-20 10:48:20');
---TAO TRIGGER:
create or replace function tf_khachhang_diemtichluy() returns trigger as $$
begin
	update khachhang
	set diemtichluy = diemtichluy + 1
	where khachhangid = new.khachhangid;
	return null;
end;
$$ language plpgsql;

create trigger khachhang_diemtichluy
after insert on banpv
for each row
execute procedure tf_khachhang_diemtichluy();

--CAU 7 : GIẢ SỬ LƯƠNG NHÂN VIÊN = 4TR500 + 7% DOANH THU THÁNG ĐÓ. VIẾT HÀM TÍNH LƯƠNG NHÂN VIÊN MỖI THÁNG TRONG NĂM 2020
CREATE OR REPLACE VIEW DOANH_THU AS 
SELECT EXTRACT(MONTH FROM thoigian) "MONTH",SUM(tongtien) "TONG TIEN"
FROM hoadon
WHERE EXTRACT(YEAR FROM thoigian)=2020
GROUP BY EXTRACT(MONTH FROM hoadon.thoigian);
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
--CAU 8 : VIẾT TRIGGER KIỂM TRA GHẾ KHÁCH ĐỊNH NGỒI ĐÃ CÓ AI NGỒI CHƯA ? NẾU RỒI THÌ KHÔNG CHO INSERT VÀO PHIEUDAT:
SELECT * FROM BANPV
INSERT INTO BANPV VALUES ('33','1','2','3','2020-08-19 10:30:15');
insert into banpv values('40','1','2','3','2020-08-19 11:30:15');
insert into banpv values('42','2','4','3',current_date);
DELETE FROM BANPV WHERE PHUCVUID = '41';
select * from banpv;
insert into banpv values('41','1','2','3','2020-10-10 09:30:15');

CREATE OR REPLACE FUNCTION TF_TG_CHECK() RETURNS TRIGGER AS $$
DECLARE kiemtra character(8);
BEGIN
	kiemtra := ' ';
	
	select phucvuid
	from banpv
	where EXTRACT(hour from thoigian) = extract(hour from new.thoigian)
	and EXTRACT(day from thoigian) = extract(day from new.thoigian)
	and EXTRACT(month from thoigian) = extract(month from new.thoigian)
	into kiemtra ;
	raise notice '%',kiemtra;
	if (kiemtra <> ' ') then 
	raise notice 'KHÔNG THỂ CHÈN VÌ ĐÃ TRÙNG VỚI PHUCVUID %',KIEMTRA;
	return null;
	end if;
	return new;
	
END;
$$ 
LANGUAGE plpgsql;
CREATE TRIGGER TG_CHECK
BEFORE INSERT ON BANPV
FOR EACH ROW
EXECUTE PROCEDURE TF_TG_CHECK();

/*
1. NhanVien (nhanvienID,hoten,gioitinh,ngaysinh,sdt)
2. KhachHang (khachhangID,hoten,diachi,sdt,diemtichluy)
3. Ban (banID,soghe,ghichu)
4. MonAn (monID,tenmon,dongia,maloai)
5. Banpv (phucvuID,banID,khachhangID,nhanvienID,thoigian)
6. PhieuDat (phucvuID,monID,soluong,ghichu)
7. HoaDon (phucvuID,nhanvienID,tongtien,thoigian)
*/
---CAU 9: ĐƯA RA DANH SÁCH TOP 3 NHÂN VIÊN LÀM VIỆC CHĂM CHỈ TRONG NĂM 2020 ĐÃ ĐƯỢC SẮP XẾP:
SELECT n.*,COUNT(b.phucvuid)
FROM nhanvien n, banpv b
WHERE n.nhanvienid = b.nhanvienid
AND EXTRACT(YEAR FROM thoigian)=2020
GROUP BY n.nhanvienid
ORDER BY COUNT(b.phucvuid) DESC
LIMIT 3;
--CAU 10 : MỖI THÁNG CỬA HÀNG SẼ TIẾN HÀNH TỔ CHỨC SINH NHẬT CHO NHÂN VIÊN CÓ THÁNG SINH TRÙNG VỚI THÁNG HIỆN TẠI.
--ĐƯA RA DANH SÁCH NHỮNG NHÂN VIÊN ĐƯỢC TỔ CHỨC SINH NHẬT:
--CÁCH 1:
SELECT * FROM NHANVIEN;
SELECT * 
FROM nhanvien
WHERE EXTRACT(MONTH FROM ngaysinh) = EXTRACT(MONTH FROM CURRENT_DATE);
--CÁCH 2: VIẾT HÀM
CREATE OR REPLACE FUNCTION list_nv()
RETURN TABLE(nvid character(8),hten character varying(30)) AS
$$
BEGIN
	RETURN QUERY SELECT nhanvienid,hoten 
				 FROM nhanvien
				 WHERE EXTRACT(MONTH FROM ngaysinh) = EXTRACT(MONTH FROM current_date);
END;
$$
LANGUAGE plpgsql;
SELECT * FROM list_nv();

--CÂU 11:ĐƯA RA DANH SÁCH KHÁCH HÀNG DÙNG MÓN TẠI CỬA HÀNG HÔM NAY (MÃ KHÁCH HÀNG + TÊN KHÁCH HÀNG + TỔNG TIỀN)
SELECT k.khachhangid, k.hoten, h.tongtien
FROM khachhang k,banpv b, hoadon h
WHERE k.khachhangid = b.khachhangid
AND b.phucvuid = h.phucvuid
AND EXTRACT(YEAR FROM h.thoigian) = EXTRACT(YEAR FROM CURRENT_DATE)
AND EXTRACT(MONTH FROM h.thoigian) = EXTRACT(MONTH FROM CURRENT_DATE)
AND EXTRACT(DAY FROM h.thoigian) = EXTRACT(DAY FROM CURRENT_DATE);

SELECT * FROM hoadon
INSERT INTO KHACHHANG VALUES('11','Selena Gomez','Da Nang','0987781232',0,'Nu');
insert into banpv values ('35','4','11','3','2021-01-15 15:26:37');
insert into phieudat values('35','3',2);
insert into hoadon values('35','6',0,'2021-01-15 16:26:37');
--CÂU 12 : ĐƯA RA KHÁCH HÀNG CÓ HOA ĐƠN CAO NHẤT :
--CACH 1:
SELECT b.phucvuid,k.khachhangid, k.hoten, h.tongtien
FROM khachhang k,banpv b, hoadon h
WHERE k.khachhangid = b.khachhangid
AND b.phucvuid = h.phucvuid
AND h.tongtien >= ALL(SELECT tongtien FROM hoadon);
--CACH 2:
CREATE OR REPLACE FUNCTION find_max()
RETURNS TABLE(IDphucvu character(8),IDkhachhang character(8),ten character varying(30),total integer) AS
$$
DECLARE max_total int ;
BEGIN
	SELECT MAX(tongtien)
	FROM hoadon
	into max_total;
	
	RETURN QUERY SELECT b.phucvuid,k.khachhangid, k.hoten, h.tongtien
		   FROM khachhang k,banpv b, hoadon h
	 	   WHERE k.khachhangid = b.khachhangid
		   AND b.phucvuid = h.phucvuid
		   AND h.tongtien = max_total;
END;
$$
LANGUAGE plpgsql;
SELECT * FROM find_max();
--CÂU 13 : ĐƯA RA DANH SÁCH NHỮNG BÀN NÀO TRỐNG THỜI ĐIỂM HIỆN TẠI 
select banid
from ban 
where banid not in ( select banid from banpv where  extract(year from thoigian) = extract(year from current_date)
and extract (month from thoigian) = extract(month from current_date)
and extract (day from thoigian) = extract (day from current_date)
and extract (hour from thoigian)=extract (hour from current_date));
--CÂU 14 : ĐƯA RA DANH SÁCH KHÁCH HÀNG DÙNG MÓN TRONG NGÀY HÔM NAY

update  banpv
set thoigian = '2021-01-16 20:57:15'
where phucvuid = '42';
SELECT * from banpv;
SELECT b.phucvuid,k.*,b.thoigian
FROM khachhang k, banpv b
WHERE k.khachhangid = b.khachhangid
AND extract(year from b.thoigian) = extract(year from current_date)
and extract (month from b.thoigian) = extract(month from current_date)
and extract (day from b.thoigian) = extract (day from current_date);
select * from ban;

 select banid from banpv where  extract(year from thoigian) = extract(year from current_date)
and extract (month from thoigian) = extract(month from current_date)
and extract (day from thoigian) = extract (day from current_date)
and extract (hour from thoigian)= extract (hour from current_date);

select banid from banpv where  thoigian between 


--CÂU 15 : SỬ DỤNG TRIGGER KIỂM TRA VÀ XÓA MÓN ĂN NẾU MÓN CHƯA ĐƯỢC CHỌN LẦN NÀO 


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

delete from monan
where monid = '8';
insert into monan values('8','thi tho rang muoi',150000,NULL);
insert into monan values('9','oc xao me',120000,NULL);

select * from monan;
select tenmon
from monan
where monid not in (select monid from phieudat )
--CÂU 16 : VIẾT HÀM TÍNH TOÁN THỜI ĐIỂM NÀO TRONG NGÀY LÀ ĐÔNG KHÁCH NHẤT
/*
1. NhanVien (nhanvienID,hoten,gioitinh,ngaysinh,sdt)
2. KhachHang (khachhangID,hoten,diachi,sdt,diemtichluy)
3. Ban (banID,soghe,ghichu)
4. MonAn (monID,tenmon,dongia,maloai)
5. Banpv (phucvuID,banID,khachhangID,nhanvienID,thoigian)
6. PhieuDat (phucvuID,monID,soluong,ghichu)
7. HoaDon (phucvuID,nhanvienID,tongtien,thoigian)
*/
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







