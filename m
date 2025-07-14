Return-Path: <linux-can+bounces-3977-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F323B046F7
	for <lists+linux-can@lfdr.de>; Mon, 14 Jul 2025 19:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618201896715
	for <lists+linux-can@lfdr.de>; Mon, 14 Jul 2025 17:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F93626772A;
	Mon, 14 Jul 2025 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOndj+ab"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960521C683;
	Mon, 14 Jul 2025 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515755; cv=none; b=qEK8L+FGJCc33KDfOXm19yDv/gtdOXzilG0plI8hxJ/AQ7u6v0Y5PBGgw9szOXpzZub/Fr4JuOGAR8CtZxv8e5S6eu2SCfLiXmca8MSglR4moYUjsiCtnOlDRqFzC2Y4DDTcBaBTTYjydk3zqTTnVidNfxMkRhd2hsf7bycmbrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515755; c=relaxed/simple;
	bh=mwU5zOE/XJ1F1jzWeRupxHRSzxRVlATaw8iXNosKdOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUOgiQ1nUfR014Rgus4Da3QpP1/X5+iDh7G+qZkcY1rbRbO7QXfGWwzs/kUhUc9WelDiDNAzDYwaGm7XyqNCVL8ezTjq16FYIVe4yLatqF6Md/PM806juU1vuZz4wD859NwLDDKIuV3zX+s+cXo7KfxOAGAbM3c1+Pqmnmbf8wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOndj+ab; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b45edf2303so3971636f8f.2;
        Mon, 14 Jul 2025 10:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752515752; x=1753120552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fgw6uDOHjrf813uBjrfn70QGqdTxwVqRHSQB2eclZEU=;
        b=WOndj+absvQK+fc2czfxYn6uHf0fVUHXQsLLnjzrdnyZ92832R23STFWD9FCGzPhtM
         TnAaGaUYQyc0VWs20fzXT5zBHEcMxLJ/EUdK1tiI2M8tyEwduYrCPbQBIhpv8zjl4pEr
         NO07RzwmEQZDmyySMVwalPWOVyEvgIK+Quf/1HifahU2ujP5u3eGVH9xF77/hmH+/L0n
         3+p4csE8mIWj9X3MBr8Ob76EmEO20pd/SBNdOYUJSpF7F3/775rO9695yLIG6W4qU2Im
         V7thId8dr1y/8uq53sd5fDBOyckwaCZ5weqKaesxOVj1GbnB0UtA5O3HiBGXcWq5ljDB
         YJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752515752; x=1753120552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgw6uDOHjrf813uBjrfn70QGqdTxwVqRHSQB2eclZEU=;
        b=vzPAIIQR9Xky6L1XX4+ojV/BjVQAzv1+seupKrU1aj2W6YN8jgZZJaLT8OHWvR+UHp
         HEOguHiD8ELhotyOwncEBgnsHoO4H1l2ShQZnsashoABTZ6AtU3A03G4RbSrnovpjFcw
         KbpaCHGqhPaUIh0AgJWzLCAHHE9xAKA+DeM0jIqEx3pAdG6PvgErcQZwFYuiKsHeAJ7m
         orvtPujX4tTOrPZ+sT9MqFxvmhpyizubcRAZnRl1M7vajzWqDi2BosnOF/sBh8SDPQpH
         cgKwT7C+tVicIdtTRvaEstnA8anHJELqhCERlrAsw/94EhnXzHMAysZLKOhkjnDc5f1O
         lZhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2BuJxYEv2i76G3uNDPoSCNQYM5HsH39Kdt35SWxWzF9jlGGOS8J5pkQVBo9YhmY+qrbyuZNbFD1Y=@vger.kernel.org, AJvYcCXg3cGUFkX+6Z182ruWnmDxOym+bM5Ci901juPEvNyAPRj38VRF1qE7YoavS9TDT0caZxZcf6HhMH6S2Ur7@vger.kernel.org
X-Gm-Message-State: AOJu0YzN7q/eINx+qdG30AEA1G99oobWPokFszjtSDZ1i2fs7XmbY62V
	fl9MnU4mlUoI87xQGNE2xDBeYcLLMnwLtCmsOHnV77TnXunfS7tvlDl2
X-Gm-Gg: ASbGncvKZr7xrgYtwjJuir5Ye9/IRlyuUdudq7IMTR1V2mni9pr/gU2R8+LHVQNdd3r
	Py8RHutVzlL1RQyWfaHx+PpuO77II3d5XLxyEumnKMD2agCseyMvAeo0pJQnHoRdW44VQn6NORh
	rfK6gQYReKwNcpikEkpZCHwd4NP4dWtcWX8iM0jBjZHdkKy3/zF9xtMTG3TvJ46WRQLSXw+LWUw
	9VQF2lBrD6kOvew+K37UR8dxsg33UpOge1b3zEU0dHoBjXwvEqfHdYJYnz72lkiq8N8SUoWP2D5
	od7IAaEATtmTagFNHZlDDBgJJWZqUg2rb4DNxisPI0/x8yColSZg9lJj3/y0e5PFHfASSpoSvgb
	OnqtKCAB7QAoxp8Pcd0PY6qkb9C168dYJ29qbbYRmzAFrkUPFYRShWjsKE49Ps5ynA/EUyT/IDR
	RCdG8jDt/dQLW/wS0BMZkoxjo8HrO/oS5ujwQ6mhJEkRcLw0HnCMxKqZt1kpAqcQ==
