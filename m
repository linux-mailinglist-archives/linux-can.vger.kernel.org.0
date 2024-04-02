Return-Path: <linux-can+bounces-421-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7185E8959C3
	for <lists+linux-can@lfdr.de>; Tue,  2 Apr 2024 18:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E95284BC0
	for <lists+linux-can@lfdr.de>; Tue,  2 Apr 2024 16:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A7B1586C5;
	Tue,  2 Apr 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxiluxsystems-com.20230601.gappssmtp.com header.i=@maxiluxsystems-com.20230601.gappssmtp.com header.b="D/GMsWf+"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94511581EF
	for <linux-can@vger.kernel.org>; Tue,  2 Apr 2024 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075524; cv=none; b=VERbc+7GflIPXH++djuvdp2EQL/y8HZ96sF1tz0LqsX6lCR4/iLd4TenZCglZZy05kjNy+MWvGA7+k+jVYpX1mIXswKpt26lw2MW39gDkSWShjlqNm4i5YXjQIHvjHHNYhc+s0mXl9dC+IMyAmdI7i2r3uRLtf7eqp9pNmmpycY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075524; c=relaxed/simple;
	bh=ge2vhH25KAIh3hkTAi6yG2hZXUBEpPqAfyzxNqzv0cM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ndC2fWQ9FErjHYpNn/HQ0dKkqMR5J1Ax1i+dwZtYr+W8eJXeletmxq2j872Ep0ATnVYBdZaRqBG8B4Ma68O8PbA5V4S7y7lWgaATM73Sq0tPB/u/I7ElNoREbLmYucPswmLVBaKSL/pOrgL57hLuFBH9IAPf5bKsKk/y/JUnIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxiluxsystems.com; spf=none smtp.mailfrom=maxiluxsystems.com; dkim=pass (2048-bit key) header.d=maxiluxsystems-com.20230601.gappssmtp.com header.i=@maxiluxsystems-com.20230601.gappssmtp.com header.b=D/GMsWf+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxiluxsystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=maxiluxsystems.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a274955aacso406407a91.2
        for <linux-can@vger.kernel.org>; Tue, 02 Apr 2024 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20230601.gappssmtp.com; s=20230601; t=1712075522; x=1712680322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ge2vhH25KAIh3hkTAi6yG2hZXUBEpPqAfyzxNqzv0cM=;
        b=D/GMsWf+zfQnhXIf/hXerFu2oSw5VbYSNO6O5hrLQgMY6Ldeul+iTKXVrABUCoL7Kh
         jK30gux8IfdWf6tmVIiMnj13ivwmWZe4wZXfGv6H2ZVJFKDRjRwYqKAuIuI3IIugsuPx
         /I9KCev055MkLT4L85lbGFZ8deJ7BLYPUpkCSS+FCmu5z3+/xu9ipgt2rEY5FpKEmU7y
         wULp6XZNDTjoRAOl4JVZcFdTODtQwsGA7I8NB3DkyinyG/CyZrZASaCuEvY2sZ2WA05O
         yOjBWTT8Rrt07QNZeaERDpUZcfFGtkQ9i3fjmYnx+0dOytf0skfUply4TQnrda2HL+YT
         PkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712075522; x=1712680322;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ge2vhH25KAIh3hkTAi6yG2hZXUBEpPqAfyzxNqzv0cM=;
        b=C/GsRCYWQ+23L931Iz9kkiy0z4rfZzlofXN0DAqeRXPiff61MYzO+b4a6CqXmbYkMA
         9BA5HWJYcecm/fGcmVvdJdw9aC8MZPEnEDdSmsfTBtibvT3/x8ErRuT+j0+jElMjgcG+
         Al4/N7lOPQbWUkGCwPDJXH78fCMhLUU+pnTWoQAWZj/yuHG5Cnwr8aNNcVViElPWxOdG
         8aVtY/o8xuTBN1f1bjEaYTK4LI+KyxmXOkIKsRYjZkAG71ivLvRj7QSPgs0M9DbkpXPb
         cnL3o3EK6apAkVYmsSbxcKL0CDM097jIV8yFHpdkXkJFxsSR8JzOCDlEV68d14q0JYhw
         ljwg==
X-Gm-Message-State: AOJu0Yxd5HsdF3SnWQWck9D64X5OMq1Ii2fKj30IUcd3ProFk9tzgbQL
	RrShQKheu4vFOg0P0W3BOTJ/xj1lGE5hzWuaTZCBGSnR/9aBX67VKEHZvKW/s9vA6ryErVvfYxk
	rLKNqTIQkq5J29dOuXIHAsOqmjcdNkQXc0FYmkV9Qo8iE76ruPu0=
