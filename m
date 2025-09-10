Return-Path: <linux-can+bounces-4600-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 643D3B50DA7
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AE75E20E2
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86159305042;
	Wed, 10 Sep 2025 06:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpMdv9pd"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD832E0910;
	Wed, 10 Sep 2025 06:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484289; cv=none; b=M0eGBVa/4zffvOb/+jTWHqhti9jneDChXw5adIVGOHZDW19PSM0FiTxfWmf72zqHhfhw3CUu5nYQg2LvlLDCViRJsJRMd/a6qNvkdK4TAQN5Tm0KeGc+zG8ktF4xNJQDuAYnKhJrjfHoTr0Tz2aTvDOyFM6OIYQxiYXi6P0rCm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484289; c=relaxed/simple;
	bh=T88mFb7sQ3TDbgKtkbXsmLV//5AWUv8klMda8U+nd2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jp9vdy8YHoAIVn4aUp7n79S5MIxSVw84ExsqRRReFr8fRrwwoD6nhA8aQofEUGM6Us2rk+xvL31BIax9ozaR+TQEqZulCjnWVAQf+V5nbZllL52oQeWHpR2Z1fHPTsW5+pFrtXHNkQfrZj3rcEhuzsvNpcMdFAcVaP+90uFB7MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpMdv9pd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BF6C4CEFA;
	Wed, 10 Sep 2025 06:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484287;
	bh=T88mFb7sQ3TDbgKtkbXsmLV//5AWUv8klMda8U+nd2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DpMdv9pdJ9K0y1aYaEvb4QNA+/ApQoTeOkRdKsSTmQAtR/TswhLIbYC555Quc1MW0
	 wrMRq16YLZA6aED+LAnz8e3Xb1Zr5mXI/tBmJp8nRpPPoD/6XGh5XqZQcHIXaeQgCN
	 wbFJK7FsJ83gEB6xGmaPDt8aojc6xeoASqN1a6Y8fg/5WZzGYqFUkOwvJlZqRWsDAm
	 xmorOBflJpQPdYmJdsG7/Nnv6my3NY3CQHI8DY5795xzJvbZdt7eCGNFFw0CppLl78
	 k7/9H38Wmr15daKk2zOWUv4MG79jFyBO/wQioR+YYYf9+pGj/jJeoyAuNRnHuZJEAN
	 xGtvjD5cMzPtg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:26 +0900
Subject: [PATCH v2 01/20] can: dev: move struct data_bittiming_params to
 linux/can/bittiming.h
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-1-f128d4083721@kernel.org>
References: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
In-Reply-To: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2460; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=T88mFb7sQ3TDbgKtkbXsmLV//5AWUv8klMda8U+nd2Q=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRU7MV38iIPA96dSxK5o91/a3d+u3XuTUearYtKZ86
 /eqc9/md5SyMIhxMciKKbIsK+fkVugo9A479NcSZg4rE8gQBi5OAZjIPzaGvyJT/b741jfeuXFG
 8tDLTSIHpLdy/to1f1qR37qvN+Xe2y9iZLiwfVt99YlVk4X2SD8/ULLvrLTzYbewsxm3t29+Oe/
 blcdcAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

In commit b803c4a4f788 ("can: dev: add struct data_bittiming_params to
group FD parameters"), struct data_bittiming_params was put into
linux/can/dev.h.

This structure being a collection of bittiming parameters, on second
thought, bittiming.h is actually a better location. This way, users of
struct data_bittiming_params will not have to forcefully include
linux/can/dev.h thus removing some complexity and reducing the risk of
circular dependencies in headers.

Move struct data_bittiming_params from linux/can/dev.h to
linux/can/bittiming.h.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 include/linux/can/bittiming.h | 11 +++++++++++
 include/linux/can/dev.h       | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 5dfdbb63b1d54f3dc02170b10b73dbb9c2242851..6572ec1712ca2df8db7fe1453ae5a4d5699712b1 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -114,6 +114,17 @@ struct can_tdc_const {
 	u32 tdcf_max;
 };
 
+struct data_bittiming_params {
+	const struct can_bittiming_const *data_bittiming_const;
+	struct can_bittiming data_bittiming;
+	const struct can_tdc_const *tdc_const;
+	struct can_tdc tdc;
+	const u32 *data_bitrate_const;
+	unsigned int data_bitrate_const_cnt;
+	int (*do_set_data_bittiming)(struct net_device *dev);
+	int (*do_get_auto_tdcv)(const struct net_device *dev, u32 *tdcv);
+};
+
 #ifdef CONFIG_CAN_CALC_BITTIMING
 int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		       const struct can_bittiming_const *btc, struct netlink_ext_ack *extack);
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 9a92cbe5b2cb7ccdfca3121718856d096e9ecfa6..76022f48a97673d81676c39c697eadc6d7063ff7 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -38,17 +38,6 @@ enum can_termination_gpio {
 	CAN_TERMINATION_GPIO_MAX,
 };
 
-struct data_bittiming_params {
-	const struct can_bittiming_const *data_bittiming_const;
-	struct can_bittiming data_bittiming;
-	const struct can_tdc_const *tdc_const;
-	struct can_tdc tdc;
-	const u32 *data_bitrate_const;
-	unsigned int data_bitrate_const_cnt;
-	int (*do_set_data_bittiming)(struct net_device *dev);
-	int (*do_get_auto_tdcv)(const struct net_device *dev, u32 *tdcv);
-};
-
 /*
  * CAN common private data
  */

-- 
2.49.1


