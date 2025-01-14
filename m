Return-Path: <linux-can+bounces-2643-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB08EA10A95
	for <lists+linux-can@lfdr.de>; Tue, 14 Jan 2025 16:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 218A37A2509
	for <lists+linux-can@lfdr.de>; Tue, 14 Jan 2025 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563E915383E;
	Tue, 14 Jan 2025 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="pn3H4zqe"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991C23242C;
	Tue, 14 Jan 2025 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868127; cv=none; b=XlpIlLF59LJyxK78RmN340OBzn1zwVrQYkZOzQ51QuSjfALqOqoGXZuGuPBf6Bt4BkdPQDnqYiOLU+wmgOvDfNDGgjt/hgdpzV5vGIXKDPxC2CnJRnD8ipb1egnzrJAnl7bmM/cmh4NfZBBG4y2PCBEhEZucchBEYI1hjdJFn48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868127; c=relaxed/simple;
	bh=tY8dMeDzGGW1YhnJ7/+C2YKBsYrhXhs1/ry9iF11o5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kl83zsKu2fyZD/HacS2f7U8uY7e1uNKsbV727ylPSdILNtJ5LdtsJMjQsOVW+czp5NLiXNUpndjMfWveeC5317eoqkhqTLzbMYb3LiBhGCk8v1J6s9oWOo4Gx6A8yqIyFAKmi7LosXO9bZ4CjlNV9nV/PjK0AIWlmirWiusdFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=pn3H4zqe; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id D095340762DC;
	Tue, 14 Jan 2025 15:21:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D095340762DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1736868114;
	bh=d+8PrYkFEoEPJAxdvFR/cQxb3R12CtlEo+IXVFiml9s=;
	h=From:To:Cc:Subject:Date:From;
	b=pn3H4zqe/OPdBKEz91hKBGtBN8c/ZIqfLeQtkgFlRDaxZ6tpIPfsDyGfAzeNheB0A
	 3GKqnFWan9PXUOQftBkKNA3x+5N/UtJA6EZKDNLupWAMZ8iaTKqk/sMpq0nTdwP6SS
	 A4G4xIRN/E/nmfwUpKHy0TlF87aNRKmNqGjApTS4=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Ondrej Ille <ondrej.ille@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Martin Jerabek <martin.jerabek01@gmail.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] can: ctucanfd: handle skb allocation failure
Date: Tue, 14 Jan 2025 18:21:38 +0300
Message-Id: <20250114152138.139580-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If skb allocation fails, the pointer to struct can_frame is NULL. This
is actually handled everywhere inside ctucan_err_interrupt() except for
the only place.

Add the missed NULL check.

Found by Linux Verification Center (linuxtesting.org) with SVACE static
analysis tool.

Fixes: 2dcb8e8782d8 ("can: ctucanfd: add support for CTU CAN FD open-source IP core - bus independent part.")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 64c349fd4600..f65c1a1e05cc 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -867,10 +867,12 @@ static void ctucan_err_interrupt(struct net_device *ndev, u32 isr)
 			}
 			break;
 		case CAN_STATE_ERROR_ACTIVE:
-			cf->can_id |= CAN_ERR_CNT;
-			cf->data[1] = CAN_ERR_CRTL_ACTIVE;
-			cf->data[6] = bec.txerr;
-			cf->data[7] = bec.rxerr;
+			if (skb) {
+				cf->can_id |= CAN_ERR_CNT;
+				cf->data[1] = CAN_ERR_CRTL_ACTIVE;
+				cf->data[6] = bec.txerr;
+				cf->data[7] = bec.rxerr;
+			}
 			break;
 		default:
 			netdev_warn(ndev, "unhandled error state (%d:%s)!\n",
-- 
2.39.5


