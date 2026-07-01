Return-Path: <linux-can+bounces-7935-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 91rPBdS8RGqGzwoAu9opvQ
	(envelope-from <linux-can+bounces-7935-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 09:08:04 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1766EA7C9
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 09:08:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=tw5+h5jL;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7935-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7935-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C144310F788
	for <lists+linux-can@lfdr.de>; Wed,  1 Jul 2026 07:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635CB3B42E9;
	Wed,  1 Jul 2026 07:02:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9563B42DA;
	Wed,  1 Jul 2026 07:02:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889324; cv=none; b=Q3SCxGHyapyTcBR/CfKA6t4vsojEwjXqEDX098x0BwTfzAhOyt/orV3WcY/MHrtkielsZFto3G2YKcJei7R/uIYUaYJF2PXCwqQ0sDIpVyzzBwcM7GXt6oI63lkL7K3qK+6BvglW7a1qZx45ucLv6SlnICCtmsrTdYbROn+GkrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889324; c=relaxed/simple;
	bh=NBBHr2J19XhZij+JphyK0Q+DFxeyv3lNWh+hOyYy2Cg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Fu9ODZAdhVQTlAbWZvLzlR/dAyi95C/ZJX6FbNotDPOi/uKcHe+tskHwopxuMKJPNmrd0WpALPu6/v3dyYA1GNEB97w3Z2J7oj5vK09Usu98lG5fs5QF8LBUQqb39srKnS/AYe/kjAIRhsrLGclLwjL5tFjUZ8IKGkBxx48K6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tw5+h5jL; arc=none smtp.client-ip=203.205.221.210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782889320; bh=iTNCFFEs2iGrZea7nEKA00hMwnPy96cYNAUqB/qqLg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tw5+h5jLMj4FlnVA3WQsliDBM0Ka6TOw4Ew3WMieIomx1Ya6o08Cs/RTC6OhlMYxp
	 sSD4MXT5TbPe0DrtfM7InjzFhIina7dRam3lSu/hYFn0t6FyC0DwM1gap3j0lemfgB
	 QdqON3P+6G4RHV13O7CK7gPDF9ECnWoRahs6rgDk=
Received: from localhost.localdomain ([2409:8d20:2a:1b57:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 71832C3; Wed, 01 Jul 2026 15:01:49 +0800
X-QQ-mid: xmsmtpt1782889315t0ovgzw9f
Message-ID: <tencent_124D6134EB32480979234201E688087E5408@qq.com>
X-QQ-XMAILINFO: NMSHCeFjyxDuJyOcEZyRIEj8z1sx5U1ZetymqAG5YHWbiV5LeUywewE9i1OrBU
	 5oBAg/d1T8HJPUmew87jmkl4KYj4qB1tWUQxLqlOjA5Oa3mHckkTBxYbSkRN4r2FcgOpTMUU39ME
	 9R0OFeWxXQinEdqFbcoWqr83Xqptzrn2Et11Kbb5RVgDJvFD+r7OPdzc/QzE3DyNKRlmAcSNxTHM
	 nAJP2xXylhNGGFooKgjCyHyGlzx3iGBQ8oJhZ3dVEqQ0V8msdJvu/UujuJIaD21s5Y7fWMHCZuut
	 MHYwdyakE/hAAhFCvSF5QDCudua1oRm8st299/PlN7JoavwjJNQbmaSHYIRFs5OVqOgR6K/TT5+E
	 V5xWlsUFeFoV4zwpHR6J0adgYV79isOhV3l1n8MJKqlU/kahT7URE0QLxST+3zGmh/IQ36evaUQj
	 D/6tYg+qF/Pn5e1i/2YEBVk6wJEsqGiCD/d4vi7pWD68z8rhDnvlJ635o96ikgCkBxznWgeHCJyN
	 PK1UScr8uI7AoHFDaavxDOzcrUNxwFf/ZTtpw0aZ367H4Zm5O4PZEHaNG2ZtIF2L2AMON/YzCytF
	 zw+2Vj/Muyi6Ymbr8xlWBa6OfMP2iA8cNPCJxtfEIREA4HzF/YA1Zo2xddjlNTP09CncuQJVWJPB
	 trjLZ4RfXX0CRfbgmU52gK7MqsxsuYecNhEb7m8M2TUBAl/VodxzBWj4j3caSN/XTZLXCTNIIdd+
	 587F3GIbqVvV04CIwPtRVrAKwN+G7QTRCRIc3hlx9XxTSSYm8rpedvA3c2sjO1WHKXC6c6mLVN4U
	 9uOgXvv6mP/ruGhHGCuFNOb++Gz/GCsVE5DmeyjiRgeSwNO2zek57hiVO3Mop9bsrDv0FME/OYtf
	 RLHrspHvHiKB89cONO0rFBaCf/LTwIDyJdDjldg7IxozFYY9J+7QLwkmlVRmM5HQyvdaK878hRAS
	 lzzUp4+vD0MHmAq3S3s6hEfQAFr2DQg0KGkedwMsFGHW4LnuBruIThwpOgRzhenJuu0A9JceRkZX
	 2Neld3MDV7LCiZQovXnUuckz73+aq65A3yvoW0LglNJLT9LnlpIqqRsGUgfRGeMu2zwuFjevFkXl
	 DE8cyDKLPibdHIQNp73yVdD/hQEsNrUKvyyCFCJuHzN6oQ02Y=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: 1579567540@qq.com
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	kernel@pengutronix.de,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	luch00 <1579567540@qq.com>
Subject: [PATCH 2/3] can: rockchip: add RK3588 CAN-FD support
Date: Wed,  1 Jul 2026 15:01:27 +0800
X-OQ-MSGID: <20260701070128.2096267-3-1579567540@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701070128.2096267-1-1579567540@qq.com>
References: <20260701070128.2096267-1-1579567540@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7935-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:kernel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:1579567540@qq.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[qq.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,sntech.de,vger.kernel.org,lists.infradead.org,qq.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:dkim,qq.com:email,qq.com:mid,qq.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D1766EA7C9

From: luch00 <1579567540@qq.com>

Add support for the RK3588v2 CAN-FD controller by introducing a
dedicated model ID and OF match entry.

The block is closely related to the existing RK3568 variants, but it
cannot reuse their match data unchanged. In particular, RK3588v2
encodes RX_FIFO_CNT in bits 7:5 instead of 6:4, so the RX path needs
SoC-specific handling.

Validation on RK3588v2 also shows that its observed errata profile does
not fully match rk3568v2/rk3568v3, so keep a dedicated devtype for this
variant instead of relying on an rk3568 fallback.

Signed-off-by: luch00 <1579567540@qq.com>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 14 ++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd-rx.c   |  5 ++++-
 drivers/net/can/rockchip/rockchip_canfd.h      | 12 +++++++++++-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 29de0c01e..3c2480785 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -50,6 +50,15 @@ static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v3 = {
 		RKCANFD_QUIRK_CANFD_BROKEN,
 };
 
+/* Tests on the rk3588v2 reproduce Erratum 5, but not
+ * Erratum 6 or the special CAN-FD frames that trigger Error Interrupts
+ * on rk3568v2/rk3568v3.
+ */
+static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3588v2 = {
+	.model = RKCANFD_MODEL_RK3588V2,
+	.quirks = RKCANFD_QUIRK_RK3568_ERRATUM_5,
+};
+
 static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 {
 	switch (model) {
@@ -57,6 +66,8 @@ static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 		return "rk3568v2";
 	case RKCANFD_MODEL_RK3568V3:
 		return "rk3568v3";
+	case RKCANFD_MODEL_RK3588V2:
+		return "rk3588v2";
 	}
 
 	return "<unknown>";
@@ -846,6 +857,9 @@ static const struct of_device_id rkcanfd_of_match[] = {
 	}, {
 		.compatible = "rockchip,rk3568v3-canfd",
 		.data = &rkcanfd_devtype_data_rk3568v3,
+	}, {
+		.compatible = "rockchip,rk3588v2-canfd",
+		.data = &rkcanfd_devtype_data_rk3588v2,
 	}, {
 		/* sentinel */
 	},
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 475c0409e..fe64db373 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -281,7 +281,10 @@ rkcanfd_rx_fifo_get_len(const struct rkcanfd_priv *priv)
 {
 	const u32 reg = rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
 
-	return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT, reg);
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3588V2)
+		return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3588, reg);
+
+	return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3568, reg);
 }
 
 int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv)
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 93131c7d7..f6105b904 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -214,7 +214,8 @@
 #define RKCANFD_REG_TXEVENT_FIFO_CTRL_TXE_FIFO_ENABLE BIT(0)
 
 #define RKCANFD_REG_RX_FIFO_CTRL 0x118
