Return-Path: <linux-can+bounces-2575-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D761CA08F3D
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 12:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C85188D30D
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 11:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABA520C47C;
	Fri, 10 Jan 2025 11:27:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A920B1F1
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508442; cv=none; b=cU/p2idxZ7xbyDqv5OcbUyQ+PFz8YYxZ9xXfkRhMBfwfDnghEywzLCl5b8D3BLwuZxHD1WgPkAM8MFUMRp/YWzxkQ9pBKlXeE7Rs+6n0bZeDED1iQDiWMIpPmG+f3zAYCn0bQ5jAFoEyi4au/0LtMFtjS0uO2mK7QV39Vg4YLVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508442; c=relaxed/simple;
	bh=Z8ADasKW2JKYXKr8o0oSJY5ZybcDdU+PqXcm94wLYIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFasOuC1GNGGu5O8463DQXusWLOPT4mNWZGlxUTf9YjOEElm+rLATGe2Dn/D+wrLN1LDL//IvwIV3Gi5i46Nyb5Lk8OnVV1guXF7TxlBnSfM0I3m6LRF4oqiXIr4M8mS0hcUomMXs93DOYnniJvFgAxUWZCoUAlw8QZzDcgDGsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAb-0004wO-7u
	for linux-can@vger.kernel.org; Fri, 10 Jan 2025 12:27:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAa-0009dQ-1g
	for linux-can@vger.kernel.org;
	Fri, 10 Jan 2025 12:27:16 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 3AB563A45C1
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:16 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 786823A458F;
	Fri, 10 Jan 2025 11:27:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3e23e1eb;
	Fri, 10 Jan 2025 11:27:13 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Sean Nyekjaer <sean@geanix.com>,
	Rob Herring <robh@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/18] dt-bindings: can: tcan4x5x: Document the ti,nwkrq-voltage-vio option
Date: Fri, 10 Jan 2025 12:04:11 +0100
Message-ID: <20250110112712.3214173-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110112712.3214173-1-mkl@pengutronix.de>
References: <20250110112712.3214173-1-mkl@pengutronix.de>
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

From: Sean Nyekjaer <sean@geanix.com>

The nWKRQ pin supports an output voltage of either the internal reference
voltage (3.6V) or the reference voltage of
the digital interface 0-6V (VIO).
Add the devicetree option ti,nwkrq-voltage-vio to set it to VIO.

If this property is omitted the reset default, the internal reference
voltage, is used.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://patch.msgid.link/20241114-tcan-wkrqv-v5-1-a2d50833ed71@geanix.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../devicetree/bindings/net/can/ti,tcan4x5x.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
index afd9d315dea2..384e15da2713 100644
--- a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
+++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
@@ -110,6 +110,13 @@ properties:
       Must be half or less of "clocks" frequency.
     maximum: 18000000
 
+  ti,nwkrq-voltage-vio:
+    type: boolean
+    description:
+      nWKRQ Pin GPO buffer voltage configuration.
+      Set nWKRQ to use VIO voltage rail.
+      When not set nWKRQ will use internal voltage rail.
+
   wakeup-source:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
@@ -163,6 +170,7 @@ examples:
             device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
             device-wake-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
             reset-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+            ti,nwkrq-voltage-vio;
             wakeup-source;
         };
     };
-- 
2.45.2



