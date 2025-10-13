Return-Path: <linux-can+bounces-5152-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D819EBD27AF
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 12:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2D21883D18
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 10:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8A72FF64A;
	Mon, 13 Oct 2025 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUpr6Wn3"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0062FE57F;
	Mon, 13 Oct 2025 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350247; cv=none; b=PAdTYshjPylpsNWuJlKYw5HraTAHVGedaxYPb9jqHLTz5+ifF6YWkEigHsB7UwFza2eLvTlIb4OK4NrmeEPqO7orBWdaH/QzvfVS77SR9WNAUcDGD+Lwzij2lUgrqdOFuBqQwh/G6Hc3xVuEhESY88mWDqzG07fjQMesp1+3msA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350247; c=relaxed/simple;
	bh=UXzW5+EctH3GaFeqw4m/HhrRryx1k8DJ0dDcoUah8xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GzOxX/T1t0XZlAl6ghpLyHr16u67IE6s8rzdj6+8punxQrPl0cJt0aRPxP5qg2BJ6GFUtVzBfCvVs85S00YiquAu8kdLE7t+/9fTAsLXciFqrQcdoKaX3Y8FKcUvBLYMVA+mbcwT6vhbGnAY+HgRF8KwlIpXCAk8NnUUCVI5dHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUpr6Wn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58297C4CEF8;
	Mon, 13 Oct 2025 10:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760350246;
	bh=UXzW5+EctH3GaFeqw4m/HhrRryx1k8DJ0dDcoUah8xg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mUpr6Wn3wEwNmfRWTcCDPR9qBkGsLByCHTnO8wEBFyQz002ZOEc+ATiPb9KrfIfaS
	 U7JDXz0GGUfRmZSewTmt8nPDyKYvlugTmuXNkYZelSYSOVmQM5Z2dS08rAOf4YKKkG
	 xDWRTGSgzAPoDH4SWDDGkijlF5OIzXupsjn1cC8wBG+EwxX6yiLQ1CQM7TBgrXGodl
	 rvkWQDlC+FdISZ8Y/j2l+fBqtesYgzfzmDDRvT9fxucXqP9OBDVpYbH3BeTvUF10EA
	 n3F+/fxyJIm0KgwRPWPvc/KdGe86Y9EKNsaCep0eSkhk9W/iJdcCwsyGTLWx7rjWcG
	 RSk8fYjMLaQjQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Mon, 13 Oct 2025 19:10:23 +0900
Subject: [PATCH v2 2/2] can: add Transmitter Delay Compensation (TDC)
 documentation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-can-fd-doc-v2-2-5d53bdc8f2ad@kernel.org>
References: <20251013-can-fd-doc-v2-0-5d53bdc8f2ad@kernel.org>
In-Reply-To: <20251013-can-fd-doc-v2-0-5d53bdc8f2ad@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4385; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=UXzW5+EctH3GaFeqw4m/HhrRryx1k8DJ0dDcoUah8xg=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlvLshEZ82oMnB4mHZp5fn1PQd2WyjZH+RsLJ06cVpT+
 KtTcvuLO0pZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAEzkKgMjwxGdN+u3PFBPYMjd
 mGS61XvX7/TgGW3Tr1gwTPp890jKrTxGhg8Hs3aFpmn+O7m378sHZa6XXcEHJYuURUyOtrvoO6/
 kZwEA
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
Changes in v2:

  - Fix below "make htmldocs" error:

      can.rst:1484: ERROR: Unexpected indentation. [docutils]

  - Change from "Bullet lists" to "Definition lists" format.

Link to v1: https://lore.kernel.org/all/20251012-can-fd-doc-v1-2-86cc7d130026@kernel.org/
---
 Documentation/networking/can.rst | 64 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index 58c026d51d94..536ff411da1d 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1464,6 +1464,70 @@ Example when 'fd-non-iso on' is added on this switchable CAN FD adapter::
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
+using the ip tool's "tdc-mode" argument as follow:
+
+**omitted**
+	When no "tdc-mode" option is provided, the kernel will automatically
+	decide whether TDC should be turned on, in which case it will
+	calculate a default TDCO and use the TDCV as measured by the
+	device. This is the recommended method to use TDC.
+
+**"tdc-mode off"**
+	TDC is explicitly disabled.
+
+**"tdc-mode auto"**
+	The user must provide the "tdco" argument. The TDCV will be
+	automatically calculated by the device. This option is only
+	available if the device supports the TDC-AUTO CAN controller mode.
+
+**"tdc-mode manual"**
+	The user must provide both the "tdco" and "tdcv" arguments. This
+	option is only available if the device supports the TDC-MANUAL CAN
+	controller mode.
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