-#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT GENMASK(6, 4)
+#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3568 GENMASK(6, 4)
+#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3588 GENMASK(7, 5)
 #define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_FULL_WATERMARK GENMASK(3, 1)
 #define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_ENABLE BIT(0)
 
@@ -331,6 +332,11 @@
  * rarely with the standard clock of 300 MHz, but almost immediately
  * at 80 MHz.
  *
+ * Test on the rk3588v2 shows the same empty FIFO condition.
+ * In that setup rx_fifo_empty_errors increments when the bus
+ * transitions from idle to high CAN-FD load and stops growing once
+ * the bus reaches a steady state.
+ *
  * To workaround this problem, check for empty FIFO with
  * rkcanfd_fifo_header_empty() in rkcanfd_handle_rx_int_one() and exit
  * early.
@@ -424,6 +430,9 @@
  *     cansequence -rv -i 1
  *
  * - TX starvation after repeated Bus-Off
+ *   Tests on the rk3588v2 show the same problem. In a
+ *   10-cycle Bus-Off recovery test, 9 cycles failed to send after the
+ *   controller restarted.
  *   To reproduce:
  *   host:
  *     sleep 3 && cangen can0 -I2 -Li -Di -p10 -g 0.0
@@ -434,6 +443,7 @@
 enum rkcanfd_model {
 	RKCANFD_MODEL_RK3568V2 = 0x35682,
 	RKCANFD_MODEL_RK3568V3 = 0x35683,
+	RKCANFD_MODEL_RK3588V2 = 0x35882,
 };
 
 struct rkcanfd_devtype_data {
-- 
2.34.1


