Return-Path: <linux-can+bounces-358-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43AF86FD1A
	for <lists+linux-can@lfdr.de>; Mon,  4 Mar 2024 10:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804502834B0
	for <lists+linux-can@lfdr.de>; Mon,  4 Mar 2024 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1671B967;
	Mon,  4 Mar 2024 09:21:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139821B943
	for <linux-can@vger.kernel.org>; Mon,  4 Mar 2024 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544068; cv=none; b=V4cdGUp9qqZyUFayLg6IQ0KQb2D0CFetPusdZaf1sXTq8VjPHVpKSK7XFmXXQ9IQrz8Qs3NCxtUw0uGdSsU2bhFNQJCDVr20wZoim2gFDOuQV8kL7Hsp3BBsGjnfpVF8I5jkKGyVjMnDnnMCxvFsXVvAzP+8r7EH8YmaUTeS2W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544068; c=relaxed/simple;
	bh=RPEEtuuyoJfH1pT5iuvgGIn0RX3VSW1ySsLNmfZqMN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYqgUWy+oLPu357E657kZviH5qKd0kmYwsQeaebrRZY9GiuXXY/B9wnDIeatYED9+1genqggPKWusTnUJs3vQXrJYLwNgXia5SjMEZ/wDrMpgaBRM+9+x4jacFn4/zmUh0imT2arv5zEle7V67Ygy/Szuy/MWOytALWcn+5p8bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rh4VM-00054E-AV
	for linux-can@vger.kernel.org; Mon, 04 Mar 2024 10:21:04 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rh4VL-004K3z-Mw
	for linux-can@vger.kernel.org; Mon, 04 Mar 2024 10:21:03 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 63EF129CB46
	for <linux-can@vger.kernel.org>; Mon,  4 Mar 2024 09:21:03 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id DD88229CB2A;
	Mon,  4 Mar 2024 09:21:01 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b50f763a;
	Mon, 4 Mar 2024 09:21:01 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Martin=20Joci=C4=87?= <martin.jocic@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 2/4] can: kvaser_pciefd: Add support for Kvaser PCIe 8xCAN
Date: Mon,  4 Mar 2024 10:13:56 +0100
Message-ID: <20240304092051.3631481-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304092051.3631481-1-mkl@pengutronix.de>
References: <20240304092051.3631481-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Martin Jocić <martin.jocic@kvaser.com>

Add support for new Kvaser pciefd device, PCIe 8xCAN, based on Xilinx FPGA.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
Link: https://lore.kernel.org/all/2b2c720a788e1904283e354abb320adb5b631d26.camel@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Kconfig         | 1 +
 drivers/net/can/kvaser_pciefd.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 620766eb6bc1..2e31db55d927 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -169,6 +169,7 @@ config CAN_KVASER_PCIEFD
 	    Kvaser Mini PCI Express 1xCAN v3
 	    Kvaser Mini PCI Express 2xCAN v3
 	    Kvaser M.2 PCIe 4xCAN
+	    Kvaser PCIe 8xCAN
 
 config CAN_SLCAN
 	tristate "Serial / USB serial CAN Adaptors (slcan)"
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 416f10480b40..f81b598147b3 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -27,7 +27,7 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_BEC_POLL_FREQ (jiffies + msecs_to_jiffies(200))
 #define KVASER_PCIEFD_MAX_ERR_REP 256U
 #define KVASER_PCIEFD_CAN_TX_MAX_COUNT 17U
-#define KVASER_PCIEFD_MAX_CAN_CHANNELS 4UL
+#define KVASER_PCIEFD_MAX_CAN_CHANNELS 8UL
 #define KVASER_PCIEFD_DMA_COUNT 2U
 
 #define KVASER_PCIEFD_DMA_SIZE (4U * 1024U)
@@ -49,6 +49,7 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 
 /* Xilinx based devices */
 #define KVASER_PCIEFD_M2_4CAN_DEVICE_ID 0x0017
+#define KVASER_PCIEFD_8CAN_DEVICE_ID 0x0019
 
 /* Altera SerDes Enable 64-bit DMA address translation */
 #define KVASER_PCIEFD_ALTERA_DMA_64BIT BIT(0)
@@ -496,6 +497,10 @@ static struct pci_device_id kvaser_pciefd_id_table[] = {
 		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_M2_4CAN_DEVICE_ID),
 		.driver_data = (kernel_ulong_t)&kvaser_pciefd_xilinx_driver_data,
 	},
+	{
+		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_8CAN_DEVICE_ID),
+		.driver_data = (kernel_ulong_t)&kvaser_pciefd_xilinx_driver_data,
+	},
 	{
 		0,
 	},
-- 
2.43.0