X-Google-Smtp-Source: AGHT+IH21izMW/E1VReIQp5vspYpCuKuPI3c1UGz9OrPUhXi8Y1/QLjvtD3kcdezPtmx93SqstvmXQ==
X-Received: by 2002:a5d:588f:0:b0:3a5:2ef8:34f9 with SMTP id ffacd0b85a97d-3b5f188ea1fmr11952183f8f.27.1752515751481;
        Mon, 14 Jul 2025 10:55:51 -0700 (PDT)
Received: from thinkpad-p52.telekom.ip (2a02-8388-e103-2700-ebc0-27a3-cde8-9846.cable.dynamic.v6.surfer.at. [2a02:8388:e103:2700:ebc0:27a3:cde8:9846])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b600722780sm5338628f8f.23.2025.07.14.10.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 10:55:51 -0700 (PDT)
From: Andrei Lalaev <andrey.lalaev@gmail.com>
To: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: andrey.lalaev@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org
Subject: [RFC PATCH] can: gs_usb: fix kernel oops during restart
Date: Mon, 14 Jul 2025 19:55:02 +0200
Message-ID: <20250714175520.307467-1-andrey.lalaev@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CAN adapter in BUS_OFF state and "can_restart" is called,
it causes the following kernel oops:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  Internal error: Oops: 0000000086000005 [#1] PREEMPT SMP
  CPU: 0 UID: 0 PID: 725 Comm: ip Not tainted 6.12.37-v8-16k+ #2
  Hardware name: Raspberry Pi 5 Model B Rev 1.0 (DT)
  pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : 0x0
  lr : can_restart+0x80/0xf8 [can_dev]
  sp : ffffc000844f3700
  x29: ffffc000844f3710 x28: ffffd06fcf3389f8 x27: 0000000000000000
  x26: ffff800080ba0000 x25: 0000000000000000 x24: ffffd06f58730268
  x23: 0000000000000000 x22: 0000000000000001 x21: ffff8001001ef210
  x20: ffffc000844f3a10 x19: ffff800080ba0000 x18: 0000000000000000
  x17: 0000000000000002 x16: 000000005b38ca14 x15: 0000000000000400
  x14: 0000000000000800 x13: 000000005b482df7 x12: ffff800002d84280
  x11: 000000005b482df7 x10: ffff800002d84290 x9 : ffffd06fcf01f6ec
  x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
  x5 : ffffd06fcef8ab30 x4 : 0000000000000008 x3 : 016b3b57a19d7300
  x2 : 0000000000000088 x1 : 0000000000000001 x0 : ffff800080ba0000
  Call trace:
   0x0
   can_restart_now+0x4c/0x70 [can_dev]
   can_changelink+0x258/0x458 [can_dev]
   rtnl_newlink+0x52c/0xa38
   rtnetlink_rcv_msg+0x238/0x338
   netlink_rcv_skb+0x128/0x148
   rtnetlink_rcv+0x24/0x38
   netlink_unicast+0x24c/0x408
   netlink_sendmsg+0x288/0x378
   ____sys_sendmsg+0x1bc/0x2a0
   __sys_sendmsg+0x144/0x1a0
   __arm64_sys_sendmsg+0x30/0x48
   invoke_syscall+0x4c/0x110
   el0_svc_common+0x8c/0xf0
   do_el0_svc+0x28/0x40
   el0_svc+0x34/0xa0
   el0t_64_sync_handler+0x84/0x100
   el0t_64_sync+0x190/0x198

Provide a "do_set_mode" callback to overcome the issue.

Signed-off-by: Andrei Lalaev <andrey.lalaev@gmail.com>
---

The issue can be easily reproduced:
    ip link set can0 type can bitrate 100000
    ip link set up can0
    cangen can0

Then I force "BUS_OFF" by connecting CAN_HIGH to CAN_LOW.
And restart the interface:
    ip link set can0 type can restart


My knowledge about CAN is pretty limited, so I am not sure
if it is a correct or complete solution.

Could someone with more experience in CAN or the gs_usb driver confirm
whether this should be addressed by implementing the do_set_mode in gs_usb,
or if there's a better approach?

Thanks in advance!
---
 drivers/net/can/usb/gs_usb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index bb6335278e46..0d66d843c1e3 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -748,6 +748,18 @@ static int gs_usb_set_data_bittiming(struct net_device *netdev)
 				    GFP_KERNEL);
 }
 
+static int gs_usb_do_set_mode(struct net_device *netdev, enum can_mode mode)
+{
+	switch (mode) {
+	case CAN_MODE_START:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static void gs_usb_xmit_callback(struct urb *urb)
 {
 	struct gs_tx_context *txc = urb->context;
@@ -1278,6 +1290,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	dev->can.clock.freq = le32_to_cpu(bt_const.fclk_can);
 	dev->can.bittiming_const = &dev->bt_const;
 	dev->can.do_set_bittiming = gs_usb_set_bittiming;
+	dev->can.do_set_mode = gs_usb_do_set_mode;
 
 	dev->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
 
-- 
2.50.1


