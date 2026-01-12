Return-Path: <linux-can+bounces-6104-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C3DD1372F
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 16:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5306D30BADBE
	for <lists+linux-can@lfdr.de>; Mon, 12 Jan 2026 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28852DB78D;
	Mon, 12 Jan 2026 14:52:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A52D5432;
	Mon, 12 Jan 2026 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229543; cv=none; b=Jg83ABZ7pijt6d4lM7hgftMw5zsdNohNdel5utbVLbtRFz0fm1VeQMZRJqJEMVvEEVRXxFcOnUqjcyz/YVPPCu0r39XghjQF1IG4448IjqYvxiidUqhhYu/NWDQ3vrhXzvQGfE/uPCbr2FX96y9wMx1YP8LMys/lhbaeiRYv3RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229543; c=relaxed/simple;
	bh=6FsGGpwsZXSBclx9LRhZ4lHtZuEYOyZtvFG9RaggGRs=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=T4de1a2rkcDKoPMXXyZ2oeIwRAL9HmwKx/Ab0OvdGSpA1u5fo0hLT+ICjwlLtk2NJADXHubk/D42xqHLUC9alOkyd9uSp7RMxPAewwbmb81IT0RmbLVRV124jC9k+9LnbG8BCj4EodVGdmV2tLrCp3ej52VHGQWLo+5rujrLeLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60CEpvYb043406;
	Mon, 12 Jan 2026 23:51:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60CEpvsJ043403
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 12 Jan 2026 23:51:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Content-Type: multipart/mixed; boundary="------------aRZKhr9TM3hQQGUnYLQ90N0C"
Message-ID: <faee3f3c-b03d-4937-9202-97ec5920d699@I-love.SAKURA.ne.jp>
Date: Mon, 12 Jan 2026 23:51:57 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Network Development <netdev@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: can: j1939: unregister_netdevice: waiting for vcan0 to become free.
X-Virus-Status: clean
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp

This is a multi-part message in MIME format.
--------------aRZKhr9TM3hQQGUnYLQ90N0C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello.

I found a simplified C reproducer for
https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84 from

  r1 = socket$can_j1939(0x1d, 0x2, 0x7)
  ioctl$ifreq_SIOCGIFINDEX_vcan(r1, 0x8933, &(0x7f0000001440)={'vcan0\x00', <r2=>0x0})
  r3 = socket$can_j1939(0x1d, 0x2, 0x7)
  ioctl$ifreq_SIOCGIFINDEX_vcan(r3, 0x8933, &(0x7f00000000c0)={'vcan0\x00', <r4=>0x0})
  bind$can_j1939(r3, &(0x7f0000000340)={0x1d, r4, 0x0, {0x2, 0x0, 0x6}, 0xfe}, 0x18)
  setsockopt$sock_int(r3, 0x1, 0x6, &(0x7f0000000040)=0x1, 0x4)
  sendmsg$inet(r3, &(0x7f0000000140)={0x0, 0x0, &(0x7f00000003c0)=[{&(0x7f0000000540)="81b641f1f3843704b6", 0x9}], 0x1}, 0x4048081)
  bind$can_j1939(r1, &(0x7f0000000100)={0x1d, r2, 0x0, {0x1, 0xf0, 0x4}, 0xfe}, 0x18)
  setsockopt$sock_int(r1, 0x1, 0x6, &(0x7f0000000040)=0x1, 0x4)
  sendmsg$inet(r3, &(0x7f0000000080)={0x0, 0x0, &(0x7f0000000a80)=[{&(0x7f0000000000)="81b641f1f3843704b6", 0x9}], 0x1}, 0x48005)

lines. Can you find what is wrong?

  [   58.844267] [   T1225] CAN device driver interface
  [   58.865035] [   T1225] vcan: Virtual CAN interface driver
  [   58.924043] [   T1227] can: controller area network core
  [   58.929503] [   T1227] NET: Registered PF_CAN protocol family
  [   58.959118] [   T1228] can: SAE J1939
  [   59.215990] [      C0] vcan0: j1939_tp_rxtimer: 0x0000000042028812: rx timeout, send abort
  [   59.716693] [      C0] vcan0: j1939_tp_rxtimer: 0x0000000041105737: rx timeout, send abort
  [   59.722127] [      C0] vcan0: j1939_tp_rxtimer: 0x0000000042028812: abort rx timeout. Force session deactivation
  [   59.742525] [      C0] vcan0: j1939_xtp_rx_rts_session_active: 0x0000000041105737: connection exists (fe ff). last cmd: 20
  [   59.992638] [      C0] vcan0: j1939_tp_rxtimer: 0x0000000069d7bfc6: rx timeout, send abort
  [   60.497771] [      C0] vcan0: j1939_tp_rxtimer: 0x0000000069d7bfc6: abort rx timeout. Force session deactivation
  [   70.677761] [     T12] unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
