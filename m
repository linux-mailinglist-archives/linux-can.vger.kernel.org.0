Return-Path: <linux-can+bounces-7978-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8daSG0cgR2otTgAAu9opvQ
	(envelope-from <linux-can+bounces-7978-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 04:36:55 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 094AE6FDF8C
	for <lists+linux-can@lfdr.de>; Fri, 03 Jul 2026 04:36:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b="s/twmNuD";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7978-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7978-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C30A33032993
	for <lists+linux-can@lfdr.de>; Fri,  3 Jul 2026 02:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E86240611;
	Fri,  3 Jul 2026 02:36:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DEF2BD02;
	Fri,  3 Jul 2026 02:36:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783046170; cv=none; b=c7+onh333X6ZrkpzUcD8gejcijGfoI+s4zTVVfAVSOIPPuX4r1scIML7oqQTCY9NR7g6QNLH0/1swtQ3vxEiXQ98PZZAkI/uSMIQHaADw8/Ius5YLXz+ETo6PZCT+IOzRM8fG/RdEN36gZdhp3IjjlxBmhcsSTxj8TqZXwVyYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783046170; c=relaxed/simple;
	bh=lMxkPE0eycN1Nm+L8bSUEZLmSlt9Svb3z7JXOL/s/nc=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=UrzgjNWb7Sh4JJcEt3sxEBuJHfLwLSNVFiiCIcqMzxKgjQ4KI8CldwZ7kb6Af5rbdfsEaMk55wdThZvJ8ZDIkBF9Y6c9ooE/fymNpc/gzSI0nN/fT3SKK3LdbJQBdFjX0CmT0CS+KfztraVYHU3B403q5gi8TzsqcaOWEjb2WVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=s/twmNuD; arc=none smtp.client-ip=203.205.221.205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783046165; bh=MPrJpcCg1b1pZTUffuYmaHM2iwNl76j5H9WCkOROtFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=s/twmNuDvjrH6alIosi23S4kZeFE4BZ+xv3GHUDBytCDub2qYCyT7ZCvfLCZazGgX
	 ApRPRldiKYmLFQMazNpL4wcCbPvd33JTcpCv7NnYtYrXycaqOCqVmJSZvT68f8w7cw
	 fj+IB6/DzQLGV0leV2z4v+vulmIsIMYOoHyuJcxI=
Received: from ubuntu2204.localdomain ([218.4.149.66])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 8F90EEF9; Fri, 03 Jul 2026 10:35:57 +0800
X-QQ-mid: xmsmtpt1783046161tl1yngyaw
Message-ID: <tencent_C76518126A4714027810EBFC749ADA68EE09@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeIxgDGEDZi/RDzoLLCvVKclLzcRsJhAYxagIo1MwwfbqeN20hcX
	 bgzd90NA/jluIuqSOwuyU46uIGbBteqBlpnJkf6js5ptPq0OULC6MBF+VORm2BEV12MgqNYy5aX3
	 oVqnTKNhAwq+zSLco6MAoI43Z8/RkBYWfOvd4tktjXp+1iPLl+mqzPDfEQFlqmOdDfbdQ/avW9LH
	 9YdDflroPoZrHWEbWJHFH6W08zjUF3nOIDPkIi9JhBK3N6UdYB+D/ZzqLQklB6n1pDEyCxzSLC+o
	 IJWltA4+Wb/2UzGv9UiEyfvmd/OyfGIYMyoP1YAXr2W9jhTzYXS+nVLXlteitNIbJMCFKZyL67Tx
	 dVlXr+GbiwY4tBCq+N3vmpy76w4ZqPFj4p/DiYCQ4pj7jPw4KeXYGe2DsXEj/u6Pdiag1MmioVEo
	 0SP3gDuszbkXWjRWEqkm6GtptAWb0mPiaIr3SnpygZwPb/gr0Hdzp0k8TXHfFhsN90iW1bykaBMI
	 lq7E7A05e4Zlm4s1SBijlBXY3DLq0h/6C2fQcmvjX66spOzAerckcfc2Gm5TIo+oFz/KTyAxmmHj
	 f1pqhVwYIQzh8IKagMU98fCOuHG3kZC3lQI8vPKaMSK3XDemzolDJ2hJwkJXYwQ6cYWOoQyk/vQn
	 yR2cz60Z1vlpU/yQDB8rDEAm2eMmEa4nv5fZ07yzmwZWdLfox0mmjVZs6YCt3luehq4Auk+6dbFl
	 Gih9k4BVlepeH1EpEClffTweGcd30/tNN7yy5xi+A6saiPcFx1Of9a8GYvNtghBcI5AkWJ5wGhU6
	 yNk0YrAl8hdzvsyNGTmxQCwj1OZrHgU3LaO9fQKyTZDVnA5eFdO/Cs3LtfLla8xIWtdvHaMoHFK+
	 fKD5EjQ/el/QsBIi4l12m5LpQGMYurBrCptGWrmxQ0vCtfnnaQsHv5K09DdKvuuZDMLxLen7xAiK
	 bDsBDqxQGLhjVVKG54Sd0OPiFd3OS3ivtTssSIlX5eI4dXXeoLluyz36iCgtBTsvz0J+zknMUUEV
	 dH05oWo1fYYyWW+ETS/42ecQjnsxqoA4K0JuXWom5CP5lw3w38ykPzl3tmBKQvKL/gj+tJFR2s76
	 YT/FMLXbemgDb+r2f9LdHiG4cMixWD1MuILqfyyFZMmY8LktUJOCy8B4yv1lT3Pyqo2JK2
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Cunhao Lu <1579567540@qq.com>
Date: Fri, 03 Jul 2026 10:35:41 +0800
Subject: [PATCH v3 2/4] can: rockchip: add RK3588 CAN support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260703-master-v3-2-6d56de6fd2f3@qq.com>
References: <20260703-master-v3-0-6d56de6fd2f3@qq.com>
In-Reply-To: <20260703-master-v3-0-6d56de6fd2f3@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Cunhao Lu <1579567540@qq.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:kernel@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:1579567540@qq.com,m:heiko.stuebner@cherry.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_FROM(0.00)[bounces-7978-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1579567540@qq.com,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,qq.com,cherry.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:email,vger.kernel.org:from_smtp,cherry.de:email,qq.com:from_mime,qq.com:email,qq.com:mid,qq.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 094AE6FDF8C

Add support for the RK3588 CAN controller by introducing a dedicated
model ID and OF match entry.

The block is closely related to the existing RK3568 variants, but it
cannot reuse their match data unchanged. In particular, RK3588
encodes RX_FIFO_CNT in bits 7:5 instead of 6:4, so the RX path needs
SoC-specific handling.

The RX FIFO count bitfield difference was found by comparing Rockchip's
vendor kernel 6.1 CAN support for RK3568 and RK3588. Runtime testing on
RK3588 also confirms that bits 7:5 are needed.

Enable the existing erratum 5 empty-FIFO workaround for RK3588.
Heiko reproduced erratum 6 on RK3588, so enable that workaround as
well.

Keep RKCANFD_QUIRK_CANFD_BROKEN enabled for RK3588, so CAN-FD stays
disabled for now. Local testing did not reproduce the two known CAN-FD
trigger frames that cause Error Interrupts on RK3568 variants. Instead,
RK3588 shows a different CAN-FD failure mode: CAN-FD frames without BRS
work in this setup, but BRS with a data bitrate different from the
nominal bitrate immediately drives the controller bus-off.

Co-developed-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Signed-off-by: Cunhao Lu <1579567540@qq.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
v2 -> v3:
- Use Co-developed-by for Heiko's RK3588 contributions and add his
  Signed-off-by
- Collect Heiko's Reviewed-by and Tested-by tags
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 12 ++++++++++++
 drivers/net/can/rockchip/rockchip_canfd-rx.c   |  5 ++++-
 drivers/net/can/rockchip/rockchip_canfd.h      | 26 +++++++++++++++++++++++++-
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 29de0c01e4ed..178d69edf1bb 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -50,6 +50,13 @@ static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3568v3 = {
 		RKCANFD_QUIRK_CANFD_BROKEN,
 };
 
+static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3588 = {
+	.model = RKCANFD_MODEL_RK3588,
+	.quirks = RKCANFD_QUIRK_RK3568_ERRATUM_5 |
+		RKCANFD_QUIRK_RK3568_ERRATUM_6 |
+		RKCANFD_QUIRK_CANFD_BROKEN,
+};
+
 static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 {
 	switch (model) {
@@ -57,6 +64,8 @@ static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
 		return "rk3568v2";
 	case RKCANFD_MODEL_RK3568V3:
 		return "rk3568v3";
+	case RKCANFD_MODEL_RK3588:
+		return "rk3588";
 	}
 
 	return "<unknown>";
@@ -846,6 +855,9 @@ static const struct of_device_id rkcanfd_of_match[] = {
 	}, {
 		.compatible = "rockchip,rk3568v3-canfd",
 		.data = &rkcanfd_devtype_data_rk3568v3,
+	}, {
+		.compatible = "rockchip,rk3588-canfd",
+		.data = &rkcanfd_devtype_data_rk3588,
 	}, {
 		/* sentinel */
 	},
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 475c0409e215..24e87daa1df0 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -281,7 +281,10 @@ rkcanfd_rx_fifo_get_len(const struct rkcanfd_priv *priv)
 {
 	const u32 reg = rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
 
-	return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT, reg);
+	if (priv->devtype_data.model == RKCANFD_MODEL_RK3588)
+		return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3588, reg);
+
+	return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3568, reg);
 }
 
 int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv)
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 93131c7d7f54..82a617e4ca66 100644
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
+ * Tests on the rk3588 show the same empty FIFO condition.
+ * In that setup rx_fifo_empty_errors increments when the bus
+ * transitions from idle to high CAN-FD load and stops growing once
+ * the bus reaches a steady state.
+ *
  * To workaround this problem, check for empty FIFO with
  * rkcanfd_fifo_header_empty() in rkcanfd_handle_rx_int_one() and exit
  * early.
