Return-Path: <linux-can+bounces-4168-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C611B121A9
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 18:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6AF585344
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 16:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4AB2F0C4B;
	Fri, 25 Jul 2025 16:13:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9705D2F0025
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460025; cv=none; b=q/t45u/K9JR0YGALibRo/3ehYht86sMgmfz1br8DfO6B2Lhb7ocb6XNtmpIswHx+DCoCMyU20MzxTY1aB68pv0WUGTeMr/Y74opgIknTHdfAruvODywoC8ZDElcbe6sQhmOF9oOHVJ2Oqt6SjuOX0RJd4NKWzLTWJIK0/FSJPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460025; c=relaxed/simple;
	bh=OrrCkI30+twP7n4wUU21dHYK3HnfXBiCcPQnJJzcQtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ie9lItbcvut7B+avcTAXl2W+dIxewoQ3GfHt3lytpCUzXqdpcRwTeXYpvTw0mCxxwPStz1uS41CXSylOeVwD9qZmdxXqaoG2IoI372Og2XipLUprLgKZCryYtIwv8TpUjm4Z6JGcZseg9FP4qAk8XQbGTgy77tPDOaooU1FIQOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3E-0006iH-63
	for linux-can@vger.kernel.org; Fri, 25 Jul 2025 18:13:40 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3A-00AFbK-0M
	for linux-can@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:36 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 9C87A4498C2
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id CDE90449827;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f7b0ee66;
	Fri, 25 Jul 2025 16:13:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 15/27] can: kvaser_pciefd: Add devlink port support
Date: Fri, 25 Jul 2025 18:05:25 +0200
Message-ID: <20250725161327.4165174-16-mkl@pengutronix.de>
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

Register each CAN channel of the device as an devlink physical port.
This makes it easier to get device information for a given network
interface (i.e. can2).

Example output:
  $ devlink dev
  pci/0000:07:00.0
  pci/0000:08:00.0
  pci/0000:09:00.0

  $ devlink port
  pci/0000:07:00.0/0: type eth netdev can0 flavour physical port 0 splittable false
  pci/0000:07:00.0/1: type eth netdev can1 flavour physical port 1 splittable false
  pci/0000:07:00.0/2: type eth netdev can2 flavour physical port 2 splittable false
  pci/0000:07:00.0/3: type eth netdev can3 flavour physical port 3 splittable false
  pci/0000:08:00.0/0: type eth netdev can4 flavour physical port 0 splittable false
  pci/0000:08:00.0/1: type eth netdev can5 flavour physical port 1 splittable false
  pci/0000:09:00.0/0: type eth netdev can6 flavour physical port 0 splittable false
  pci/0000:09:00.0/1: type eth netdev can7 flavour physical port 1 splittable false
  pci/0000:09:00.0/2: type eth netdev can8 flavour physical port 2 splittable false
  pci/0000:09:00.0/3: type eth netdev can9 flavour physical port 3 splittable false

  $ devlink port show can2
  pci/0000:07:00.0/2: type eth netdev can2 flavour physical port 2 splittable false

  $ devlink dev info
  pci/0000:07:00.0:
    driver kvaser_pciefd
    versions:
        running:
          fw 1.3.75
  pci/0000:08:00.0:
    driver kvaser_pciefd
    versions:
        running:
          fw 2.4.29
  pci/0000:09:00.0:
    driver kvaser_pciefd
    versions:
        running:
          fw 1.3.72

  $  sudo ethtool -i can2
  driver: kvaser_pciefd
  version: 6.8.0-40-generic
  firmware-version: 1.3.75
  expansion-rom-version:
  bus-info: 0000:07:00.0
  supports-statistics: no
  supports-test: no
  supports-eeprom-access: no
  supports-register-dump: no
  supports-priv-flags: no

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123230.8-10-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h |  4 +++
 .../can/kvaser_pciefd/kvaser_pciefd_core.c    |  8 ++++++
 .../can/kvaser_pciefd/kvaser_pciefd_devlink.c | 25 +++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
