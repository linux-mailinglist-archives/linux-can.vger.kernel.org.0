Return-Path: <linux-can+bounces-4426-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BFEB41925
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664915476EB
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E902ECD27;
	Wed,  3 Sep 2025 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxbzOgwj"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3752EC56B;
	Wed,  3 Sep 2025 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889521; cv=none; b=TzXYOCND7g04FWHqH6/IImsGFx7bzpPzIeHGw0qMQ+NPoXx+3Ab1NaxmU7a8yPmwLawu7v35999kd0Hiu3jHZzArxZMjQDWXx04om8cIy1RbH8NAeqJy5+KXitcIehyhLWzLDEYD1h9vURF9lTr1heMfFgToIadc+amd9FunEAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889521; c=relaxed/simple;
	bh=T88mFb7sQ3TDbgKtkbXsmLV//5AWUv8klMda8U+nd2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KGsq2d6gMXf+uyIGQm3/qOTEDaTDTzzcKjC+ZGpoE7HMWL/xtTGxCHdeeG3ZdvvO+FzXDJrrLmiwJjsYNWW+TMPlJ6QscSWK/IFrbPZUek0K3Frw/YDKg1qN+8icuCeDviaLf4GdiJ+4g+LhsZ7H59duj03RMPn8ZRGrTyphjLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxbzOgwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDC1C4CEF7;
	Wed,  3 Sep 2025 08:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889521;
	bh=T88mFb7sQ3TDbgKtkbXsmLV//5AWUv8klMda8U+nd2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kxbzOgwjqgyizeKkkC9Dr7gZwyr9On/c/ihcqcGybW8z8aQHI2faImptvejS75jLS
	 5BHfuAwx4gc92zTkfKqsQmoI4iocSrDXofVyDrqsPkv01SJXkRx6agJNKfI1z0FuZG
	 6cF8fDL3/IqxZ2U09Kqgkp313NN/8oIo2B2DjcFr1tkkgWPyw9+mjn1EOK5pLdOOdk
	 5/s7D5iZFGY9b2eQDBsSvPFcUnBwGN9d/3AsInEZ8Tbq8SMD1wzMqzfdcfS0RqgsnY
	 KQeV0PF7jvT5qSH3v3P/+ouSEWC9aDuRRzyFF09yMHLkatb1A8r2u3fFtHn/SAAc4w
	 AZ+Rs9ouC9udA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Sep 2025 17:50:00 +0900
Subject: [PATCH 01/21] can: dev: move struct data_bittiming_params to
 linux/can/bittiming.h
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-canxl-netlink-prep-v1-1-904bd6037cd9@kernel.org>
References: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
In-Reply-To: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
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
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GIs2vbvMy3O/M6ntgk7lRZXFT1bOkI27eXD+t9w7R
 l8mf7Z51FHKwiDGxSArpsiyrJyTW6Gj0Dvs0F9LmDmsTCBDGLg4BWAiuv8YGb5sq+SuYOFbv+TP
 hnthzQ9tzB1q6+etsr4stj/8tZx+fAXD/2iJ9RxTfifckHNmmSV+nXHGfdY7x9+633kat3s7/5a
 UZE4A
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