@@ -344,6 +350,8 @@
 /* Erratum 6: The CAN controller's transmission of extended frames may
  * intermittently change into standard frames
  *
+ * Tests on the rk3588 show the same problem.
+ *
  * Work around this issue by activating self reception (RXSTX). If we
  * have pending TX CAN frames, check all RX'ed CAN frames in
  * rkcanfd_rxstx_filter().
@@ -408,6 +416,18 @@
  *     cansend can0 002##07217010000000000
  *   DUT:
  *     candump any,0:0,#FFFFFFFF -cexdHtA
+ *
+ * Tests on the rk3588 show a different CAN-FD failure mode: these two
+ * CAN-FD frames do not trigger Error Interrupt or Error-Warning. CAN-FD
+ * frames without bitrate switching work in this setup, but BRS with a
+ * data bitrate different from the nominal bitrate drives the controller
+ * bus-off immediately.
+ *
+ * To reproduce:
+ * host:
+ *   cangen can0 -I 2 -Li -Di -p 10 -f -g 1 -c32 -b
+ * DUT:
+ *   cansequence -rv can1 -f
  */
 #define RKCANFD_QUIRK_CANFD_BROKEN BIT(12)
 
@@ -424,6 +444,9 @@
  *     cansequence -rv -i 1
  *
  * - TX starvation after repeated Bus-Off
+ *   Tests on the rk3588 show the same problem. In a
+ *   10-cycle Bus-Off recovery test, 9 cycles failed to send after the
+ *   controller restarted.
  *   To reproduce:
  *   host:
  *     sleep 3 && cangen can0 -I2 -Li -Di -p10 -g 0.0
@@ -434,6 +457,7 @@
 enum rkcanfd_model {
 	RKCANFD_MODEL_RK3568V2 = 0x35682,
 	RKCANFD_MODEL_RK3568V3 = 0x35683,
+	RKCANFD_MODEL_RK3588 = 0x3588,
 };
 
 struct rkcanfd_devtype_data {

-- 
2.34.1


