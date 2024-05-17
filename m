Return-Path: <linux-can+bounces-645-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608C78C8051
	for <lists+linux-can@lfdr.de>; Fri, 17 May 2024 06:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 490F2B212E2
	for <lists+linux-can@lfdr.de>; Fri, 17 May 2024 04:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976C1D524;
	Fri, 17 May 2024 04:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0OAoH6+"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C19C133
	for <linux-can@vger.kernel.org>; Fri, 17 May 2024 04:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715918412; cv=none; b=TfgoGKeVNeLgI7LirrNSsznfVmNOwHYbkOhpEkjrPqlBIJ9kWwknlnb2RoxA1Mj5weZc+CCx5Dzqay2SCZLL1wSjY0HOZHZV02vHkuCKB7JRpWKN/U4Y4rXZrSs2sqQ+bDxRiinJq0fK2Yi/URWXXGesiA1KOlTpVqAltc4EJNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715918412; c=relaxed/simple;
	bh=nddJiAshhaYciE9alG0dmxkyv2LV7P9bCPCUGTfhZJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PKb3zth1I3WCh9ABocni5NsvyCElnNU/lTT3LvKXGgfMy6rNUn+oTj7ZtQO1lfzwOKsVrDpT+3PqBel6DkwqFqlqh+vYdiM1BpyVy1/wXshA6uvCEj5XOMxQxQtnSO/mG350aedCmFOFCBjXmO96VEIexsodMphSTffWW7sBA+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0OAoH6+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715918409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vj1TP/1geZ0Mi/2kIA4CaLjc5P3+h4UYT86CXN80Sd4=;
	b=X0OAoH6+LfXpEOpv+EcZF0vnNdub+kiOL18D2771pDPIpzYm31Bx5gURgJSKJ7Nkl8nAp6
	cNgWpA0VRr7ShWmImAMFPMi/YkceRYCbdYJNuT2tEYl8uujZX6sTdv/LCqiDZfL0DWwp5r
	AoJIU8ysgo58ECiMYCK8I/nK2BMncmg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-hFTALRQCMGqa78ECnOP-xw-1; Fri, 17 May 2024 00:00:05 -0400
X-MC-Unique: hFTALRQCMGqa78ECnOP-xw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ec896dae3cso89134255ad.0
        for <linux-can@vger.kernel.org>; Thu, 16 May 2024 21:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715918404; x=1716523204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vj1TP/1geZ0Mi/2kIA4CaLjc5P3+h4UYT86CXN80Sd4=;
        b=NlcjFeLriK/nA0hpDowAkhPLpTEZCvycsMxY4nfo4i5yymcu1xF9pOipV8wmR5WDAy
         Cta0XjOWhoiwQKjo9tXbtJWpJoJzEUwwnuePKj8a5CZEeGpjoecZtqLt5ulKj7wO3hVV
         L4AviZkx2Je9sFoqw7KUX/jn3uPUovwV22LX/kldGCRqX0fhKBITLu3jUvKvZ9t2kBng
         28CDpdk5iwXy3NdKx88h93n7CXhHC26QvLGnV643yKmguNkYQtpVbqaA6hF4hfji/ZOi
         LN7226rbHPlpLflU+ULX0HX8zoeAxWkzSM6KdRS/p9useTmIefRJJ5Rs9Wlw/vVsvUFc
         D98Q==
X-Gm-Message-State: AOJu0YwpvD9eSHARfY1nhyksV9Y7nlggohVGdpfKB3KxN7uIW+UoYmQ4
	GYiOfnyMDBKxL37PCXrUlyKb3PmfXIJPEnRAfxpUJIfp0WQJhrukNFUW3jdNkP/nyf6l8ZKzLOO
	bh95JkMOr1hqjx2oWceNh66cpWRKWOk/99qAGAr0glcwKqkFQxfhMHR1sww==
X-Received: by 2002:a17:903:2342:b0:1f1:e125:f870 with SMTP id d9443c01a7336-1f1e125fba0mr38177465ad.40.1715918404148;
        Thu, 16 May 2024 21:00:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVxLbjvnrVXbXzZgYxLtqzvZmdRnRijXtNofDXGN2kgDQsoDTpg5Oznhu0oPpfbtZDNloGcA==
