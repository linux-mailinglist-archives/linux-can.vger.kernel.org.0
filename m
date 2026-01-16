Return-Path: <linux-can+bounces-6175-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7D4D3148F
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 13:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FAC7300D176
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 12:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0726C22A7F1;
	Fri, 16 Jan 2026 12:44:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C36221277
	for <linux-can@vger.kernel.org>; Fri, 16 Jan 2026 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768567478; cv=none; b=bLCMmfUa1GCaTZZvfsoZc0Sw0BURK4jU/Wh3+wGM2KOvlPhXvSCzoB0ngU6I5U3oS8SP/+mNXRpPEwBBku0ao/ZFYe28ufOGaYT+0aaH2PwPHEuNLOP4Ep6QSxT3tDR7I5kDhFm+Qf/KDXshHdmnE0xyaZqVVHoOknyCu1JkEn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768567478; c=relaxed/simple;
	bh=zb2VeVvEeqMhrQBn5j3z9FcDbi0c1AklqGFjC2EUsUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sYZ8A+Ya6LKWN352qPYKxEW/RqDzflpilNgA5kbyPcjIpx9bb1pp4K9csiYZ5UvVvJDkCc+tnLAqB1GkoUbMlQMlcsXXX4Rfo5L35234ApQKH8HvwScN9Mc1/qwdMV+H1YFg8Kd2P9CltrLqvmCjYvBWwtwpQT4yFrdwQlhPzrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgjBk-0006dX-71; Fri, 16 Jan 2026 13:44:28 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgjBk-000v4d-1e;
	Fri, 16 Jan 2026 13:44:27 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 863E04CEA4E;
	Fri, 16 Jan 2026 12:44:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 16 Jan 2026 13:44:22 +0100
Subject: [PATCH] can: dev: alloc_candev_mqs(): add missing default CAN
 capabilitied
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-can_add_missing_set_caps-v1-1-7525126d8b20@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAKUyamkC/yXMQQqDMBBA0avIrBswEaJ4FSlhmpnqCI2SsaUg3
 t3ULt/i/x2Us7BCX+2Q+SMqSyqwtwrihGlkI1QMrna+ttabiCkgUXiJqqQxKG8h4qqm6TrvWiZ
 C20DJ18xP+V7r4f63vh8zx+33g+M4AdMayKV8AAAA
X-Change-ID: 20260116-can_add_missing_set_caps-388627edda13
To: Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=zb2VeVvEeqMhrQBn5j3z9FcDbi0c1AklqGFjC2EUsUQ=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpajKoW77ENzD3XV+J2Qp+Tj07glVeIKfGi9waV
 TLErDZAsuyJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaWoyqAAKCRAMdGXf+ZCR
 nEQ3B/wNVRZyhOAOCM8abyWuibmqYgwT/9cQQP4GXfSgI5WEP+kcCn1nEmPDy+Sx0b+/fyr/5Fv
 /AmduXsT3Ed2fvO5hsVjcvuFnhbLPiN3zNzmFZPDsVKEZJ28jhyeDYZOv9a35DPRJwJoaQDLApO
 VSlfcmGHSVaq5sdV6vGcaq41r5cdHUDDig52Tqwl9y13/qYeXCwcKrud8oC332b2LnaF4yIzzHV
 EeEig4R/VySxfd6AfvzVIro7QiduswZXxpxfvvY4k7rU7VMRZ1rT7Ntck38fdUhJc5fsga6e3Xx
 s4TmTUqy7uEbdROqYJK2NMmG9UWJwcxSrSMuUnSnI+iB+gDo
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The idea behind series 6c1f5146b214 ("Merge patch series "can: raw: better
approach to instantly reject unsupported CAN frames"") is to set the
capabilities of a CAN device (CAN-CC, CAN-FD, CAN-XL, and listen only) [1]
and, based on these capabilities, reject unsupported CAN frames in the
CAN-RAW protocol [2].

This works perfectly for CAN devices configured in CAN-FD or CAN-XL mode.
CAN devices with static CAN control modes define their capabilities via
can_set_static_ctrlmode() -> can_set_cap_info(). CAN devices configured by
the user space for CAN-FD or CAN-XL set their capabilities via
can_changelink() -> can_ctrlmode_changelink() -> can_set_cap_info().

However, in commit 166e87329ce6 ("can: propagate CAN device capabilities
via ml_priv"), the capabilities of CAN devices are not initialized.
This results in CAN-RAW rejecting all CAN frames on devices directly
after ifup if the user space has not changed the CAN control mode.

Fix this problem by setting the default capabilities to CAN-CC in
alloc_candev_mqs() as soon as the CAN specific ml_priv is allocated.

[1] commit 166e87329ce6 ("can: propagate CAN device capabilities via ml_priv")
[2] commit faba5860fcf9 ("can: raw: instantly reject disabled CAN frames")

Fixes: 166e87329ce6 ("can: propagate CAN device capabilities via ml_priv")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 7ab9578f5b89..769745e22a3c 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -332,6 +332,7 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 
 	can_ml = (void *)priv + ALIGN(sizeof_priv, NETDEV_ALIGN);
 	can_set_ml_priv(dev, can_ml);
+	can_set_cap(dev, CAN_CAP_CC);
 
 	if (echo_skb_max) {
 		priv->echo_skb_max = echo_skb_max;

---
base-commit: a74c7a58ca2ca1cbb93f4c01421cf24b8642b962
change-id: 20260116-can_add_missing_set_caps-388627edda13

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>


