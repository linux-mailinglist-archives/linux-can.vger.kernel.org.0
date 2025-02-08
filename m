Return-Path: <linux-can+bounces-2767-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E4AA2D5E5
	for <lists+linux-can@lfdr.de>; Sat,  8 Feb 2025 12:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53713A72C8
	for <lists+linux-can@lfdr.de>; Sat,  8 Feb 2025 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFF424635F;
	Sat,  8 Feb 2025 11:51:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97841DA0E0
	for <linux-can@vger.kernel.org>; Sat,  8 Feb 2025 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739015495; cv=none; b=O6QIJYTUQvj3cYVYnvo19d/9u+RZNlqDoefK06zs/G5EFrPdN8SV/9LIA8l9oWyGjBfbGBsrbE/oRWw6RtT55mpJRI/f6/y/OW0+zGStl7v8Kc8/KmAghuahDcc/3Nc4pbiARc0a72ue6pRsGZ+ilElO6zpcxphtYBvYeNMWHDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739015495; c=relaxed/simple;
	bh=dpzS/VME843MUUiK6GnZRk9jdInveTfG5Q6zt2pkRNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SicHVVnyNoXDY8eH0Bzr+YU8c6HHtrKBZWjq6Nrnbph2feoxHavqEhlUw75cR4akfrr1oFnQXJ0sqzX86IEEk3T9EZXOZNkiCvy2L89EQwIWApcgA/Wg4WWIDAZJEI063lSdyo4KnwncHc3Po7gT2rh20VtpEiMzwoblhkMZrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tgjMy-0006n5-B3
	for linux-can@vger.kernel.org; Sat, 08 Feb 2025 12:51:32 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tgjMy-0048M6-0Q
	for linux-can@vger.kernel.org;
	Sat, 08 Feb 2025 12:51:32 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id BD7AF3BCCDA
	for <linux-can@vger.kernel.org>; Sat, 08 Feb 2025 11:51:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id EB2623BCCBE;
	Sat, 08 Feb 2025 11:51:27 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 071163ab;
	Sat, 8 Feb 2025 11:51:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	stable@vger.kernel.org,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 3/6] can: ctucanfd: handle skb allocation failure
Date: Sat,  8 Feb 2025 12:45:16 +0100
Message-ID: <20250208115120.237274-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208115120.237274-1-mkl@pengutronix.de>
References: <20250208115120.237274-1-mkl@pengutronix.de>
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

From: Fedor Pchelkin <pchelkin@ispras.ru>

If skb allocation fails, the pointer to struct can_frame is NULL. This
is actually handled everywhere inside ctucan_err_interrupt() except for
the only place.

Add the missed NULL check.

Found by Linux Verification Center (linuxtesting.org) with SVACE static
analysis tool.

Fixes: 2dcb8e8782d8 ("can: ctucanfd: add support for CTU CAN FD open-source IP core - bus independent part.")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250114152138.139580-1-pchelkin@ispras.ru
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
2.47.2



