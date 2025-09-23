Return-Path: <linux-can+bounces-4862-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A24E7B94A25
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 08:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AF73BD13E
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 06:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D6F30FC1A;
	Tue, 23 Sep 2025 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW6m1H2R"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F77230FC0C;
	Tue, 23 Sep 2025 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610787; cv=none; b=IEbV020UYHum+kEaHyaMkqozQrf+QnJXkee4ZUTq+OKLHYTuiwwzSkGzfnAB94QP3W9VUIjOHpmfiiFQjnZI2z9M4pfmPKlHh42A93cOR1E2L7bjavKyJLoNyuJze/Fvr7bsb1W0DnXSeji6+rd5LMuGbD6VX/O0nhJ3jzPtbzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610787; c=relaxed/simple;
	bh=Ou2rl0hYpUZ4J+DceB3A9S+4eN1YIUuXOKAXbdhHuLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IYxVrhMtVOn0nxO16h6xkMo1grOmwhJQVqTHCqZCmq3dd38BZkD3Ozp3iaKmIwnP6z3Es6EKt2iqQ1Aavp1nqZJbWfmL7uABc0ru7p3+/5hcryJqNvBrV8RFuK00XowPPPF5IAqtNEanPJ2bCZ52zLSUV/wPI07WgLWYejxRYBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW6m1H2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111CCC116B1;
	Tue, 23 Sep 2025 06:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758610787;
	bh=Ou2rl0hYpUZ4J+DceB3A9S+4eN1YIUuXOKAXbdhHuLg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NW6m1H2Rc5tnCadT+2HqxC0v4kvd514lWQmFev3unIutBwJGs2dH+fwDulH2Aj0iL
	 iHauMk+B/jd8J6XMmvjLeRjKsBgVU8gBj4wxLRxFnCRa3IrSYmgswstB39RtTzmndm
	 4oo+rExYwynMvwCPBBFJyiZfKwCOlMKD2rFR5KnMcvBv5vtcs8NXh7z/9A2lJOIfDk
	 cclLC3Fsvw4YC/zEwGMhXzLWuyE996lKPqWQi65rK79Qjh6tcjm9JrVsaRl4VrN738
	 GJG7Z5mTBHrJDC/BBIBNm3/oib3hQwIcaHkuOV5C7NKLI569cgXpndcThz27d8noRu
	 wikfKNRBX3ubA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:58:26 +0900
Subject: [PATCH v4 01/20] can: dev: move struct data_bittiming_params to
 linux/can/bittiming.h
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v4-1-e720d28f66fe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2460; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=Ou2rl0hYpUZ4J+DceB3A9S+4eN1YIUuXOKAXbdhHuLg=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXXFUFWbV+uXWuuu316cGMV8snRTZN2HZzpSin2oZ9k
 YZfFU4u7ihlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjCRbi9Ghnu7bVz2ccx+LFSy
 blW6gcvP3Hnb2lt+r9/2d2ZK2LtrJb8YGX4kSR66v/D8Js95ATNfn9x39rLBxiS2rNa/ztPir78
 +UMcLAA==
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


