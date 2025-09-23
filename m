Return-Path: <linux-can+bounces-4853-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFABFB9475C
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707D0440534
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51F131B828;
	Tue, 23 Sep 2025 05:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oi2D2UQU"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FCC31B12D;
	Tue, 23 Sep 2025 05:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606076; cv=none; b=tZ8lUmmnYYbhg7n6QOB2Hd7MK40mIpZZjWNaHrHXEwhoB8l+vhK1RMxohE0LCpitHZ3EKcy6Ng+cxIka/bv1SB9K7ANYjNJfQZsA2WZ/vUSy/nXaBYc1qmqLq+w01tHcQjEGbpf1iUFRRSQr6QZgq/SFkaQn05CZ65TzkUFg3D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606076; c=relaxed/simple;
	bh=7HuM9GT+2Kd+y3dPkOdkf++eyBOX+SiqQUavEx1WCQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l8LPd8yzYB2Bmhu9TLIGMw2vyAxTO6ppBXMjslTF0RzAusTCOcvJzf0ZyCP5s45c3HPM7em4r09nYtDdEITgO2CYDj/E/luoc1XivD8TKA0YW2RAMACFHcLP+veEmmJsgFZWZBscFtz4qF/YLQ1r1ocoNtQ8rxNGpLDUn09X4to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oi2D2UQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B697C116C6;
	Tue, 23 Sep 2025 05:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758606076;
	bh=7HuM9GT+2Kd+y3dPkOdkf++eyBOX+SiqQUavEx1WCQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Oi2D2UQUmooyW6KGyVPyk/TN8MxysdbwbqNGDGuIjGpue+zXn5xmnkjr/+z4zLDuS
	 cO6ngDaoyLYGHqHGpFQiS2O4sn/qV8Y1VRCIsoVxicDBbNKPBUI2g8JBf0PeqfkYNu
	 qVpr2ejiIO7bpQ+tblqq8uLkDBEqcbLxxQSTho4OP3IcMWpPuhH9/x6FpTiXCPdLz5
	 zkfIycqTovDFswJtNcdHfiidk7Y3fqLI2vjVHtNCmyveiPVWvNGgWEkek98YDYfeAz
	 on16GJjxuxFp3Cl/190ipaoIUrus/fsUSLWDp6OPLSverd0Vtu648yHnKO87R4BNtd
	 p9cE++YF255mQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 14:39:54 +0900
Subject: [PATCH v3 19/20] can: dev: add can_get_ctrlmode_str()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v3-19-87a7684333f3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2864; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=7HuM9GT+2Kd+y3dPkOdkf++eyBOX+SiqQUavEx1WCQw=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXjG6YC2+0ck0+KbqkeOEKgzP9z7VnnagU5sivURGVm
 zd9jmpqRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIkYHWP4790nrtT/M1NSaeaz
 GSoWzZvrz88r2ORbLnJTui4mYWKrJ8P/ypIJsuqG/At71Fde0vlSanY5SbspP32OeR1rr03ccU0
 GAA==
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
index 69c00720e9956cad986ea86fbba49285d76f51db..9ad062dee261cc7ad431959ef4c4bc1d24a2736d 100644
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
index 8e75e9b3830a7a0dab16b6450622fc4a98219a9c..a2229a61ccde8140f3cee83ce6ee66fcfd726a34 100644
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
2.49.1


