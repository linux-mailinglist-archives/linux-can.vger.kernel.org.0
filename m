Return-Path: <linux-can+bounces-5680-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31104C89390
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 11:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6823B52A1
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037012DF137;
	Wed, 26 Nov 2025 10:17:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AF32BEC41
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152222; cv=none; b=GlChAs6jbD1oB7SsuJvxkL+FaTqEk8aZZp3b5lG1hu67uvlWCUFBmx327EfeJdTpB2YKlTVpvYySHmVzdFeM2nfgty5DecGw0xyK6llc6Pb8NTha+XoBD8+bfpo6bvjLMWYCRjdCRGoAxeHyYXBApBXSPm1rsGjbWsl5m3u3lBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152222; c=relaxed/simple;
	bh=W884lVKQwWsf/tja4shHUArOad+EqepbzgqQ3lgcujc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GThZqyC5N5uw1dNl4rdN53mn9F8dHmeuODW4oFkkvGEkd1qw0pXTpDT7WpSjfx4Rl71OwT3IUkBmcrE09rYg95NrN+Q/MXUwdH8iFtYZLCnWDezDUK32IGim77b/P0q0nT1jPcf7JTz3sy8wma5G4RsDW7NyxrPRmLPDoGu2bys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZv-0000Qi-7Y; Wed, 26 Nov 2025 11:16:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZu-002aSc-36;
	Wed, 26 Nov 2025 11:16:50 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AD5094A88D4;
	Wed, 26 Nov 2025 10:16:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 26 Nov 2025 11:16:04 +0100
Subject: [PATCH can-next v8 03/17] can: dev: can_dev_dropped_skb: drop CAN
 FD skbs if FD is off
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-canxl-v8-3-e7e3eb74f889@pengutronix.de>
References: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
In-Reply-To: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2077; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=rf6FlRWB6bK0fuKEFXr+UILKSuqKX6sPqVaAFGkTCss=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpJtN3n3PPLyAE+5JOXvX72EyjXcSURlFssV+WA
 i4T9sXWbYiJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaSbTdwAKCRAMdGXf+ZCR
 nEJQB/4/TmLaglNqLvK0JyAqFnlkXGL+PcR+4F5hn42Uf+Y2wJyOz4n6+slJrBX1DALbmlarHoi
 lbcHdjxQcsr1AbhAVsyhfMCESd5MZmUEEXHjKr4MahNlYqGMaJ987w7AaxvUNILkhFTC7dXNSp6
 42ebz1Lu1CBW1QMRmqRc1LoD6AjzAzM27TvYeCxdZatvHk5Rjuu3YEfDTkr7AV7XsUPUH7u9eg9
 RdMbV2/GH/+tKKjOmIRKqDl+efbIgRAE53lkDdrAhzWuUveDrsbnWirgxIQyCI8wS41Vdq1Ponj
 0DmEr5324WemwWGLQ+zVEsV3mMhnlholrq9+9qkljQM8+wSg
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol@kernel.org>

Currently, the CAN FD skb validation logic is based on the MTU: the
interface is deemed FD capable if and only if its MTU is greater or
equal to CANFD_MTU.

This logic is showing its limit with the introduction of CAN XL. For
example, consider the two scenarios below:

  1. An interface configured with CAN FD on and CAN XL on

  2. An interface configured with CAN FD off and CAN XL on

In those two scenarios, the interfaces would have the same MTU:

  CANXL_MTU

making it impossible to differentiate which one has CAN FD turned on
and which one has it off.

Because of the limitation, the only non-UAPI-breaking workaround is to
do the check at the device level using the can_priv->ctrlmode flags.
Unfortunately, the virtual interfaces (vcan, vxcan), which do not have
a can_priv, are left behind.

Add a check on the CAN_CTRLMODE_FD flag in can_dev_dropped_skb() and
drop FD frames whenever the feature is turned off.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/dev.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index bd7410b5d8a6..a7a39a6101d9 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -103,12 +103,20 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 	if (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY) {
 		netdev_info_once(dev,
 				 "interface in listen only mode, dropping skb\n");
-		kfree_skb(skb);
-		dev->stats.tx_dropped++;
-		return true;
+		goto invalid_skb;
+	}
+
+	if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb)) {
+		netdev_info_once(dev, "CAN FD is disabled, dropping skb\n");
+		goto invalid_skb;
 	}
 
 	return can_dropped_invalid_skb(dev, skb);
+
+invalid_skb:
+	kfree_skb(skb);
+	dev->stats.tx_dropped++;
+	return true;
 }
 
 void can_setup(struct net_device *dev);

-- 
2.51.0


