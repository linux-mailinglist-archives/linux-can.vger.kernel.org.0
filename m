Return-Path: <linux-can+bounces-4164-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F108EB1219C
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 18:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962DC7B553B
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3AB2F0056;
	Fri, 25 Jul 2025 16:13:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429CE2EF2B8
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460023; cv=none; b=nTLlbly/Xf+++DzDfpUX7Fvl8NiaIX7jq5dn7diPyeYQCbJ/TG+OP7Jwj5UcF10aPo4/okEWwqISMyh5QbDACfm28IhoaVA2VvHFmCkLhFCUUATdfKLq82bhBOwKbZEA+N7pSXgkXFSI8tIdGPNt/P2FSc6gPy2uaFcUJDLlawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460023; c=relaxed/simple;
	bh=3PNgz4ikQj8yxEhPlKTE+xK2sRMPODlCS1m/obi2d/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqXaUX7snvxK7mcTWuO4bXsjw77T9UNSVidJaXdK6Ypm7YZXNiW1fhkrFRGZD803uEqe6JLGL4lnuLyURQ1vEJN0emsFpfKK+Y5gcVLjgcXJtNYCsb1fW6F8oL439WZ+RNisPwqzGj8kN0Bn/qPhtdYHJ+pYXdk6hRzxCK5D0mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3C-0006eu-ND
	for linux-can@vger.kernel.org; Fri, 25 Jul 2025 18:13:38 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL38-00AFYN-1w
	for linux-can@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 4379E449881
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:33 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 3CAD6449813;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2e16aa99;
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
Subject: [PATCH net-next 07/27] can: kvaser_pciefd: Add support to control CAN LEDs on device
Date: Fri, 25 Jul 2025 18:05:17 +0200
Message-ID: <20250725161327.4165174-8-mkl@pengutronix.de>
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

Add support to turn on/off CAN LEDs on device.
Turn off all CAN LEDs in probe, since they are default on after a reset or
power on.

Reviewed-by: Axel Forsman <axfo@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123230.8-2-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 09510663988c..c8f530ef416e 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -66,6 +66,7 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_KCAN_FIFO_LAST_REG 0x180
 #define KVASER_PCIEFD_KCAN_CTRL_REG 0x2c0
 #define KVASER_PCIEFD_KCAN_CMD_REG 0x400
+#define KVASER_PCIEFD_KCAN_IOC_REG 0x404
 #define KVASER_PCIEFD_KCAN_IEN_REG 0x408
 #define KVASER_PCIEFD_KCAN_IRQ_REG 0x410
 #define KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG 0x414
@@ -136,6 +137,9 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 /* Request status packet */
 #define KVASER_PCIEFD_KCAN_CMD_SRQ BIT(0)
 
+/* Control CAN LED, active low */
+#define KVASER_PCIEFD_KCAN_IOC_LED BIT(0)
+
 /* Transmitter unaligned */
 #define KVASER_PCIEFD_KCAN_IRQ_TAL BIT(17)
 /* Tx FIFO empty */
@@ -410,6 +414,7 @@ struct kvaser_pciefd_can {
 	struct kvaser_pciefd *kv_pcie;
 	void __iomem *reg_base;
 	struct can_berr_counter bec;
+	u32 ioc;
 	u8 cmd_seq;
 	u8 tx_max_count;
 	u8 tx_idx;
@@ -528,6 +533,16 @@ static inline void kvaser_pciefd_abort_flush_reset(struct kvaser_pciefd_can *can
 	kvaser_pciefd_send_kcan_cmd(can, KVASER_PCIEFD_KCAN_CMD_AT);
 }
 
+static inline void kvaser_pciefd_set_led(struct kvaser_pciefd_can *can, bool on)
+{
+	if (on)
+		can->ioc &= ~KVASER_PCIEFD_KCAN_IOC_LED;
+	else
+		can->ioc |= KVASER_PCIEFD_KCAN_IOC_LED;
+
+	iowrite32(can->ioc, can->reg_base + KVASER_PCIEFD_KCAN_IOC_REG);
+}
+
 static void kvaser_pciefd_enable_err_gen(struct kvaser_pciefd_can *can)
 {
 	u32 mode;
@@ -990,6 +1005,9 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		/* Disable Bus load reporting */
 		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_BUS_LOAD_REG);
 
+		can->ioc = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_IOC_REG);
+		kvaser_pciefd_set_led(can, false);
+
 		tx_nr_packets_max =
 			FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_MASK,
 				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
-- 
2.47.2



