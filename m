Return-Path: <linux-can+bounces-2029-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E9B9C854B
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF801F225C6
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 08:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568C11F76AB;
	Thu, 14 Nov 2024 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="0gscDICt"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C99A1632DE;
	Thu, 14 Nov 2024 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574377; cv=none; b=AG+qQGnIRqXq5s1SvOsOFSSjj+Ia+AZh1mUJe1Eu/9c6jmZK/1qV5qRCZWiPbxM++Rd/pTOHGxf2AToG0uFyV3QZEvLAi6CoQILuJnKU26RYORKRaQNvNSFK7rrZFjVWzxubmC0StP0vjV7PgOTxAQwfcyZ7L7b0RKAA0fRltX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574377; c=relaxed/simple;
	bh=JTHP1E6txsT5jDiSekLwyUCkPVTFlgYbGEwq5UX1hGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LOgSf4Ct6VMK1oJbB8+ypkokRUJkrQ1o6GGE1fHnAex9gru33vZVulK/Yb+phVXd3tGP/87QF3Yv8B1Q0hKjNRjQMaLXNPjZdLk4GT33oNlW1xCS8JcJHjc4GWszZI2wt7qNusDpArnypn7jp+O5T5LlvmuYSXnI0YUumH0WWqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=0gscDICt; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YtbN+aZcwI37v2vnWXUL5gpC9O6aop7q/s7EDhL0JsM=; b=0gscDICtg1PzPDPTgaSen+4+4T
	1qsPE8UBQ19wYPuPj5OVj7s3FfrByBMrW5LcLIDTLCv4u/NX9FZsPkQzPtbuAyyvCtLJ5oXnPGhOS
	Lyp17x8C7T5bN675BdLEHgnfPLaEDxOQ+RCDJzdkURaLpFH/SuBmZZ4P8VMJazMkc5N2p0x20ROk0
	LYH/YbKlJrOvEW13+yCAbWMEjvi0y5dSjeCLZQmk1TLfeuLRrw/bsBCIOoUv7G2zSyR6/oPBvfKlo
	BUNg+LF7SkDx8193xlVgXKxeZGLJw1qJLmhzg3ASVLZNyqGixcDrIZBsBeuKst6crG9jwNTaVP8HQ
	FsYp4F0Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBVan-000CeV-J9; Thu, 14 Nov 2024 09:52:45 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBVam-000CcT-2n;
	Thu, 14 Nov 2024 09:52:44 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 14 Nov 2024 09:52:21 +0100
Subject: [PATCH can-next v4 1/2] dt-bindings: can: tcan4x5x: Document the
 ti,nwkrq-voltage-vio option
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-tcan-wkrqv-v4-1-f22589d67fb1@geanix.com>
References: <20241114-tcan-wkrqv-v4-0-f22589d67fb1@geanix.com>
In-Reply-To: <20241114-tcan-wkrqv-v4-0-f22589d67fb1@geanix.com>
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
X-Virus-Scanned: Clear (ClamAV 0.103.10/27457/Wed Nov 13 10:35:46 2024)

The nWKRQ pin supports an output voltage of either the internal reference
voltage (3.6V) or the reference voltage of
the digital interface 0-6V (VIO).
Add the devicetree option ti,nwkrq-voltage-vio to set it to VIO.

If this property is omitted the reset default, the internal reference
voltage, is used.

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


