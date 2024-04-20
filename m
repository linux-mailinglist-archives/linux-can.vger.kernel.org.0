Return-Path: <linux-can+bounces-450-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0458ABCF2
	for <lists+linux-can@lfdr.de>; Sat, 20 Apr 2024 21:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82BB1F21069
	for <lists+linux-can@lfdr.de>; Sat, 20 Apr 2024 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B649339B1;
	Sat, 20 Apr 2024 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="d01YWBXL";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iFAeVFha"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9974F8F6C
	for <linux-can@vger.kernel.org>; Sat, 20 Apr 2024 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713642514; cv=pass; b=YEruo7VlUASJe2ao5eOfPeSFYTNQyWze8XkYrqek2hqe1CMUNPemMyYvv+y0gb5Q6BBgIQ31wv1ZDb4iiuwPK+bCZN/4jPX5VsiBR6rctIjJfo2FgpGbKmmfA07D6R1Pua2RSz438xo1bx60qaN6nV1OCefHn/cK7qG7ubVBlwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713642514; c=relaxed/simple;
	bh=+im8ihR7CEpi4IV+/DiaGY4lNYQl2TowUWA6HwVEcI4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ph/x4Wjrun1rY4p73X222U1UKYkSWi3lIMkd+YcFguSTyu1utjY20zrvJ4lris3BmaBw2XMEIpNyBtVFEy57cp9YlTDWDy5u8kpY8KpHQmqMzxKXgnrC1v9dQkBqtklKAhOV7YR58Xz2YUofBku0UaB/rWFbcvzd6SXEKw4lsL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=d01YWBXL; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iFAeVFha; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1713642502; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lv+nKTrgieR9IBdTyVhyGVG1f0vRMHlDwPjNGcAQozIuc3u00ZB0JbhbpVrh90SKoV
    qG2NiZp7d2NRBJsW1WWU6HUxp7NxJc5HMW9Yl4J+q7k2SYj3Fb8J7pKrGsurPEjNstKJ
    X6fLG0G5CuuQKbTxVjSZM/xesUJPQ6GURaoA5AChWmVYyIMWZWlleljIsgGPXGkXAqta
    Tskz+VysGDFqz1mY3pABiXyKbRTsJJHB8j2Cn7voqjvIZzwckSshpi4l3m1s2pwnWBxs
    +iA1oBlsr7zamSbRkMUYr07EbTzVVZbGUzY3Nkg+CHHEDKGVJnJ2rkD4iwAqj8Bn6Wo7
    XFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1713642502;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=yVdKVDnRZxkgpb5/zyAUUQyOrIKkiJ1T+JqGCKlXHKc=;
    b=Ckhdwq5PW4ardt4NmM78mD9Y1k+ynyNTukz852ak1CAhEBGRWkl5cLMt1kJaNLk+nO
    8wlPlOBW/BBZRvYSllEXynD9HZ2r5zyHd9MN96H3fdKPCnjzoK9/BnodCUobtE9L8UZ4
    sbDN3biEmXzr3SBv7adwieIF7zrICHVlk3Q7f8ePXOzrp0AU8LmgAHSjzRWQc4k/xknQ
    gV4WHaRw2Yg/x88nfIdcsC+V8hNhlW3FnqkLaOB8Jy7E7+DMtjINhTCdvFCo/vb3FfV7
    MD2WWlvExOjlY/WD3ORVslTKItlcrYx5z8Udxgw8TN2cPNdZeNfz+WXUo5c1af3H4xfn
    rB1w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1713642502;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=yVdKVDnRZxkgpb5/zyAUUQyOrIKkiJ1T+JqGCKlXHKc=;
    b=d01YWBXLztOEfuFgAxoSL5kmFNmsvjBd1I99Zqs4FbOCS+dbcJ/RyLFBDSNmLfnMYC
    JlxGrQNnSUrjRPQx6fUT9GBO1M1g4TODnIzDHKxYm9kRLke5zn5uFUx+Cri0yVX6QUuX
    j9j6ApN56m2z7ewhPifKL7nDdZ1dZMHVW1Z+SR0cw9pQsIAtkFTkVkEAG7to7+NCKJKS
    nkOYS2RR3jlK96UoT85TxERdYpHAJII2lpmcvNayTQs1LpSCiZ+hqoffbqlgSLiYNDqu
    OUhiGECIPKLICpFFGIeVnUQiGxAB5pJaIJ9P8DAiZdlTBULvW2phfoTy2LEVo4nXSLIK
    5l7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1713642502;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=yVdKVDnRZxkgpb5/zyAUUQyOrIKkiJ1T+JqGCKlXHKc=;
    b=iFAeVFhaHTA2M5gmV64OwgPxwy19WILz+pkuWZJjVQE89xPDtEln/3a5o7RrbbiMiZ
    /KjaGVMxoKKf9Uu5ljCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejubJjM/tkA="
