Return-Path: <linux-can+bounces-4880-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDAFB94A8E
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B977484254
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFF13168E1;
	Tue, 23 Sep 2025 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6gsdmPL"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA79316189;
	Tue, 23 Sep 2025 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610816; cv=none; b=FtetiPyDMBkpxsPzdG8sg6w2PmIzRBBCDsvrWmed0LMD+UPcF+6Qm751fu3m9lXR/elB6iOONUD3py1hmc8QIDY1xnoHHkHlSGLlgONTqZqq095eKzvHhbWcAzhVBYlPT82oIBsBh5tjzyVG5qpalyWSaJVryoJAVBLyd1H+0xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610816; c=relaxed/simple;
	bh=7HuM9GT+2Kd+y3dPkOdkf++eyBOX+SiqQUavEx1WCQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hWTrgzFGi90zVyYTfds+7gW1jYmtMkuKq65lIDNECjymkd/G85fWUw6zlfamCT63bk1gzpWBtBFofBbs2xpzunZUOXXJD7x1h3y0I8ECCFLLRPvABwjA38jYOq9PmBCeqk6R0cPaGqU/9lAFHe95d/GrlntlfRCLFo4hV+QZ4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6gsdmPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B93C116B1;
	Tue, 23 Sep 2025 07:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758610815;
	bh=7HuM9GT+2Kd+y3dPkOdkf++eyBOX+SiqQUavEx1WCQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e6gsdmPL0QQfftdEKZg1769jKakhQvw8l8Ok6en3AwIeCm0JZjrci+SMZAOmfCT4F
	 Qu/4FCqqprCTB3kH0h61rHDbD7Huiltu46tRZXjjXltnBBrvUpglYAakUO7E8JxZUm
	 zL6gc2DexVtKCa4sWVvJtEPmVa5zBKUwyUAv05e1DSXhuYJWhJL5C2K9HtVi0DtVii
	 S+1R4uR97eNfIgDhk0Vrhi1F3tO5ynQmAqB0r3t4k2M0wV5mlVzV0Pwb88JCGhmXho
	 Q/MXCT7pCeFrluYWl1IKOV3QYHC4LxGGJUEYS7IYZ22pbxP8pbmqH6kuZEjODadwt0
	 7U512nCjWqgxw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:58:44 +0900
Subject: [PATCH v4 19/20] can: dev: add can_get_ctrlmode_str()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v4-19-e720d28f66fe@kernel.org>
References: <20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org>
In-Reply-To: <20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org>
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
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXXKO/upvdPHTKc5rsAunampILT9ac/u4jsORQ1uXF+
 veu5Ub96ShlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjCRmTGMDA9kFkdfM3jsGiET
 bXJ2yumjCUfCdCbtDZjeHcZdtUlNl4uRYfnJkKuNHTP+FFzY8LDl3gS/gISWqNnvOG+1ct58vFM
 8nRsA
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


