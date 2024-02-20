Return-Path: <linux-can+bounces-324-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9FD85B5F0
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 09:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513A71F21DC4
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 08:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF7B60DEF;
	Tue, 20 Feb 2024 08:51:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816045FB92
	for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419100; cv=none; b=fHK+lywLSisRcoZb1mIJZkrb0MTqUG6AKfMORiG31oDoURsdg5GGozZwIsi7i6yWW08Qzj8xTZoYOtFpsYYZ+macp7+UzZg/wFsKnayqqPHqcwHZ2PLcEP4RJ2qlzMwYqpWqyyzaoVTHpSRc2Eh7Cnf4++nTLoAZ4sRI81Oo1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419100; c=relaxed/simple;
	bh=E0rRfZddXPrWWpeneYyGHFfXelNvfBWI/h9S7P6u/b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xa8iEy0fwYtXxjnGMSzUpuIWGi1sXd1Tnag/rSyX7A9xnduJX3EcTXcd8lUh40OUV4ItMTrb+KxBYMA3xICDxj0DQMBsdgyaGNn/EcCUGnqElXsjVVBBRAhGDqOL1KJCLCyQRVMgWVg21cu+oxReC6FOkbSHTy1FjXyOo51IYho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLqi-0001eq-Jf
	for linux-can@vger.kernel.org; Tue, 20 Feb 2024 09:51:36 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLqh-001oFg-9V
	for linux-can@vger.kernel.org; Tue, 20 Feb 2024 09:51:35 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id F2826292F21
	for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 08:51:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B3D4E292EE4;
	Tue, 20 Feb 2024 08:51:32 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 17a1fe9d;
	Tue, 20 Feb 2024 08:51:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Srinivas Goud <srinivas.goud@amd.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 5/9] dt-bindings: can: xilinx_can: Add 'xlnx,has-ecc' optional property
Date: Tue, 20 Feb 2024 09:46:07 +0100
Message-ID: <20240220085130.2936533-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220085130.2936533-1-mkl@pengutronix.de>
References: <20240220085130.2936533-1-mkl@pengutronix.de>
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

From: Srinivas Goud <srinivas.goud@amd.com>

ECC feature added to CAN TX_OL, TX_TL and RX FIFOs of Xilinx AXI CAN
Controller.

ECC is an IP configuration option where counter registers are added in
IP for 1bit/2bit ECC errors.

'xlnx,has-ecc' is an optional property and added to Xilinx AXI CAN
Controller node if ECC block enabled in the HW

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
Link: https://lore.kernel.org/all/20240213-xilinx_ecc-v8-1-8d75f8b80771@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
index 64d57c343e6f..8d4e5af6fd6c 100644
--- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
+++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
@@ -49,6 +49,10 @@ properties:
   resets:
     maxItems: 1
 
+  xlnx,has-ecc:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: CAN TX_OL, TX_TL and RX FIFOs have ECC support(AXI CAN)
+
 required:
   - compatible
   - reg
@@ -137,6 +141,7 @@ examples:
         interrupts = <GIC_SPI 59 IRQ_TYPE_EDGE_RISING>;
         tx-fifo-depth = <0x40>;
         rx-fifo-depth = <0x40>;
+        xlnx,has-ecc;
     };
 
   - |
-- 
2.43.0



