Return-Path: <linux-can+bounces-1990-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8879C5BE0
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 16:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 287ADB66D9E
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 14:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D9A1FEFD9;
	Tue, 12 Nov 2024 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="arKi9Ak9"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698701FCC53;
	Tue, 12 Nov 2024 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422411; cv=none; b=AhiMdznf03CElx2ByhMSOqVlvkvr2Z9LynFB5LuRnCuAuxn6sobwmNv4lfrDUP0HBhWKxiU++E30hU0kkUfWd9IS1bTAsLEcYNgkRhCSs/443eN2pHtZF8/x/y8Utixnc21qwArCpRrI+6AOh/+tTdC+FjSoNek5C5d4HDb9I2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422411; c=relaxed/simple;
	bh=kofAwE413KFR20Q1XYLElSNNM5WU5V1y4wSpcK5C3yE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E0I0b4k24S+tePXfgpjSkjnqKn9l6vjJ/SfhvtXAgB4+20kmCfcEQ+4/eKZFmpsxH8I339eQ5qtPQkE3m3UMfdNY2WdjhQ4MknqseoVxtFSPBrGNwSbXRkUL1KIqwh/Ac6sWJx0opB1TSKvFBh6XIP8ODyXrFO2SpVZ1fKnCGxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=arKi9Ak9; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mDUlmlI+FNV7Itd5Gyb//cN6kddYrXXM6mzU74/ED54=; b=arKi9Ak98nNBN2rJPGa/k3fN9R
	epyQdB5IvEStbS8NJIXhTTX1tpWpyqVCVEAnuyqunoboidN1HluX9yV+jslTTU8GeIeN5+k6cHizc
	4Sy/41tOOvwqztNxMaVpFbhk59yE2sQOzFSSE31kqK80rzfpqseUrY2wy4PR1q7RcfIZlAvQ1VA4v
	kvslAT45bwzSmb/RacqdswaG7RpMrHn/RSGLlRGduhmPaSGQd/ZylQrIHSY4xjl3MuNnSCop0ejBu
	yVy2SsZDU+4Q2b/mnX/eTdu4M4vLbqs3INoQ3dwP/msIg5tP3L6VXE0Cmac2cXDtHV8p7I9gaLtK4
	tckBIVrg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tAs3p-000Mzx-C8; Tue, 12 Nov 2024 15:40:05 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tAs3o-000GXH-23;
	Tue, 12 Nov 2024 15:40:04 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Tue, 12 Nov 2024 15:39:39 +0100
Subject: [PATCH can-next v3 1/2] dt-bindings: can: tcan4x5x: Document the
 ti,nwkrq-voltage-vio option
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-tcan-wkrqv-v3-1-c66423fba26d@geanix.com>
References: <20241112-tcan-wkrqv-v3-0-c66423fba26d@geanix.com>
In-Reply-To: <20241112-tcan-wkrqv-v3-0-c66423fba26d@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27456/Tue Nov 12 10:49:43 2024)

nWKRQ supports an output voltage of either the internal reference voltage
(3.6V) or the reference voltage of the digital interface 0 - 6V (VIO).
Add the devicetree option ti,nwkrq-voltage-vio to set it to VIO.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
index f1d18a5461e05296998ae9bf09bdfa1226580131..ff18cf7393550d1b7107b1233d8302203026579d 100644
--- a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
+++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
@@ -106,6 +106,13 @@ properties:
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
@@ -157,6 +164,7 @@ examples:
             device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
             device-wake-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
             reset-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+            ti,nwkrq-voltage-vio;
             wakeup-source;
         };
     };

-- 
2.46.2


