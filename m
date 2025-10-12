Return-Path: <linux-can+bounces-5125-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030DFBD0166
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 13:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7A03BCCB2
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 11:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49C1274B56;
	Sun, 12 Oct 2025 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qV9gDa84"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E59274B40;
	Sun, 12 Oct 2025 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760268263; cv=none; b=dWvhztkVX30mvmEA1UxMklMTTq6KbLWqYtpczgbKPa890xQvASU9i/qwu+Qkxnysvk0uGIqJ7FtQQ0AGGFE54kgmXwpGAk4dfGEgkX8Y6N9GtdxRTkzbnSbyoVFgmEYzgsnglxpsq2w3p/RUWwLdrz5XIMu9mMVBIuSZlSJrmJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760268263; c=relaxed/simple;
	bh=IF07Mt8rYmUujU1hE7dfnLqFNnP79CelssmnQbjwpiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FeskOalqQbOULBKUp14ujBU22+bj85/IRX/i95YFhO76R6kETTxMAMupAoXntnSipR9sK5xCqtVAFFWbNu/6+9wlgV1O02LuX+X6WwuhVH/e5YDNCFlBsXrB6VLLAjPPa1TmLl5l5xPYLPrRg0Vocf0LnCQGVkJtvx3wG6u3jO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qV9gDa84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A0CC116D0;
	Sun, 12 Oct 2025 11:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760268263;
	bh=IF07Mt8rYmUujU1hE7dfnLqFNnP79CelssmnQbjwpiA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qV9gDa849luF9pS3ep8osjNW551NYhmIU8gnYWTEuQRwQ/xuGF+YZD5XX8UQfNEQ9
	 smM9sw/fkzd7SIxqr4jlS5WnlB6omrILMlXKXIy6xMjOtLYHRY+XPKg3+c95O7YlvR
	 gjTmuBGcq5t4X3Z5LPtuR4J16jYYpuLEBJ6ZrS2tT6Xm8oGaQlwjXuWej0D3//nCV7
	 R11k/0vbDT7q8sPUqcA/f4++RFyyROIYXQDOXTwzINx26ev9J8L/25Q7VhJg241VAI
	 AC/psM2DDbubL9SDNUQqfXrQcvQ0XSuYAXW3X3U9ZMEKDC84cr0U5ym2t9wB3mFqde
	 jeOLkUl5aydCA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Sun, 12 Oct 2025 20:23:43 +0900
Subject: [PATCH 2/2] can: add Transmitter Delay Compensation (TDC)
 documentation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251012-can-fd-doc-v1-2-86cc7d130026@kernel.org>
References: <20251012-can-fd-doc-v1-0-86cc7d130026@kernel.org>
In-Reply-To: <20251012-can-fd-doc-v1-0-86cc7d130026@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4110; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=IF07Mt8rYmUujU1hE7dfnLqFNnP79CelssmnQbjwpiA=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmv++/OuMc0vahLVXWS8lWtGQqlwn+FpEOEorQ+69k0P
 1jzi3VKRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgInsVWL4Z3t+z4eZ882/+cZv
 ui/dtP7XrZwq5gnNR/7cXFQUc2xPRSojw52tB64m8jL/k6ry+HUit2Wrx2G7yCdzXNIlxGtOnJU
 pZQIA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Back in 2021, support for CAN TDC was added to the kernel in series [1]
and in iproute2 in series [2]. However, the documentation was never
updated.

Add a new sub-section under CAN-FD driver support to document how to
configure the TDC using the "ip tool".

[1] add the netlink interface for CAN-FD Transmitter Delay Compensation (TDC)
Link: https://lore.kernel.org/all/20210918095637.20108-1-mailhol.vincent@wanadoo.fr/

[2] iplink_can: cleaning, fixes and adding TDC support
Link: https://lore.kernel.org/all/20211103164428.692722-1-mailhol.vincent@wanadoo.fr/

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 Documentation/networking/can.rst | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 58c026d51d94..de9e7549859f 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1464,6 +1464,66 @@ Example when 'fd-non-iso on' is added on this switchable CAN FD adapter::
    can <FD,FD-NON-ISO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
 
 
+Transmitter Delay Compensation
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+At high bit rates, the propagation delay from the TX pin to the RX pin of
+the transceiver might become greater than the actual bit time causing
+measurement errors: the RX pin would still be measuring the previous bit.
+
+The Transmitter Delay Compensation (thereafter, TDC) resolves this problem
+by introducing a Secondary Sample Point (SSP) equal to the distance, in
+minimum time quantum, from the start of the bit time on the TX pin to the
+actual measurement on the RX pin. The SSP is calculated as the sum of two
+configurable values: the TDC Value (TDCV) and the TDC offset (TDCO).
+
+TDC, if supported by the device, can be configured together with CAN-FD
+using the ip tool's "tdc-mode" argument as follow::
+
+- **omitted**: when no "tdc-mode" option is provided, the kernel will
+  automatically decide whether TDC should be turned on, in which case it
+  will calculate a default TDCO and use the TDCV as measured by the
+  device. This is the recommended method to use TDC.
+
+- **"tdc-mode off"**: TDC is explicitly disabled.
+
+- **"tdc-mode auto"**: the user must provide the "tdco" argument. The TDCV
+  will be automatically calculated by the device. This option is only
+  available if the device supports the TDC-AUTO CAN controller mode.
+
+- **"tdc-mode manual"**: the user must provide both the "tdco" and "tdcv"
+  arguments. This option is only available if the device supports the
+  TDC-MANUAL CAN controller mode.
+
+Note that some devices may offer an additional parameter: "tdcf" (TDC Filter
+window). If supported by your device, this can be added as an optional
+argument to either "tdc-mode auto" or "tdc-mode manual".
+
+Example configuring a 500 kbit/s arbitration bitrate, a 5 Mbit/s data
+bitrate, a TDCO of 15 minimum time quantum and a TDCV automatically measured
+by the device::
+
+    $ ip link set can0 up type can bitrate 500000 \
+                                   fd on dbitrate 4000000 \
+				   tdc-mode auto tdco 15
+    $ ip -details link show can0
+    5: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP \
+             mode DEFAULT group default qlen 10
+        link/can  promiscuity 0 allmulti 0 minmtu 72 maxmtu 72
+        can <FD,TDC-AUTO> state ERROR-ACTIVE restart-ms 0
+          bitrate 500000 sample-point 0.875
+          tq 12 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 1
+          ES582.1/ES584.1: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 \
+          brp_inc 1
+          dbitrate 4000000 dsample-point 0.750
+          dtq 12 dprop-seg 7 dphase-seg1 7 dphase-seg2 5 dsjw 2 dbrp 1
+          tdco 15 tdcf 0
+          ES582.1/ES584.1: dtseg1 2..32 dtseg2 1..16 dsjw 1..8 dbrp 1..32 \
+          dbrp_inc 1
+          tdco 0..127 tdcf 0..127
+          clock 80000000
+
+
 Supported CAN Hardware
 ----------------------
 

-- 
2.49.1