X-Google-Smtp-Source: AGHT+IHv1NdIAzzt4wZTIkWzBGXuT8m+ytJCAtFPfwAPasoeZzRxw+8n0JXFxqNpnIzM7LIa4yfra/IMig3Mc/8sjkg=
X-Received: by 2002:a17:90a:be05:b0:29f:f619:7c2f with SMTP id
 a5-20020a17090abe0500b0029ff6197c2fmr9636262pjs.27.1712075521862; Tue, 02 Apr
 2024 09:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Torin Cooper-Bennun <tcbennun@maxiluxsystems.com>
Date: Tue, 2 Apr 2024 17:31:50 +0100
Message-ID: <CAALJrqi6HN_qXcOcYUnp9ihhGyLxmGid6gkR3Czj13YVLJt5sQ@mail.gmail.com>
Subject: Rare mcp251xfd crash after CRC read error, in timestamp read routine
To: linux-can <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: multipart/mixed; boundary="0000000000004f69f906151fa542"

--0000000000004f69f906151fa542
Content-Type: text/plain; charset="UTF-8"

Hello Marc et al.,

I have discovered a rare but annoying crash in mcp251xfd. I don't know how to
replicate this directly, and the occurrence rate is very low (on the order of
once per 1e7 frames or so).

I cannot be too specific on our hardware, but we are running ARMv8, and the CAN
chip is the MCP2518FD. The kernel version is 6.1.21.

The crash always happens immediately following a CRC read error. I've attached
a sample kernel log of the crash (hopefully correctly - I've not interacted
with mailing lists for a while). So far, the call trace is always the same.

To be clear, this is not after every CRC read error; those are several orders
of magnitude more frequent than this crash.

I've done a tiny bit of digging myself, but I'm not familiar with the
territory. I guess something in the SPI dev struct is being set to NULL, while
an SPI transaction is ongoing - but it surely must be related to the CRC read
error and the timestamp read.

Thanks for reading :)

--0000000000004f69f906151fa542
Content-Type: application/octet-stream; name="oops.log"
Content-Disposition: attachment; filename="oops.log"
Content-Transfer-Encoding: base64
Content-ID: <f_luiliv0a0>
X-Attachment-Id: f_luiliv0a0

