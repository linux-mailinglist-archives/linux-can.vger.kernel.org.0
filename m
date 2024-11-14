Return-Path: <linux-can+bounces-2038-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C379C85CD
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BCA1F22AE1
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005771D1724;
	Thu, 14 Nov 2024 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="DrRZ6cG/"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4244E1E04BE;
	Thu, 14 Nov 2024 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575704; cv=none; b=b5dbCXZWHlvpdyJ+GgG1gvD43C+2CMAHEO7B8/Wk+rUC2RMedCNucaXkve9nPa5CKj8KemzD9UplLC0/LGGczOOrL7Sb2YXKGW+Vk1H/6TNLu3eJVAH5CTZmkUQQ2Ydjc/eLb11H0pV7do1IHgsUReWtunS3terflhLdDV3Rh7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575704; c=relaxed/simple;
	bh=JTHP1E6txsT5jDiSekLwyUCkPVTFlgYbGEwq5UX1hGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZOg+DuI8GO9BONfk1qLRTj7kDIAW/tn3/CZOcLqabV/pQhEuMtglv9p1M+qXi36VQpKYZUasWLCrSuP3YDu/R9jjL+uV93VqWqsG+Z3iFCiowX5PSlnNFr05DoZ71+9PWJEUMS4bi9schdKhb6HGgu3FxdUAiKyB8JtrHW4Dazg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=DrRZ6cG/; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YtbN+aZcwI37v2vnWXUL5gpC9O6aop7q/s7EDhL0JsM=; b=DrRZ6cG/mMMiqSOWBhlqn+PrRa
	VzDF/scVu5Gq52evGrSQkTWJwQreSz1tQlgij7XEpIsHv8pM8km9IfVOV258MVOAOJIxKTZzxpwyq
	FL0csWTIdyqPbri/jbZY8KL+WR7XEMyofqHymqAKv/nOvNBnEeK2WaFUPLDKhw0O2AB8OaeoANouG
	xck3ksIN9esC7myGEJ0Ls1w2+3M0l87pr4xDerfSB7IxOO1ms/iWOh0iN/iO1cHuFeZBRvUKanUtI
	damrhvUyrZ+Tl44j4AMb49OUF/ZL4LdudWXOnHXhnq0uI1qMFwsIaagm+5MAO9PDTH5lpwDe4UFbb
	hNyNT3Kg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBVwL-000HFp-AK; Thu, 14 Nov 2024 10:15:01 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBVwK-000EOg-1g;
	Thu, 14 Nov 2024 10:15:00 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 14 Nov 2024 10:14:49 +0100
Subject: [PATCH can-next v5 1/2] dt-bindings: can: tcan4x5x: Document the
 ti,nwkrq-voltage-vio option
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-tcan-wkrqv-v5-1-a2d50833ed71@geanix.com>
References: <20241114-tcan-wkrqv-v5-0-a2d50833ed71@geanix.com>
In-Reply-To: <20241114-tcan-wkrqv-v5-0-a2d50833ed71@geanix.com>
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


