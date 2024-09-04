Return-Path: <linux-can+bounces-1338-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ABB96B40C
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 10:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FBB7B262B1
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A9A17BECA;
	Wed,  4 Sep 2024 08:13:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B43181CE1
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437622; cv=none; b=L//7be+XLIT7Ji/ZFS/KR/3Zxigo9G9bvrnztdaFlPgpQGy7ktZ6ISbSqBLpS4UGkaPai6LNCScXAM9CHuYpfhzJ5DKqNdVnWy8ZV9Yz1Edi90/lRyPmf0U24leo43sWPLyQlMH6SWvNEQR3tVvXWMth0N5hvMvwS5T31Vl2aLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437622; c=relaxed/simple;
	bh=gTvq7gHTXf9S/cqPeCfVe7J+meaf29zJX+AvP7bOZn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TyLF/JEBnf1oXLLupaDwnuIsD60h5BlEDXGYHmO8NGWKJ6oPIWf1fXG2iIf8OKwThAacCnCimulbQUFcXXkyiVv2iSdFYwUMASBuFsz0d7Wp8yJz5GiwxzusY1FO5e67RXqURY5sxMkd7rYG+K1EbeupwquXdpKp8iXWhPZnxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sll8z-0007i9-Lw
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 10:13:37 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sll8u-005Owi-Ph
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 10:13:32 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 536E7332095
	for <linux-can@vger.kernel.org>; Wed, 04 Sep 2024 08:13:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id A0714331F63;
	Wed, 04 Sep 2024 08:13:22 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ffdfeab7;
	Wed, 4 Sep 2024 08:13:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 04 Sep 2024 10:12:53 +0200
Subject: [PATCH can-next v5 09/20] can: rockchip_canfd:
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
Message-Id: <20240904-rockchip-canfd-v5-9-8ae22bcb27cc@pengutronix.de>
References: <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
In-Reply-To: <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
To: kernel@pengutronix.de, Alibek Omarov <a1ba.omarov@gmail.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=4011; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=gTvq7gHTXf9S/cqPeCfVe7J+meaf29zJX+AvP7bOZn8=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm2BaPeIrctjvtuUXSNHX0rSrSlIEBYZOETZXt1
 lLz7HKt4zaJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtgWjwAKCRAoOKI+ei28
 b6rkB/9vXJFKAya63M40ICu1SrKQooaTP3GWEI/RpH/tvQoBuUsR+GJNynz5Yvjarh4SXZZ4MNl
 MTNGp84YPOR1wvZy9GL4sHzGSGecx8oK7Xm8yTH5s2zKP5IgrsU7uEvwwd9wNFVCttKPV/u5tsM
 uuEL0oBYboZUOyiHUi66MUBnuD51rV+c/ME/2Djt7T2+r1tlHrTlsamFEOwt02GlMYc2nWpzHXI
 Ok6fDC/TDxYRz/VjVsWoX4wcoC/3G/TfMB1rlDg6tBexWhhzXA3p0AI5HVVGTpNFV1tg08xWry0
 pctZeBACTze1KHocrIhyvyGRONtGJ6naZZ5z5eeSLMYJ3rGh
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

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-rx.c | 14 ++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd.h    | 22 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 5398aff0d180..609282359bca 100644
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
index 3dafb5e68dc5..c775e75a2740 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -315,6 +315,28 @@
 
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
2.45.2



