Return-Path: <linux-can+bounces-1949-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA609C3A45
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 09:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B441C215E0
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD2A17277F;
	Mon, 11 Nov 2024 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="HE5zLSal"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671AC16A92D;
	Mon, 11 Nov 2024 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731315324; cv=none; b=BCWF3K5n9JgG38BH28ZSidxzHVTjId0XUHdmYKqaIIcwE8VqhidFm44ua8IfHMYwosUB9n+SEHP6NqFcFDcPMhaxILTGfF4wnl4lM9hRtlxL1NQdJhdOEGrM7Ad5o8twK4EKNDAM/IfIzRyvNfIyqmM/YO5ZkEh8bjtfacHj7aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731315324; c=relaxed/simple;
	bh=okXkeaudfF6vxLWD7UajzsUYJHTBDszStlEsrOIBidk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oZlhPMFK0eCZQLlHnX+v2N5OGZaGHaU1y8jE3PibuOeZj1pgI2H3ey0GAvCJOx7SW/2ukEfwI2pGHnwtR0hiW6201N8cdxrbKA1WiNB66kJIfbl3YKUuwsXlwPwBaBHkQFySOyAp4MHBzQaryfdRbHEl0sjAAMr1SuzOiYd6skQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=HE5zLSal; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tWeoJ2YH0hMM/bpEZuLYgNNrB0jkugiqWSczyaTdFrA=; b=HE5zLSal0mQpRQ74F8X8WmeaN9
	KdGMTKrtTaJWZ2y6elbpKzNl3eIfuXY6F7VOsIqbZYmnauC/Xq2W6BeMlmlR9uWdtH2Y8KX91m9vZ
	J1Xy6vuJILbQdKaW497ikTFX1BtYuJMDflgYkw92l5pOrskgZ0bybkdc0f9AUGcUL7vi//7ILJY2Q
	LfqCh4rak4MyhZIzkoql+gfDpfbODyNtyhFCXtbRx6aX4U/VG8ou3/cVhkwk0J9hOXyfEhKty2V04
	ZDzExQ5IgZzNFxEJ9Oz5uyyhnoeKikh4olGYuYq/DBtfXRbStaxliET9/LMMje/pGpSrV1AfRbiwp
	AnIw9B/Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tAQCW-0005w8-3O; Mon, 11 Nov 2024 09:55:12 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tAQCV-000LxI-13;
	Mon, 11 Nov 2024 09:55:11 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 11 Nov 2024 09:54:50 +0100
Subject: [PATCH v2 2/2] dt-bindings: can: tcan4x5x: Document the
 ti,nwkrq-voltage-sel option
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-tcan-wkrqv-v2-2-9763519b5252@geanix.com>
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
In-Reply-To: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27454/Sun Nov 10 10:45:07 2024)

nWKRQ supports an output voltage of either the internal reference voltage
(3.6V) or the reference voltage of the digital interface 0 - 6V.
Add the devicetree option ti,nwkrq-voltage-sel to be able to select
between them.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
index f1d18a5461e05296998ae9bf09bdfa1226580131..a77c560868d689e92ded08b9deb43e5a2b89bf2b 100644
--- a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
+++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
@@ -106,6 +106,18 @@ properties:
       Must be half or less of "clocks" frequency.
     maximum: 18000000
 
+  ti,nwkrq-voltage-sel:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      nWKRQ Pin GPO buffer voltage rail configuration.
+      The option of this properties will tell which
+      voltage rail is used for the nWKRQ Pin.
+    oneOf:
+      - description: Internal voltage rail
+        const: 0
+      - description: VIO voltage rail
+        const: 1
+
   wakeup-source:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
@@ -157,6 +169,7 @@ examples:
             device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
             device-wake-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
             reset-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+            ti,nwkrq-voltage-sel = /bits/ 8 <0>;
             wakeup-source;
         };
     };

-- 
2.46.2