Received: from silver.lan
    by smtp.strato.de (RZmta 50.3.2 DYNA|AUTH)
    with ESMTPSA id K701d603KJmMhAw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 20 Apr 2024 21:48:22 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: isotp: remove ISO 15675-2 specification version where possible
Date: Sat, 20 Apr 2024 21:47:46 +0200
Message-Id: <20240420194746.4885-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

With the new ISO 15765-2:2024 release the former documentation and comments
have to be reworked. This patch removes the ISO specification version/date
where possible.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/isotp.h |  2 +-
 net/can/Kconfig                | 11 +++++------
 net/can/isotp.c                | 11 ++++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/can/isotp.h b/include/uapi/linux/can/isotp.h
index 6cde62371b6f..bd990917f7c4 100644
--- a/include/uapi/linux/can/isotp.h
+++ b/include/uapi/linux/can/isotp.h
@@ -1,10 +1,10 @@
 /* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * linux/can/isotp.h
  *
- * Definitions for isotp CAN sockets (ISO 15765-2:2016)
+ * Definitions for ISO 15765-2 CAN transport protocol sockets
  *
  * Copyright (c) 2020 Volkswagen Group Electronic Research
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/net/can/Kconfig b/net/can/Kconfig
index cb56be8e3862..af64a6f76458 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -54,20 +54,19 @@ config CAN_GW
 	  by the netlink configuration interface known e.g. from iptables.
 
 source "net/can/j1939/Kconfig"
 
 config CAN_ISOTP
-	tristate "ISO 15765-2:2016 CAN transport protocol"
+	tristate "ISO 15765-2 CAN transport protocol"
 	help
 	  CAN Transport Protocols offer support for segmented Point-to-Point
 	  communication between CAN nodes via two defined CAN Identifiers.
+	  This protocol driver implements segmented data transfers for CAN CC
+	  (aka Classical CAN, CAN 2.0B) and CAN FD frame types which were
+	  introduced with ISO 15765-2:2016.
 	  As CAN frames can only transport a small amount of data bytes
-	  (max. 8 bytes for 'classic' CAN and max. 64 bytes for CAN FD) this
+	  (max. 8 bytes for CAN CC and max. 64 bytes for CAN FD) this
 	  segmentation is needed to transport longer Protocol Data Units (PDU)
 	  as needed e.g. for vehicle diagnosis (UDS, ISO 14229) or IP-over-CAN
 	  traffic.
-	  This protocol driver implements data transfers according to
-	  ISO 15765-2:2016 for 'classic' CAN and CAN FD frame types.
-	  If you want to perform automotive vehicle diagnostic services (UDS),
-	  say 'y'.
 
 endif
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 25bac0fafc83..16046931542a 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -70,25 +70,26 @@
 #include <linux/can/isotp.h>
 #include <linux/slab.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
-MODULE_DESCRIPTION("PF_CAN isotp 15765-2:2016 protocol");
+MODULE_DESCRIPTION("PF_CAN ISO 15765-2 transport protocol");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Oliver Hartkopp <socketcan@hartkopp.net>");
 MODULE_ALIAS("can-proto-6");
 
 #define ISOTP_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_addr.tp)
 
 #define SINGLE_MASK(id) (((id) & CAN_EFF_FLAG) ? \
 			 (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG) : \
 			 (CAN_SFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG))
 
-/* ISO 15765-2:2016 supports more than 4095 byte per ISO PDU as the FF_DL can
- * take full 32 bit values (4 Gbyte). We would need some good concept to handle
- * this between user space and kernel space. For now set the static buffer to
- * something about 8 kbyte to be able to test this new functionality.
+/* Since ISO 15765-2:2016 the CAN isotp protocol supports more than 4095
+ * byte per ISO PDU as the FF_DL can take full 32 bit values (4 Gbyte).
+ * We would need some good concept to handle this between user space and
+ * kernel space. For now set the static buffer to something about 8 kbyte
+ * to be able to test this new functionality.
  */
 #define DEFAULT_MAX_PDU_SIZE 8300
 
 /* maximum PDU size before ISO 15765-2:2016 extension was 4095 */
 #define MAX_12BIT_PDU_SIZE 4095
-- 
2.39.2