index 34ba393d6093..08c9ddc1ee85 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
@@ -59,6 +59,7 @@ struct kvaser_pciefd_fw_version {
 
 struct kvaser_pciefd_can {
 	struct can_priv can;
+	struct devlink_port devlink_port;
 	struct kvaser_pciefd *kv_pcie;
 	void __iomem *reg_base;
 	struct can_berr_counter bec;
@@ -89,4 +90,7 @@ struct kvaser_pciefd {
 };
 
 extern const struct devlink_ops kvaser_pciefd_devlink_ops;
+
+int kvaser_pciefd_devlink_port_register(struct kvaser_pciefd_can *can);
+void kvaser_pciefd_devlink_port_unregister(struct kvaser_pciefd_can *can);
 #endif /* _KVASER_PCIEFD_H */
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
index 86509a2d2b90..0880023611be 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
@@ -943,6 +943,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		struct net_device *netdev;
 		struct kvaser_pciefd_can *can;
 		u32 status, tx_nr_packets_max;
+		int ret;
 
 		netdev = alloc_candev(sizeof(struct kvaser_pciefd_can),
 				      roundup_pow_of_two(KVASER_PCIEFD_CAN_TX_MAX_COUNT));
@@ -1013,6 +1014,11 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 
 		pcie->can[i] = can;
 		kvaser_pciefd_pwm_start(can);
+		ret = kvaser_pciefd_devlink_port_register(can);
+		if (ret) {
+			dev_err(&pcie->pci->dev, "Failed to register devlink port\n");
+			return ret;
+		}
 	}
 
 	return 0;
@@ -1732,6 +1738,7 @@ static void kvaser_pciefd_teardown_can_ctrls(struct kvaser_pciefd *pcie)
 		if (can) {
 			iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 			kvaser_pciefd_pwm_stop(can);
+			kvaser_pciefd_devlink_port_unregister(can);
 			free_candev(can->can.dev);
 		}
 	}
@@ -1874,6 +1881,7 @@ static void kvaser_pciefd_remove(struct pci_dev *pdev)
 		unregister_candev(can->can.dev);
 		timer_delete(&can->bec_poll_timer);
 		kvaser_pciefd_pwm_stop(can);
+		kvaser_pciefd_devlink_port_unregister(can);
 	}
 
 	kvaser_pciefd_disable_irq_srcs(pcie);
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
index 1fbb40dbbb7a..1d61a8b0eeba 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
@@ -5,6 +5,7 @@
  */
 #include "kvaser_pciefd.h"
 
+#include <linux/netdevice.h>
 #include <net/devlink.h>
 
 static int kvaser_pciefd_devlink_info_get(struct devlink *devlink,
@@ -33,3 +34,27 @@ static int kvaser_pciefd_devlink_info_get(struct devlink *devlink,
 const struct devlink_ops kvaser_pciefd_devlink_ops = {
 	.info_get = kvaser_pciefd_devlink_info_get,
 };
+
+int kvaser_pciefd_devlink_port_register(struct kvaser_pciefd_can *can)
+{
+	int ret;
+	struct devlink_port_attrs attrs = {
+		.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL,
+		.phys.port_number = can->can.dev->dev_port,
+	};
+	devlink_port_attrs_set(&can->devlink_port, &attrs);
+
+	ret = devlink_port_register(priv_to_devlink(can->kv_pcie),
+				    &can->devlink_port, can->can.dev->dev_port);
+	if (ret)
+		return ret;
+
+	SET_NETDEV_DEVLINK_PORT(can->can.dev, &can->devlink_port);
+
+	return 0;
+}
+
+void kvaser_pciefd_devlink_port_unregister(struct kvaser_pciefd_can *can)
+{
+	devlink_port_unregister(&can->devlink_port);
+}
-- 
2.47.2



