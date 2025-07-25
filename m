Return-Path: <linux-can+bounces-4158-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C317B1218D
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 18:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B932FAC590E
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 16:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56E2EF9CA;
	Fri, 25 Jul 2025 16:13:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA56F2EF2B0
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460020; cv=none; b=PqJP2vl4fDeuWsUfm8/fyscU1afV+jEKUtUTdLzt5XyHPAeYZEWuhtyH+e0Z67XcVk/8ufICnvFrdJEmjEta2eVC8HpOQh4HGcXyMXEy1Uf8SgPKUdTH/SJNSuuuPKxiiZedosfCxYdcPKupohiPOGSTyPedv72Ktpcv5PhVbOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460020; c=relaxed/simple;
	bh=CVneZ6zaQG93HYrxO4Y2EXagHyJXdKKyOMzKdh7iJgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=In3R47KiezBy/YpaA/T7X+0DLTPrxX1nxauW6vYabsk2EKy4qHIbv0N8+aCXlm+TIn06dUWklYLKZBXw5cncIm671OEYTo2roQA4538tssUw73oU7mvS6fUCy3NqpSxijV1y4JwOgT4UK7AW/NRzVlIbukfH/HICm6hxjXsxbCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3A-0006e8-Re
	for linux-can@vger.kernel.org; Fri, 25 Jul 2025 18:13:36 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL38-00AFYR-1R
	for linux-can@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 63C2A449885
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:33 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 4F95D449815;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8ad15c9f;
	Fri, 25 Jul 2025 16:13:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Axel Forsman <axfo@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 08/27] can: kvaser_pciefd: Add support for ethtool set_phys_id()
Date: Fri, 25 Jul 2025 18:05:18 +0200
Message-ID: <20250725161327.4165174-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725161327.4165174-1-mkl@pengutronix.de>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
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

From: Jimmy Assarsson <extja@kvaser.com>

Add support for ethtool set_phys_id(), to physically locate devices by
flashing a LED on the device.

Reviewed-by: Axel Forsman <axfo@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123230.8-3-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index c8f530ef416e..ed1ea8a9a6d2 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -968,8 +968,32 @@ static const struct net_device_ops kvaser_pciefd_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static int kvaser_pciefd_set_phys_id(struct net_device *netdev,
+				     enum ethtool_phys_id_state state)
+{
+	struct kvaser_pciefd_can *can = netdev_priv(netdev);
+
+	switch (state) {
+	case ETHTOOL_ID_ACTIVE:
+		return 3; /* 3 On/Off cycles per second */
+
+	case ETHTOOL_ID_ON:
+		kvaser_pciefd_set_led(can, true);
+		return 0;
+
+	case ETHTOOL_ID_OFF:
+	case ETHTOOL_ID_INACTIVE:
+		kvaser_pciefd_set_led(can, false);
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct ethtool_ops kvaser_pciefd_ethtool_ops = {
 	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
+	.set_phys_id = kvaser_pciefd_set_phys_id,
 };
 
 static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
-- 
2.47.2



