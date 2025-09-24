Return-Path: <linux-can+bounces-4956-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79823B98DA0
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4FF4C31B8
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259272C0271;
	Wed, 24 Sep 2025 08:21:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E0C28DB71
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702119; cv=none; b=REG5VaH2JJmsoEw1NxLxXdz+a/i1sPbHT17quFQ/kxNa5vitG26DSc74J1gYV5A9LQRocGyq65UzjJ63tVCFNjAg8IUXsmdqqD3Drmz7KqVJxce2mA8eazCg4w7qzGFUVtExLMwkppWQCkIiSkHUxTOl/5gphb0TzfE9Id/v7kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702119; c=relaxed/simple;
	bh=r0K6zBVjEgBYjGTyxzYCSoQVT4JH6TkIW8VXS/p/Id8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFCHSGEjVNAQOYhhGDCNA2DOTuHP94v95WOkuvMQ3noxCLk5vCb3j8sVaDllORZ85HEPizq+GEuCVEid9Los8h6R7q05RzW/jT0RRuPlo26lJ+YHPoTvfBcploW/hrumjuWoWbnKb99tn/GtUrBEPTOQrx2jYht12FNmGZRjtWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-0001EW-SC; Wed, 24 Sep 2025 10:21:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkc-000Dvj-2b;
	Wed, 24 Sep 2025 10:21:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4944E4788C2;
	Wed, 24 Sep 2025 08:21:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 47/48] can: dev: add can_get_ctrlmode_str()
Date: Wed, 24 Sep 2025 10:07:04 +0200
Message-ID: <20250924082104.595459-48-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol@kernel.org>

In an effort to give more human readable messages when errors occur
because of conflicting options, it can be useful to convert the CAN
control mode flags into text.

Add a function which converts the first set CAN control mode into a
human readable string. The reason to only convert the first one is to
simplify edge cases: imagine that there are several invalid control
modes, we would just return the first invalid one to the user, thus
not having to handle complex string concatenation. The user can then
solve the first problem, call the netlink interface again and see the
next issue.

People who wish to enumerate all the control modes can still do so by,
for example, using this new function in a for_each_set_bit() loop.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-19-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/can/dev.h   |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index fd72159d3803..e5a82aa77958 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -88,6 +88,39 @@ const char *can_get_state_str(const enum can_state state)
 }
 EXPORT_SYMBOL_GPL(can_get_state_str);
 
+const char *can_get_ctrlmode_str(u32 ctrlmode)
+{
+	switch (ctrlmode & ~(ctrlmode - 1)) {
+	case 0:
+		return "none";
+	case CAN_CTRLMODE_LOOPBACK:
+		return "loopback";
+	case CAN_CTRLMODE_LISTENONLY:
+		return "listen-only";
+	case CAN_CTRLMODE_3_SAMPLES:
+		return "triple-sampling";
+	case CAN_CTRLMODE_ONE_SHOT:
+		return "one-shot";
+	case CAN_CTRLMODE_BERR_REPORTING:
+		return "berr-reporting";
+	case CAN_CTRLMODE_FD:
+		return "fd";
+	case CAN_CTRLMODE_PRESUME_ACK:
+		return "presume-ack";
+	case CAN_CTRLMODE_FD_NON_ISO:
+		return "fd-non-iso";
+	case CAN_CTRLMODE_CC_LEN8_DLC:
+		return "cc-len8-dlc";
+	case CAN_CTRLMODE_TDC_AUTO:
+		return "fd-tdc-auto";
+	case CAN_CTRLMODE_TDC_MANUAL:
+		return "fd-tdc-manual";
+	default:
+		return "<unknown>";
+	}
+}
+EXPORT_SYMBOL_GPL(can_get_ctrlmode_str);
+
 static enum can_state can_state_err_to_state(u16 err)
 {
 	if (err < CAN_ERROR_WARNING_THRESHOLD)
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 8e75e9b3830a..a2229a61ccde 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -141,6 +141,8 @@ int can_restart_now(struct net_device *dev);
 void can_bus_off(struct net_device *dev);
 
 const char *can_get_state_str(const enum can_state state);
+const char *can_get_ctrlmode_str(u32 ctrlmode);
+
 void can_state_get_by_berr_counter(const struct net_device *dev,
 				   const struct can_berr_counter *bec,
 				   enum can_state *tx_state,
-- 
2.51.0


