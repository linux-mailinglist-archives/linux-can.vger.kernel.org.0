Return-Path: <linux-can+bounces-4006-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CABDB0A091
	for <lists+linux-can@lfdr.de>; Fri, 18 Jul 2025 12:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C47B1C45636
	for <lists+linux-can@lfdr.de>; Fri, 18 Jul 2025 10:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA893221297;
	Fri, 18 Jul 2025 10:25:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885F0BA27
	for <linux-can@vger.kernel.org>; Fri, 18 Jul 2025 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834332; cv=none; b=TWA2nKCGy0uGk325n7WaUgPZlQl5JlzoMWVMUrl5zt8dTfOoyAFZOWoOUkqAlsm5gmX5GffteLp+oXegQNhg6ht7r9otIeVAZT7hxV3Bmi1RpnzJaIj0MimRyL66qmrtGl4r/+tGQV9fPVC/ZUrYus+/YamE8MNUWqEw/U+jas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834332; c=relaxed/simple;
	bh=qNE9wLDTFXMwp9fzZM9ne/Fm+Fc2E6AjG/ELEOQX794=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Sy/4FdkNdi8kow5wiKxa6A7VnCe9O+FiJyRYWPBIOt/4pIBa5wTVB2ZpmgZODnt+YVncI5NGuHZW7tbUXOIvgd7fptx/62xZYJkEr1fspmRYvTjPtJv271rMFevq5GAvpeodrmeZAFoTBgYNm4DgcjoHPzSnsRiww67VRGp+rGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:f503:3ec1:5510:4857])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 8F275687DB1
	for <linux-can@vger.kernel.org>; Fri, 18 Jul 2025 10:19:08 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5D0434443C7
	for <linux-can@vger.kernel.org>; Fri, 18 Jul 2025 10:19:08 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 2C0654443C2;
	Fri, 18 Jul 2025 10:19:07 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d3fbd0ef;
	Fri, 18 Jul 2025 10:19:06 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 18 Jul 2025 12:19:03 +0200
Subject: [PATCH can] can: netlink: can_changelink(): fix NULL pointer deref
 of struct can_priv::do_set_mode
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-fix-nullptr-deref-do_set_mode-v1-1-0b520097bb96@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAJYfemgC/x3MUQqDMBBF0a3IfHcgSqXiVkoRm3mjAzaRRIsg7
 r2hnwcu96SMZMjUVyclfC1bDAX1rSI/j2ECmxRT45rWPeqO1Q4O+7KsW2JBgrLEIWMbPlHAIq5
 9K7y7q1J5rCWw4/9/kh8Dva7rB79g6ml0AAAA
X-Change-ID: 20250718-fix-nullptr-deref-do_set_mode-dd05bfec04ff
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Andrei Lalaev <andrey.lalaev@gmail.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=3632; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=qNE9wLDTFXMwp9fzZM9ne/Fm+Fc2E6AjG/ELEOQX794=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoeh+XmgUGz7cFVgGZMH/eRRIak97jrIxwZGglR
 RFUKIqYIRWJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaHoflwAKCRAMdGXf+ZCR
 nCnXB/90Z/76d6D1VU0/feRXBQUVH02AfZAkAEso3km3715Gammqzf3/hX0wQsJrvh+yy7uEuRn
 TJzlaoj3LLH6JLslNMJhMo1znCKTdUMj+6aFG55cfGYF0HlCF+su8Mu0FfCJ3bzMIl4MgVMZiWe
 d1vB4ziKn5nQka0YcCu8UE2WPiDbDxlJXRWXKE1+zm0ucBoPJ8jtovs6d15kM7a7b0h8NmTdXAR
 zSW+SLSyWafDGtwvVTKXGDnlHKXnNTxoOU5NjgN9My6j/84RZwhQZrQArQG1TL/UmwM9YpRT88g
 AaGdTrUKv4caVD93rRyB1ENutSjoBns+oppFLYkCp0SU3Jxm
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Andrei Lalaev reported a NULL pointer deref when a CAN device is
restarted from Bus Off and the driver does not implement the struct
can_priv::do_set_mode callback.

There are 2 code path that call struct can_priv::do_set_mode:
- directly by a manual restart from the user space, via
  can_changelink()
- delayed automatic restart after bus off (deactivated by default)

To prevent the NULL pointer deference, refuse a manual restart or
configure the automatic restart delay in can_changelink() and report
the error via extack to user space.

As an additional safety measure let can_restart() return an error if
can_priv::do_set_mode is not set instead of dereferencing it
unchecked.

Reported-by: Andrei Lalaev <andrey.lalaev@gmail.com>
Closes: https://lore.kernel.org/all/20250714175520.307467-1-andrey.lalaev@gmail.com
Fixes: 39549eef3587 ("can: CAN Network device driver and Netlink interface")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c     | 12 +++++++++---
 drivers/net/can/dev/netlink.c | 12 ++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index ea8c807af4d8..3913971125de 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -145,13 +145,16 @@ void can_change_state(struct net_device *dev, struct can_frame *cf,
 EXPORT_SYMBOL_GPL(can_change_state);
 
 /* CAN device restart for bus-off recovery */
-static void can_restart(struct net_device *dev)
+static int can_restart(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
 	struct sk_buff *skb;
 	struct can_frame *cf;
 	int err;
 
+	if (!priv->do_set_mode)
+		return -EOPNOTSUPP;
+
 	if (netif_carrier_ok(dev))
 		netdev_err(dev, "Attempt to restart for bus-off recovery, but carrier is OK?\n");
 
@@ -173,10 +176,14 @@ static void can_restart(struct net_device *dev)
 	if (err) {
 		netdev_err(dev, "Restart failed, error %pe\n", ERR_PTR(err));
 		netif_carrier_off(dev);
+
+		return err;
 	} else {
 		netdev_dbg(dev, "Restarted\n");
 		priv->can_stats.restarts++;
 	}
+
+	return 0;
 }
 
 static void can_restart_work(struct work_struct *work)
@@ -201,9 +208,8 @@ int can_restart_now(struct net_device *dev)
 		return -EBUSY;
 
 	cancel_delayed_work_sync(&priv->restart_work);
-	can_restart(dev);
 
-	return 0;
+	return can_restart(dev);
 }
 
 /* CAN bus-off
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index a36842ace084..f0e3f0d538fb 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -285,6 +285,12 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	}
 
 	if (data[IFLA_CAN_RESTART_MS]) {
+		if (!priv->do_set_mode) {
+			NL_SET_ERR_MSG(extack,
+				       "Device doesn't support restart from Bus Off");
+			return -EOPNOTSUPP;
+		}
+
 		/* Do not allow changing restart delay while running */
 		if (dev->flags & IFF_UP)
 			return -EBUSY;
@@ -292,6 +298,12 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	}
 
 	if (data[IFLA_CAN_RESTART]) {
+		if (!priv->do_set_mode) {
+			NL_SET_ERR_MSG(extack,
+				       "Device doesn't support restart from Bus Off");
+			return -EOPNOTSUPP;
+		}
+
 		/* Do not allow a restart while not running */
 		if (!(dev->flags & IFF_UP))
 			return -EINVAL;

---
base-commit: 6832a9317eee280117cd695fa885b2b7a7a38daf
change-id: 20250718-fix-nullptr-deref-do_set_mode-dd05bfec04ff

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