X-Received: by 2002:a17:903:2342:b0:1f1:e125:f870 with SMTP id d9443c01a7336-1f1e125fba0mr38177095ad.40.1715918403538;
        Thu, 16 May 2024 21:00:03 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:6883:65ff:fe1c:cf69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a93sm149492065ad.134.2024.05.16.21.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 21:00:03 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: robin@protonic.nl,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com
Subject: [PATCH v2] can: j1939: Initialize unused data in j1939_send_one()
Date: Fri, 17 May 2024 12:59:53 +0900
Message-ID: <20240517035953.2617090-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported kernel-infoleak in raw_recvmsg() [1]. j1939_send_one()
creates full frame including unused data, but it doesn't initialize it.
This causes the kernel-infoleak issue. Fix this by initializing unused
data.

[1]
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:29 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:271 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x366/0x2520 lib/iov_iter.c:185
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copy_to_user_iter lib/iov_iter.c:24 [inline]
 iterate_ubuf include/linux/iov_iter.h:29 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 _copy_to_iter+0x366/0x2520 lib/iov_iter.c:185
 copy_to_iter include/linux/uio.h:196 [inline]
 memcpy_to_msg include/linux/skbuff.h:4113 [inline]
 raw_recvmsg+0x2b8/0x9e0 net/can/raw.c:1008
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x2c4/0x340 net/socket.c:1068
 ____sys_recvmsg+0x18a/0x620 net/socket.c:2803
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 do_recvmmsg+0x4fc/0xfd0 net/socket.c:2939
 __sys_recvmmsg net/socket.c:3018 [inline]
 __do_sys_recvmmsg net/socket.c:3041 [inline]
 __se_sys_recvmmsg net/socket.c:3034 [inline]
 __x64_sys_recvmmsg+0x397/0x490 net/socket.c:3034
 x64_sys_call+0xf6c/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:300
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x613/0xc50 mm/slub.c:3888
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
 __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1313 [inline]
 alloc_skb_with_frags+0xc8/0xbf0 net/core/skbuff.c:6504
 sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2795
 sock_alloc_send_skb include/net/sock.h:1842 [inline]
 j1939_sk_alloc_skb net/can/j1939/socket.c:878 [inline]
 j1939_sk_send_loop net/can/j1939/socket.c:1142 [inline]
 j1939_sk_sendmsg+0xc0a/0x2730 net/can/j1939/socket.c:1277
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:745
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2674
 x64_sys_call+0xc4b/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 12-15 of 16 are uninitialized
Memory access of size 16 starts at ffff888120969690
Data copied to user address 00000000200017c0

CPU: 1 PID: 5050 Comm: syz-executor198 Not tainted 6.9.0-rc5-syzkaller-00031-g71b1543c83d6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Reported-and-tested-by: syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5681e40d297b30f5b513
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
v1->v2: https://lore.kernel.org/linux-can/20240512160307.2604215-1-syoshida@redhat.com/
- Use skb_put_zero() instead of memset() and skb_put().
- Remove J1939_CAN_FTR macro.
---
 net/can/j1939/main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index a6fb89fa6278..7e8a20f2fc42 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -30,10 +30,6 @@ MODULE_ALIAS("can-proto-" __stringify(CAN_J1939));
 /* CAN_HDR: #bytes before can_frame data part */
 #define J1939_CAN_HDR (offsetof(struct can_frame, data))
 
-/* CAN_FTR: #bytes beyond data part */
-#define J1939_CAN_FTR (sizeof(struct can_frame) - J1939_CAN_HDR - \
-		 sizeof(((struct can_frame *)0)->data))
-
 /* lowest layer */
 static void j1939_can_recv(struct sk_buff *iskb, void *data)
 {
@@ -342,7 +338,7 @@ int j1939_send_one(struct j1939_priv *priv, struct sk_buff *skb)
 	memset(cf, 0, J1939_CAN_HDR);
 
 	/* make it a full can frame again */
-	skb_put(skb, J1939_CAN_FTR + (8 - dlc));
+	skb_put_zero(skb, 8 - dlc);
 
 	canid = CAN_EFF_FLAG |
 		(skcb->priority << 26) |
-- 
2.44.0