bWNwMjUxeGZkIHNwaTAuMCBjYW4wOiBDUkMgcmVhZCBlcnJvciBhdCBhZGRyZXNzIDB4MDAxMCAo
bGVuZ3RoPTQsIGRhdGE9ODQgYmIgNDUgMWYsIENSQz0weDI1YzgpIHJldHJ5aW5nLgpVbmFibGUg
dG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRy
ZXNzIDAwMDAwMDAwMDAwMDAwMDgKTWVtIGFib3J0IGluZm86CiAgRVNSID0gMHgwMDAwMDAwMDk2
MDAwMDA1CiAgRUMgPSAweDI1OiBEQUJUIChjdXJyZW50IEVMKSwgSUwgPSAzMiBiaXRzCiAgU0VU
ID0gMCwgRm5WID0gMAogIEVBID0gMCwgUzFQVFcgPSAwCiAgRlNDID0gMHgwNTogbGV2ZWwgMSB0
cmFuc2xhdGlvbiBmYXVsdApEYXRhIGFib3J0IGluZm86CiAgSVNWID0gMCwgSVNTID0gMHgwMDAw
MDAwNQogIENNID0gMCwgV25SID0gMAp1c2VyIHBndGFibGU6IDRrIHBhZ2VzLCAzOS1iaXQgVkFz
LCBwZ2RwPTAwMDAwMDAwNzI2YTIwMDAKWzAwMDAwMDAwMDAwMDAwMDhdIHBnZD0wMDAwMDAwMDAw
MDAwMDAwLCBwNGQ9MDAwMDAwMDAwMDAwMDAwMCwgcHVkPTAwMDAwMDAwMDAwMDAwMDAKSW50ZXJu
YWwgZXJyb3I6IE9vcHM6IDAwMDAwMDAwOTYwMDAwMDUgWyMxXSBQUkVFTVBUIFNNUApNb2R1bGVz
IGxpbmtlZCBpbjogW1JFREFDVEVEXSBtY3AyNTF4ZmQgY2FuX2RldiBzcGlkZXYgW1JFREFDVEVE
XQpDUFU6IDMgUElEOiAyNTA2ODkwIENvbW06IGt3b3JrZXIvMzoyIFRhaW50ZWQ6IEcgICAgICAg
ICBDICAgICAgICAgNi4xLjIxLXY4KyAjMTY0MgpIYXJkd2FyZSBuYW1lOiBbUkVEQUNURURdCldv
cmtxdWV1ZTogZXZlbnRzIG1jcDI1MXhmZF90aW1lc3RhbXBfd29yayBbbWNwMjUxeGZkXQpwc3Rh
dGU6IDgwMDAwMGM1IChOemN2IGRhSUYgLVBBTiAtVUFPIC1UQ08gLURJVCAtU1NCUyBCVFlQRT0t
LSkKcGMgOiBfcmF3X3NwaW5fbG9ja19pcnFzYXZlKzB4N2MvMHhjOApsciA6IF9yYXdfc3Bpbl9s
b2NrX2lycXNhdmUrMHgzYy8weGM4CnNwIDogZmZmZmZmYzAwY2NjMzg0MAp4Mjk6IGZmZmZmZmMw
MGNjYzM4NDAgeDI4OiBmZmZmZmY4MDQzODBlODAwIHgyNzogZmZmZmZmZWFiNzg0NDAwOAp4MjY6
IGZmZmZmZmVhYjdiNTg4OTggeDI1OiAwMDAwMDA2N2FjMDY3ZWIwIHgyNDogZmZmZmZmYzAwY2Nj
M2E2MAp4MjM6IGZmZmZmZmMwMGNjYzNiMzAgeDIyOiBmZmZmZmZjMDBjY2MzYjMwIHgyMTogZmZm
ZmZmODA0MzgwZTgwMAp4MjA6IDAwMDAwMDAwMDAwMDAwMDAgeDE5OiAwMDAwMDAwMDAwMDAwMDA4
IHgxODogMDAwMDAwMDAwMDAwMDAzMAp4MTc6IDNkNjg3NDY3NmU2NTZjMjggeDE2OiBmZmZmZmZl
YWI2ZmRhOGY4IHgxNTogNzM3MzY1NzI2NDY0NjEyMAp4MTQ6IDc0NjEyMDcyNmY3MjcyNjUgeDEz
OiAyZTY3NmU2OTc5NzI3NDY1IHgxMjogZmZmZmZmZWFiN2JlNzNiMAp4MTE6IDAwMDAwMDAwMDAw
MDAwMDMgeDEwOiAwMDAwMDAwMDAwMDAwMDAxIHg5IDogZmZmZmZmZWFiNzM3MTc2NAp4OCA6IDAw
MDAwMDAwMDAwMTdmZTggeDcgOiBmZmZmZmZjMDBjY2M0MDAwIHg2IDogZmZmZmZmYzAwY2NjMDAw
MAp4NSA6IGZmZmZmZmMwMGNjYzQwMDAgeDQgOiBmZmZmZmZjMDBjY2MzODUwIHgzIDogMDAwMDAw
MDAwMDAwMDAwMAp4MiA6IDAwMDAwMDAwMDAwMDAwMDEgeDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgw
IDogZmZmZmZmODA0YWFmODAwMApDYWxsIHRyYWNlOgogX3Jhd19zcGluX2xvY2tfaXJxc2F2ZSsw
eDdjLzB4YzgKIGNvbXBsZXRlKzB4MmMvMHg4MAogc3BpX2NvbXBsZXRlKzB4MTgvMHgyOAogc3Bp
X2ZpbmFsaXplX2N1cnJlbnRfbWVzc2FnZSsweDFhNC8weDJjOAogc3BpX3RyYW5zZmVyX29uZV9t
ZXNzYWdlKzB4MzhjLzB4N2U4CiBfX3NwaV9wdW1wX3RyYW5zZmVyX21lc3NhZ2UrMHgyNDgvMHg2
NDAKIF9fc3BpX3N5bmMrMHgyNzQvMHgzZDAKIHNwaV9zeW5jKzB4MzgvMHg2MAogbWNwMjUxeGZk
X3JlZ21hcF9jcmNfcmVhZCsweDE1MC8weDJlMCBbbWNwMjUxeGZkXQogX3JlZ21hcF9yYXdfcmVh
ZCsweGU0LzB4MmIwCiBfcmVnbWFwX2J1c19yZWFkKzB4NGMvMHg4OAogX3JlZ21hcF9yZWFkKzB4
NzAvMHgxYTgKIHJlZ21hcF9yZWFkKzB4NTQvMHg4MAogbWNwMjUxeGZkX3RpbWVzdGFtcF9yZWFk
KzB4NDgvMHg5MCBbbWNwMjUxeGZkXQogdGltZWNvdW50ZXJfcmVhZCsweDJjLzB4NzgKIG1jcDI1
MXhmZF90aW1lc3RhbXBfd29yaysweDI0LzB4NTAgW21jcDI1MXhmZF0KIHByb2Nlc3Nfb25lX3dv
cmsrMHgyMDgvMHg0ODAKIHdvcmtlcl90aHJlYWQrMHg1MC8weDQyOAoga3RocmVhZCsweGZjLzB4
MTEwCiByZXRfZnJvbV9mb3JrKzB4MTAvMHgyMApDb2RlOiBkNjVmMDNjMCBkMjgwMDAwMSA1Mjgw
MDAyMiBmOTgwMDI3MSAoODg1ZmZlNjApIAotLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAw
IF0tLS0Kbm90ZToga3dvcmtlci8zOjJbMjUwNjg5MF0gZXhpdGVkIHdpdGggaXJxcyBkaXNhYmxl
ZApub3RlOiBrd29ya2VyLzM6MlsyNTA2ODkwXSBleGl0ZWQgd2l0aCBwcmVlbXB0X2NvdW50IDEK
Cg==
--0000000000004f69f906151fa542--

