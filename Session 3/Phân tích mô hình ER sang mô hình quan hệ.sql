

-- Danh sách các bảng và thuộc tính (Database Schema)


Bảng 1:
KHOA : MaKhoa (PK), TenKhoa


Bảng 2:
BAC_SI : MaBacSi (PK), HoTen, ChuyenMon, SoDienThoai, MaKhoa (FK)

Bảng 3:
BENH_NHAN : MaBenhNhan (PK), HoTen, NgaySinh, GioiTinh, DiaChi


Bảng 4: HO_SO_KHAM : MaHoSo (PK), NgayKham, ChanDoan, DonThuoc, MaBenhNhan (FK), MaBacSi (FK)

Khoa - Bác sĩ(1-N), Bệnh nhân - Hồ sơ khám(1-N), Bác sĩ - Bệnh Nhân(N - N)