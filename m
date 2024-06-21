Return-Path: <linux-can+bounces-808-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C79911E0A
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B281C20BDC
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6383B17166E;
	Fri, 21 Jun 2024 08:02:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A0917108F
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956934; cv=none; b=HsaRtPcR4yZujtfZTuT0PwGccQnVhS6V3aRgL3vOtCsvERKgXR2lg8WnVVfkKjLyaUfjiaqkUa3DmwIvBEcNOI3398jg1Gtlo6HMWEYYbD49QKEOlp3BUYi0R4uOsKTk9YDDKe8IZ+AcLlEEAog21WNSZAfZ8rl9TZ1Utms88XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956934; c=relaxed/simple;
	bh=0BWcabB/rBWHDKBy1RgiXzIvY1BjX6CbtNEt9VUbGAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYkiPZPwLXEvXXA25dmu6W+dduH6ETEvrGOSIKBKX6O5xapq1wTvjigRCUxFDETw/Kpj1p8qqPkOk5RCaC3t+14QY5H6vb1LVUB4ccemLtd8s2iwaEl8w+KVnFbjI/R5xUv2//wyvH4ZLhocf4xJvtDetEDR7x4SV4JZXBVOtck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDm-00041Q-BJ
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:10 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDi-003tIS-2O
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 91E422EE3EF
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E9AC72EE393;
	Fri, 21 Jun 2024 08:02:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c192935a;
	Fri, 21 Jun 2024 08:02:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Francesco Valla <valla.francesco@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 05/24] can: isotp: remove ISO 15675-2 specification version where possible
Date: Fri, 21 Jun 2024 09:48:25 +0200
Message-ID: <20240621080201.305471-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621080201.305471-1-mkl@pengutronix.de>
References: <20240621080201.305471-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

With the new ISO 15765-2:2024 release the former documentation and comments
have to be reworked. This patch removes the ISO specification version/date
where possible.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Acked-by: Francesco Valla <valla.francesco@gmail.com>
Link: https://lore.kernel.org/all/20240420194746.4885-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/uapi/linux/can/isotp.h |  2 +-
 net/can/Kconfig                | 11 +++++------
 net/can/isotp.c                | 11 ++++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/can/isotp.h b/include/uapi/linux/can/isotp.h
index 6cde62371b6f..bd990917f7c4 100644
--- a/include/uapi/linux/can/isotp.h
+++ b/include/uapi/linux/can/isotp.h
@@ -2,7 +2,7 @@
 /*
  * linux/can/isotp.h
  *
- * Definitions for isotp CAN sockets (ISO 15765-2:2016)
+ * Definitions for ISO 15765-2 CAN transport protocol sockets
  *
  * Copyright (c) 2020 Volkswagen Group Electronic Research
  * All rights reserved.
diff --git a/net/can/Kconfig b/net/can/Kconfig
index cb56be8e3862..af64a6f76458 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -56,18 +56,17 @@ config CAN_GW
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
@@ -72,7 +72,7 @@
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
-MODULE_DESCRIPTION("PF_CAN isotp 15765-2:2016 protocol");
+MODULE_DESCRIPTION("PF_CAN ISO 15765-2 transport protocol");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Oliver Hartkopp <socketcan@hartkopp.net>");
 MODULE_ALIAS("can-proto-6");
@@ -83,10 +83,11 @@ MODULE_ALIAS("can-proto-6");
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
 
-- 
2.43.0



