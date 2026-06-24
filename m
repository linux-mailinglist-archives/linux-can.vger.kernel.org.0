Return-Path: <linux-can+bounces-7891-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IB9IIqZwO2qFXwgAu9opvQ
	(envelope-from <linux-can+bounces-7891-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 24 Jun 2026 07:52:38 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C956BB989
	for <lists+linux-can@lfdr.de>; Wed, 24 Jun 2026 07:52:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7891-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7891-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5EA13018BDA
	for <lists+linux-can@lfdr.de>; Wed, 24 Jun 2026 05:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC31231F9AC;
	Wed, 24 Jun 2026 05:50:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A4986341;
	Wed, 24 Jun 2026 05:50:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280234; cv=none; b=JpP15yC/Ii0/ajfE1z9gQrxtyHrpddD24necxe5bT97u0/Rv2XHDmriAo/c4uA0TmmAEiJix54MAiUCZS8e37IgLMJDDJIzXjDqUpTCciY6cxanHtJj3TmOJ8vFBhvdXiKAwZWtSr/mttEgb9LhlSUVd9EtLWa8pEq5m9rOOGbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280234; c=relaxed/simple;
	bh=UJS24SDoYABs2NH5ulhd7DTEpbHuIx0JSjFZNEBoL5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Px1VSMaedsoy845+ZatiuWM+q1k/uHBARjlgN5Ey4F1TMgL0i45g2pGnEMPOA9EsRBhtIyTtHnjFzBy1vx/yLsvnAph76KxibE11UYTI0kZNYs68TOgH+E4aCdZqsZsWyOlVINl3TVb03CGmq7Qmo0we88li++289e2Y1tgBULM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAAnIbgicDtqQQqtFQ--.23387S2;
	Wed, 24 Jun 2026 13:50:26 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] can: rockchip_canfd: Propagate reset failures on start
Date: Wed, 24 Jun 2026 13:50:26 +0800
Message-ID: <20260624055026.24789-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnIbgicDtqQQqtFQ--.23387S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy3Jw18AFy7Gr18KF4fGrg_yoW5Kw4Up3
	y5J3W3Jry8Zr1rXa1rJr18ZF1Fq3ZxKr47Ga97ta1Iy34ay3WUGr1jkr1Y9r4Ut34UC34F
	gr45Aa4UWF43XFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUpwZcUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:kernel@pengutronix.de,m:mailhol@kernel.org,m:heiko@sntech.de,m:p.zabel@pengutronix.de,m:linux-can@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:pengpeng@iscas.ac.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-7891-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8C956BB989

The Rockchip CAN-FD driver requires a reset controller, but
rkcanfd_chip_set_reset_mode() ignores reset assert/deassert failures.
rkcanfd_open() and CAN_MODE_START can then report success after the
controller failed to enter a known reset state.

Return reset errors from the reset/start helpers and propagate them
before enabling RX offload, requesting the IRQ, or starting the netdev
queue.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 .../net/can/rockchip/rockchip_canfd-core.c    | 40 +++++++++++++++----
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 29de0c01e4ed..89bc402b76e8 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -102,13 +102,23 @@ static const struct can_bittiming_const rkcanfd_data_bittiming_const = {
 	.brp_inc = 2,	/* value from data sheet x2 */
 };
 
-static void rkcanfd_chip_set_reset_mode(const struct rkcanfd_priv *priv)
+static int rkcanfd_chip_set_reset_mode(const struct rkcanfd_priv *priv)
 {
-	reset_control_assert(priv->reset);
+	int err;
+
+	err = reset_control_assert(priv->reset);
+	if (err)
+		return err;
+
 	udelay(2);
-	reset_control_deassert(priv->reset);
+
+	err = reset_control_deassert(priv->reset);
+	if (err)
+		return err;
 
 	rkcanfd_write(priv, RKCANFD_REG_MODE, 0x0);
+
+	return 0;
 }
 
 static void rkcanfd_chip_set_work_mode(const struct rkcanfd_priv *priv)
@@ -246,11 +256,14 @@ static void rkcanfd_chip_fifo_setup(struct rkcanfd_priv *priv)
 	netdev_reset_queue(priv->ndev);
 }
 
-static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
+static int rkcanfd_chip_start(struct rkcanfd_priv *priv)
 {
 	u32 reg;
+	int err;
 
-	rkcanfd_chip_set_reset_mode(priv);
+	err = rkcanfd_chip_set_reset_mode(priv);
+	if (err)
+		return err;
 
 	/* Receiving Filter: accept all */
 	rkcanfd_write(priv, RKCANFD_REG_IDCODE, 0x0);
@@ -309,13 +322,16 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 
 	netdev_dbg(priv->ndev, "%s: reg_mode=0x%08x\n", __func__,
 		   rkcanfd_read(priv, RKCANFD_REG_MODE));
+
+	return 0;
 }
 
 static void __rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum can_state state)
 {
 	priv->can.state = state;
 
-	rkcanfd_chip_set_reset_mode(priv);
+	if (rkcanfd_chip_set_reset_mode(priv))
+		netdev_err(priv->ndev, "Failed to reset CAN-FD controller\n");
 	rkcanfd_chip_interrupts_disable(priv);
 }
 
@@ -339,10 +355,14 @@ static int rkcanfd_set_mode(struct net_device *ndev,
 			    enum can_mode mode)
 {
 	struct rkcanfd_priv *priv = netdev_priv(ndev);
+	int err;
 
 	switch (mode) {
 	case CAN_MODE_START:
-		rkcanfd_chip_start(priv);
+		err = rkcanfd_chip_start(priv);
+		if (err)
+			return err;
+
 		rkcanfd_chip_interrupts_enable(priv);
 		netif_wake_queue(ndev);
 		break;
@@ -719,7 +739,10 @@ static int rkcanfd_open(struct net_device *ndev)
 	if (err)
 		goto out_close_candev;
 
-	rkcanfd_chip_start(priv);
+	err = rkcanfd_chip_start(priv);
+	if (err)
+		goto out_runtime_put;
+
 	can_rx_offload_enable(&priv->offload);
 
 	err = request_irq(ndev->irq, rkcanfd_irq, IRQF_SHARED, ndev->name, priv);
@@ -734,6 +757,7 @@ static int rkcanfd_open(struct net_device *ndev)
 
 out_rkcanfd_chip_stop:
 	rkcanfd_chip_stop_sync(priv, CAN_STATE_STOPPED);
+out_runtime_put:
 	pm_runtime_put(ndev->dev.parent);
 out_close_candev:
 	close_candev(ndev);
-- 
2.50.1 (Apple Git-155)


