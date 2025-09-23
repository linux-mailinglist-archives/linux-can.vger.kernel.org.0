Return-Path: <linux-can+bounces-4835-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46290B946F3
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1B22A670A
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429C130DEC7;
	Tue, 23 Sep 2025 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWL+wKg9"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198DF30DEAC;
	Tue, 23 Sep 2025 05:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606049; cv=none; b=HfQBdLeGllJTebUn62YPgJJMaXcOSrixwxuCF/zM4JbYbY8nCpLC22c2TR+jVH8OKh78Wv9MsTiJPVgdIHQg7/pyxWSRmEj58A71CFtRwQG8Lo1fLdHTbDNwM6/rniZCNhxPrvrg+zBI0zJ0NryoWDRaipGAM6z7O5fkl+heIos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606049; c=relaxed/simple;
	bh=Ou2rl0hYpUZ4J+DceB3A9S+4eN1YIUuXOKAXbdhHuLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=izV8hOmFOI05QssNvBq21V9XFOj/7VBzJf+y0xiMFRek9SrMOwwcQDTwib5ZlPz/8k6s8Aw42/WO2JKVdy34OlWHef1pnwZCQPYHmnOQKdbacPJ4twMXZbL2icYk5onNxcLZdo8uysFhR6E7D30g7C3SwK4sJaDg/8Kg0Ub9wYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWL+wKg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8126BC116B1;
	Tue, 23 Sep 2025 05:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758606048;
	bh=Ou2rl0hYpUZ4J+DceB3A9S+4eN1YIUuXOKAXbdhHuLg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MWL+wKg9BGSQUDkab0yhmQqfNKGgni4/vfUZF2E40NKbMWjcHOPslZ38vSmGo0uH9
	 gPUYFrgh1NRnHD+OHoKwlPgkd3X5iGrVBTYSJ81i4V4qiJiAnCUd2JvyW0KWdkTQk8
	 Uyf0xxrAS8yCK49ZZCDksG0RwIP/8KoRXcD/0ny5CwHMIRTWGK30FGmMdOx5YSpoPE
	 JpVOGchy87auI2mEngQ7OxQtPpiznD+DY/tWtUW5srCcawpJw9fI/7yoq/85Qt1TtN
	 A650ei4Rnw4ufiQ5ZUFBHAt8J+PPiHZEQUWjJ2JoxVRcOfFLsCDFyU3faaOvBD1Qlz
	 93AaiPlX4fH4w==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 14:39:36 +0900
Subject: [PATCH v3 01/20] can: dev: move struct data_bittiming_params to
 linux/can/bittiming.h
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v3-1-87a7684333f3@kernel.org>
References: <20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org>
In-Reply-To: <20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2460; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=Ou2rl0hYpUZ4J+DceB3A9S+4eN1YIUuXOKAXbdhHuLg=;
 b=kA0DAAoW0WQ+QNd/fbMByyZiAGjSMqrIYsO5dVHavwfyq6d8jQSetEzMfcORB9jzWRm/EpNFC
 4h1BAAWCgAdFiEEpncJCyCIcUtWwv050WQ+QNd/fbMFAmjSMqoACgkQ0WQ+QNd/fbOotwD/d11f
 VVMS0eUFMqA3Dz1a6n7b1zFWVB8fhMDZ5lAwLk4A/RWW9yTtIpPgYajTg/MnHay8QZxh45ENR0A
 e8sGBC6UO
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
index 3354f70ed2c684d7d482549560d4cb5838cbebd5..c2fe956ab7761f45a87e77131bb57e9d5d51dd7f 100644
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