--------------aRZKhr9TM3hQQGUnYLQ90N0C
Content-Type: text/plain; charset=UTF-8; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRs
Lmg+CiNpbmNsdWRlIDxzY2hlZC5oPgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxz
dGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1
ZGUgPHN5cy9pb2N0bC5oPgojaW5jbHVkZSA8c3lzL3NvY2tldC5oPgojaW5jbHVkZSA8c3lz
L3N0YXQuaD4KI2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNp
bmNsdWRlIDxzeXMvbW1hbi5oPgoKc3RhdGljIHZvaWQgZXhlY3V0ZV9vbmUodm9pZCkKewoJ
aW50IGlkeCA9IDA7Cgljb25zdCBpbnQgT05FID0gMTsKCS8vICBzb2NrZXQkY2FuX2oxOTM5
IGFyZ3VtZW50czogWwoJLy8gICAgZG9tYWluOiBjb25zdCA9IDB4MWQgKDggYnl0ZXMpCgkv
LyAgICB0eXBlOiBjb25zdCA9IDB4MiAoOCBieXRlcykKCS8vICAgIHByb3RvOiBjb25zdCA9
IDB4NyAoNCBieXRlcykKCS8vICBdCgkvLyAgcmV0dXJucyBzb2NrX2Nhbl9qMTkzOQoJY29u
c3QgaW50IGZkID0gc29ja2V0KDB4MWQsIDIsIDcpOwoJLy8gIGlvY3RsJGlmcmVxX1NJT0NH
SUZJTkRFWF92Y2FuIGFyZ3VtZW50czogWwoJLy8gICAgZmQ6IHNvY2sgKHJlc291cmNlKQoJ
Ly8gICAgY21kOiBjb25zdCA9IDB4ODkzMyAoNCBieXRlcykKCS8vICAgIGFyZzogcHRyW291
dCwgaWZyZXFfZGV2X3RbdmNhbl9kZXZpY2VfbmFtZXMsIGlmaW5kZXhfdmNhbl1dIHsKCS8v
ICAgICAgaWZyZXFfZGV2X3RbdmNhbl9kZXZpY2VfbmFtZXMsIGlmaW5kZXhfdmNhbl0gewoJ
Ly8gICAgICAgIGlmcl9pZnJuOiBidWZmZXI6IHs3NiA2MyA2MSA2ZSAzMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMH0KCS8vICAgICAgICAobGVuZ3RoIDB4MTApIGVsZW06
IGlmaW5kZXhfdmNhbiAocmVzb3VyY2UpIHBhZCA9IDB4MCAoMjAgYnl0ZXMpCgkvLyAgICAg
IH0KCS8vICAgIH0KCS8vICBdCgltZW1jcHkoKHZvaWQqKTB4MjAwMDAwMDAxNDQwLAoJICAg
ICAgICJ2Y2FuMFwwMDBcMDAwXDAwMFwwMDBcMDAwXDAwMFwwMDBcMDAwXDAwMFwwMDBcMDAw
IiwgMTYpOwoJaWYgKGlvY3RsKGZkLCAweDg5MzMsIDB4MjAwMDAwMDAxNDQwdWwpICE9IC0x
KQoJCWlkeCA9ICoodWludDMyX3QqKTB4MjAwMDAwMDAxNDUwOwoJLy8gIGJpbmQkY2FuX2ox
OTM5IGFyZ3VtZW50czogWwoJLy8gICAgZmQ6IHNvY2tfY2FuX2oxOTM5IChyZXNvdXJjZSkK
CS8vICAgIGFkZHI6IHB0cltpbiwgc29ja2FkZHJfY2FuX2oxOTM5XSB7CgkvLyAgICAgIHNv
Y2thZGRyX2Nhbl9qMTkzOSB7CgkvLyAgICAgICAgY2FuX2ZhbWlseTogY29uc3QgPSAweDFk
ICgyIGJ5dGVzKQoJLy8gICAgICAgIHBhZCA9IDB4MCAoMiBieXRlcykKCS8vICAgICAgICBj
YW5faWZpbmRleDogaWZpbmRleF92Y2FuIChyZXNvdXJjZSkKCS8vICAgICAgICBuYW1lOiBp
bnQ2NCA9IDB4MCAoOCBieXRlcykKCS8vICAgICAgICBwZ246IGNhbl9qMTkzOV9wZ24gewoJ
Ly8gICAgICAgICAgcGduX3BzOiBjYW5fajE5MzlfcGduX3BzID0gMHgxICgxIGJ5dGVzKQoJ
Ly8gICAgICAgICAgcGduX3BmOiBjYW5fajE5MzlfcGduX3BmID0gMHhmMCAoMSBieXRlcykK
CS8vICAgICAgICAgIHBnbl9mbGFnczogY2FuX2oxOTM5X3Bnbl9mbGFncyA9IDB4NCAoMSBi
eXRlcykKCS8vICAgICAgICAgIHBnbl91bnVzZWQ6IGNvbnN0ID0gMHgwICgxIGJ5dGVzKQoJ
Ly8gICAgICAgIH0KCS8vICAgICAgICBhZGRyOiBjYW5fajE5MzlfYWRkcnMgPSAweGZlICgx
IGJ5dGVzKQoJLy8gICAgICAgIHBhZCA9IDB4MCAoMyBieXRlcykKCS8vICAgICAgfQoJLy8g
ICAgfQoJLy8gICAgbGVuOiBieXRlc2l6ZSA9IDB4MTggKDggYnl0ZXMpCgkvLyAgXQoJKih1
aW50MTZfdCopMHgyMDAwMDAwMDAxMDAgPSAweDFkOwoJKih1aW50MzJfdCopMHgyMDAwMDAw
MDAxMDQgPSBpZHg7CgkqKHVpbnQ2NF90KikweDIwMDAwMDAwMDEwOCA9IDA7CgkqKHVpbnQ4
X3QqKTB4MjAwMDAwMDAwMTEwID0gMTsKCSoodWludDhfdCopMHgyMDAwMDAwMDAxMTEgPSAw
eGYwOwoJKih1aW50OF90KikweDIwMDAwMDAwMDExMiA9IDQ7CgkqKHVpbnQ4X3QqKTB4MjAw
MDAwMDAwMTEzID0gMDsKCSoodWludDhfdCopMHgyMDAwMDAwMDAxMTQgPSAweGZlOwoJYmlu
ZChmZCwgKHN0cnVjdCBzb2NrYWRkciAqKSAweDIwMDAwMDAwMDEwMHVsLCAweDE4dWwpOwoJ
c2V0c29ja29wdChmZCwgU09MX1NPQ0tFVCwgU09fQlJPQURDQVNULCAmT05FLCBzaXplb2Yo
T05FKSk7CglzZW5kKGZkLCAiXHg4MVx4YjZceDQxXHhmMVx4ZjNceDg0XHgzN1x4MDRceGI2
IiwgOSwgMCk7CglzZW5kKGZkLCAiXHg4MVx4YjZceDQxXHhmMVx4ZjNceDg0XHgzN1x4MDRc
eGI2IiwgOSwgMCk7Cn0KCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCnsKCW1t
YXAoKHZvaWQgKikgMHgyMDAwMDAwMDAwMDB1bCwgMHgxMDAwMDAwdWwsCgkgICAgIFBST1Rf
V1JJVEV8UFJPVF9SRUFEfFBST1RfRVhFQywKCSAgICAgTUFQX0ZJWEVEfE1BUF9BTk9OWU1P
VVN8TUFQX1BSSVZBVEUsIC0xLCAwKTsKCWlmICh1bnNoYXJlKENMT05FX05FV05FVCkpCgkJ
cmV0dXJuIDE7CglzeXN0ZW0oImlwIGxpbmsgYWRkIG5hbWUgdmNhbjAgdXAgdHlwZSB2Y2Fu
Iik7CglzeXN0ZW0oImlwIGFkZHIgYWRkIDE3Mi4yMC4yMC4wLzI0IGRldiB2Y2FuMCIpOwoJ
ZXhlY3V0ZV9vbmUoKTsKCXJldHVybiAwOwp9Cg==

--------------aRZKhr9TM3hQQGUnYLQ90N0C--

