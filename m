Return-Path: <linux-can+bounces-6197-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B36D38663
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 21:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24471305845C
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 20:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549E339A819;
	Fri, 16 Jan 2026 20:03:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A981A3093B8
	for <linux-can@vger.kernel.org>; Fri, 16 Jan 2026 20:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768593815; cv=none; b=eSnIb89WByiaA+4AQClMnKS/59uiZuCoPkyHs4ntBnWCpmRpD0L5SWlXD2miRde2Kqx2+UHJzmjkLQedbIO3Qx76jloGltSs7EDElVDWdgxBHRex6GEBLy7kY3PXwXaX0spdEgrS9avOKfpmAQ17pSLIRhrepYj7Hugf6d0MsL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768593815; c=relaxed/simple;
	bh=9DxcdGvcbQh8G5ttXiw004sL7ax+wOJXoGmB+oNjSrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmQ2pfIO4TxczjzXMymCyTic91j5aoRYb5Fw6dragqZrzTvx2WrxzBPJx4lib7WKmuKD9m/Z+XQY0FWeR0bu7u98P3W7RH3XYuxmlZw6atqQgvfTCg/rJ3T6JTEoJx0XAGQ6IU1E5e6PEatLET0GIOgjXSM+jWZNuphD3ESHkRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgq2Z-00049B-KV; Fri, 16 Jan 2026 21:03:27 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgq2Z-000yMR-2Z;
	Fri, 16 Jan 2026 21:03:27 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D5A384CEF6E;
	Fri, 16 Jan 2026 20:03:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH net 1/7] can: dev: alloc_candev_mqs(): add missing default CAN capabilities
Date: Fri, 16 Jan 2026 20:55:47 +0100
Message-ID: <20260116200323.366877-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116200323.366877-1-mkl@pengutronix.de>
References: <20260116200323.366877-1-mkl@pengutronix.de>
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
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260116-can_add_missing_set_caps-v1-1-7525126d8b20@pengutronix.de
[mkl: fix typo in subject]
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

base-commit: a74c7a58ca2ca1cbb93f4c01421cf24b8642b962
-- 
2.51.0


