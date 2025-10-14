Return-Path: <linux-can+bounces-5190-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85970BD9EDF
	for <lists+linux-can@lfdr.de>; Tue, 14 Oct 2025 16:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4109501F43
	for <lists+linux-can@lfdr.de>; Tue, 14 Oct 2025 14:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E846315D3F;
	Tue, 14 Oct 2025 14:10:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F25E31577D
	for <linux-can@vger.kernel.org>; Tue, 14 Oct 2025 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451034; cv=none; b=hI8CCMc3v8Zup0U0Tmbk7yW1NOKY7mXJqFxDWYnO+nJFQT2Lul0w1frKxmshHkVRF/Z5viNsmw5GePr/dovfsl+EhWJxblu1/x/SqqtpMWZ+SiaSKZj40v2CkIMJ3c9jgxeQ0WsN94QXGqH5leF6cJNPE5B3DFwnGIMRJfGJFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451034; c=relaxed/simple;
	bh=gXat+PGv1u78rWVjmOz0QjCschIiYBwYOHwql3Mg3VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nv9QVPPgFXM3mTF4/gdCuxDU8L1bNx7jx4wEPbmLW7KlrCCTYbZpDWKVZfByt8YypChlzIUqOESvzh1e4erJuVH3F6rONRe0gHfPaV5LNXVvDGT9RR3iXkVU6HcBRlwHvztAiPaNbrohH1exG/mfuqovsFuaa/pNd0Sn0Ouum+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8fjK-0008IN-Ua; Tue, 14 Oct 2025 16:10:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v8fjK-003ZQB-2F;
	Tue, 14 Oct 2025 16:10:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6DA40485F1D;
	Tue, 14 Oct 2025 14:10:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 09/10] can: add Transmitter Delay Compensation (TDC) documentation
Date: Tue, 14 Oct 2025 14:17:56 +0200
Message-ID: <20251014122140.990472-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122140.990472-1-mkl@pengutronix.de>
References: <20251014122140.990472-1-mkl@pengutronix.de>
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
Link: https://patch.msgid.link/20251013-can-fd-doc-v2-2-5d53bdc8f2ad@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/networking/can.rst | 64 ++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index ccd321d29a8a..194e305ae973 100644
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
2.51.0


