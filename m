Return-Path: <linux-can+bounces-4618-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D11BB50DD0
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E85154602F
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C45030DEA7;
	Wed, 10 Sep 2025 06:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5fejeCG"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7D30DD38;
	Wed, 10 Sep 2025 06:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484316; cv=none; b=KbwxCzZaCGA9MQR5hNEq0p5pqZZIwXNmJo1LiIZHoMosSHOzOLRoUREYhSKdm6WjRRZ3On1KR5RnL960F1Y9wWVW2oykoU+D+uAWGN+69TdaOF1dGKAW2ijCt2razZTbe0CwqNz0XZNnOuWnFLeGC4DnHs4OcFbQForSBUBVcg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484316; c=relaxed/simple;
	bh=6hC3+gNUpUdXFVXOXPAVa6F6CDMtqk3DayLs5ctqINQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WQkg263DJa4PKdlPIp50wLVX833osuW6pd5asYzdUHJ+bEA+pCALLs7pyWfnIq7ITsSFpwjLQ3FWX/tZytASOBDGYHJKCiz/XhbaAympwIlPqH/KAbDuTBAU3f5F/2uSlV61rdeMx+MneLWH4DoBvOaHdBoMHN2DKrPxmgACzR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5fejeCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58C4C4AF0B;
	Wed, 10 Sep 2025 06:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484315;
	bh=6hC3+gNUpUdXFVXOXPAVa6F6CDMtqk3DayLs5ctqINQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W5fejeCG+SBgkv7ZbxtfMYPrSx1boxzV9efguhTW8EOkJICYOAoiTB/lk+t8XemLp
	 1B0xbMvzzHvhmWG9wH7tFf/ZqVRqRxAhwDREMfa+gkeoiovDWZiygl1uuZHxza40p5
	 fehLWc+TRP0Wil5cLbA5CsoF24GULRbyKMoEXagbZHE8WtTmNOj1WtNifqGT655cwK
	 ji8JJuXAl0HnMYlrT4C01afCLyCOmmXVrhZdcSdnsDCUzP+xYffHow/eONZox2wiBK
	 QVkXa5CKZWE0K6VssVvX4VX7wTL0ZeBbx3Rx7jUs1OJZ8f8RNPHHhPjKZKmE8AmBrf
	 ZbYVPD0fRCEZg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:44 +0900
Subject: [PATCH v2 19/20] can: dev: add can_get_ctrlmode_str()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-19-f128d4083721@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2864; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=6hC3+gNUpUdXFVXOXPAVa6F6CDMtqk3DayLs5ctqINQ=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRb6nTNPReWry5d+h28yeB9993fjKJHNl+16d4H/N6
 7gmrxI721HKwiDGxSArpsiyrJyTW6Gj0Dvs0F9LmDmsTCBDGLg4BWAiZicYGc5a+5wxczr3xPuK
 mMi5NuYdBy588LA3sl+bPENRoaVMVZ3hD8f5xw7OQVtrXxg/eb2to0OWZfqqH9VrtPn1l+2o6V2
 9jAkA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

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
---
 drivers/net/can/dev/dev.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/can/dev.h   |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 3913971125de0ab16b4ad9f36712954141014ddf..d9368ca828fffbda45a19af78e4f8271acfba6c4 100644
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
index 55aaadaacf68f940fa1b71f7c438e68b84080292..27690a8bea44d334bf1ac8f779ae36189e0e1493 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -159,6 +159,8 @@ int can_restart_now(struct net_device *dev);
 void can_bus_off(struct net_device *dev);
 
 const char *can_get_state_str(const enum can_state state);
+const char *can_get_ctrlmode_str(u32 ctrlmode);
+
 void can_state_get_by_berr_counter(const struct net_device *dev,
 				   const struct can_berr_counter *bec,
 				   enum can_state *tx_state,

-- 
2.49.1


