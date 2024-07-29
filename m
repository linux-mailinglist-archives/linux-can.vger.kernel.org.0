Return-Path: <linux-can+bounces-1044-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB3193F64B
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 15:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475531F237A1
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 13:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A7D15B111;
	Mon, 29 Jul 2024 13:07:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F7014E2E6
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258430; cv=none; b=hW48T4APmUDDgt2MyP2Ov/TV68+MdnKbLolXI5OvVqK8xddWehDeb8FzK6o/6WuYXbzXlYbmiZA9Lw89l1F5naPRPWUgINDjlKmlRLARJP954In/091C8unOQdWtyjK9qS/r8IwpuLqEDQZ0CRvzhP8XK3PFJHzbqoooR6Gq21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258430; c=relaxed/simple;
	bh=4K7IcUX2ShCjdIf3ddGn5pv7FO+7/IgT4WzAtZ6mIJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sze8OF5TzDGfBGW0V5eUvx2e3AQO/35l+7Z+f7U2GOXj5cBktOsusrXNyn+sbLtrl5TmosLuqfHpAeAmbd4KtR+kR0CJs6wSBLF4+pnMDvGlOa3EmVkxBsmmg0aDIlOgQXkFB5oWW1ESj+oaHtF/MmsB4tiGkKOr7IunncBGBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5i-0000V4-UC
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:06 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5i-0033AB-Fu
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1BBE2310E2E
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id ED328310DB8;
	Mon, 29 Jul 2024 13:06:54 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 15ca44a6;
	Mon, 29 Jul 2024 13:06:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 29 Jul 2024 15:05:40 +0200
Subject: [PATCH can-next 09/21] can: rockchip_canfd:
 rkcanfd_handle_rx_int_one(): implement workaround for erratum 5: check for
 empty FIFO
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-rockchip-canfd-v1-9-fa1250fd6be3@pengutronix.de>
References: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
In-Reply-To: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3961; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=4K7IcUX2ShCjdIf3ddGn5pv7FO+7/IgT4WzAtZ6mIJI=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmp5PClLhgu4ITWvGmQrpXC+Y6ZGuISYZQB5UpO
 adZFj6VTWOJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZqeTwgAKCRAoOKI+ei28
 b/v7CACOqFG2YjBRLqcDKwW2VJQ6lcN6C49naKS/dWyZNY2YPhN7fvhvq6X8An6lVNiCUKN9wqR
 lwRouInzmHR4KyRAQM4MIAI3xR+ZXGQo/YjvAejWQLKHgfqJyQ0dkfsUSpkMoxBbREip2PsRKum
 Wbxn0JkQAHdt0VxRfbbAWvkk6LnozkM72HQ1WdG7WQmaoQs8TcmqAaaooyGiQaz4SQSIASxqOZF
 PVq6CmbWkuN3CDatXfPgu6n4HowpCq2QZ87cc6HDsaRe5idYjnxW97Zp0D8fJ4GFhoMsIK0cUB0
 cdCNwiEw8Voqjb78rt+P04BBDR+eCz/MNPdKRodmbT2j+LNn
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The rk3568 CAN-FD errata sheet as of Tue 07 Nov 2023 11:25:31 +08:00
says:

| Erratum 5: Counters related to the TXFIFO and RXFIFO exhibit
| abnormal counting behavior.
|
| Due to a bug in the cross-asynchronous logic of the enable signals
| for rx_fifo_cnt and txe_fifo_frame_cnt counters, the counts of these
| two counters become inaccurate. This issue has resulted in the
| inability to use the TXFIFO and RXFIFO functions.

The errata sheet mentioned above states that only the rk3568v2 is
affected by this erratum, but tests with the rk3568v2 and rk3568v3
show that the RX_FIFO_CNT is sometimes too high. This leads to CAN
frames being read from the FIFO, which is then already empty.

Further tests on the rk3568v2 and rk3568v3 show that in this
situation (i.e. empty FIFO) all elements of the FIFO
header (frameinfo, id, ts) contain the same data.

On the rk3568v2 and rk3568v3, this problem only occurs extremely
rarely with the standard clock of 300 MHz, but almost immediately at
80 MHz.

To workaround this problem, check for empty FIFO with
rkcanfd_fifo_header_empty() in rkcanfd_handle_rx_int_one() and exit
early.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-rx.c | 14 ++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd.h    | 22 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index affb89a956ee..c7b316e52580 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -47,6 +47,16 @@ rkcanfd_fifo_header_to_cfd_header(const struct rkcanfd_priv *priv,
 	return len + cfd->len;
 }
 
+static inline bool
+rkcanfd_fifo_header_empty(const struct rkcanfd_fifo_header *header)
+{
+	/* Erratum 5: If the FIFO is empty, we read the same value for
+	 * all elements.
+	 */
+	return header->frameinfo == header->id &&
+		header->frameinfo == header->ts;
+}
+
 static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
@@ -63,6 +73,10 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 	rkcanfd_read_rep(priv, RKCANFD_REG_RX_FIFO_RDATA,
 			 cfd->data, sizeof(cfd->data));
 
+	/* Erratum 5: Counters for TXEFIFO and RXFIFO may be wrong */
+	if (rkcanfd_fifo_header_empty(header))
+		return 0;
+
 	len = rkcanfd_fifo_header_to_cfd_header(priv, header, cfd);
 
 	/* Drop any received CAN-FD frames if CAN-FD mode is not
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index b5ad8633a8a6..09369ea62797 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -314,6 +314,28 @@
 
 /* Erratum 5: Counters related to the TXFIFO and RXFIFO exhibit
  * abnormal counting behavior.
+ *
+ * The rk3568 CAN-FD errata sheet as of Tue 07 Nov 2023 11:25:31 +08:00
+ * states that only the rk3568v2 is affected by this erratum, but
+ * tests with the rk3568v2 and rk3568v3 show that the RX_FIFO_CNT is
+ * sometimes too high. This leads to CAN frames being read from the
+ * FIFO, which is then already empty.
+ *
+ * Further tests on the rk3568v2 and rk3568v3 show that in this
+ * situation (i.e. empty FIFO) all elements of the FIFO header
+ * (frameinfo, id, ts) contain the same data.
+ *
+ * On the rk3568v2 and rk3568v3, this problem only occurs extremely
+ * rarely with the standard clock of 300 MHz, but almost immediately
+ * at 80 MHz.
+ *
+ * To workaround this problem, check for empty FIFO with
+ * rkcanfd_fifo_header_empty() in rkcanfd_handle_rx_int_one() and exit
+ * early.
+ *
+ * To reproduce:
+ * assigned-clocks = <&cru CLK_CANx>;
+ * assigned-clock-rates = <80000000>;
  */
 #define RKCANFD_QUIRK_RK3568_ERRATUM_5 BIT(4)
 

-- 
2.43.0



