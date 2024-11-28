Return-Path: <linux-can+bounces-2247-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362169DB300
	for <lists+linux-can@lfdr.de>; Thu, 28 Nov 2024 08:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E062811E6
	for <lists+linux-can@lfdr.de>; Thu, 28 Nov 2024 07:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4B51465A1;
	Thu, 28 Nov 2024 07:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="pJgv80B1"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B517C7C;
	Thu, 28 Nov 2024 07:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732777815; cv=none; b=Plw4dE+AYqw/SViybRr1mtRLKX3nm2p7SVDe1rqfpJf6ZioXFOlSnGE9MpODwWxR10v+7uVn/qGY/arWzg86bU7PpPO6wTyHL+NN6KJCH4UGq68iGQnWOfejSHVytljKp7hrEKss1E2DNgl5tohsAzCCECNDPdpWu3uGUzfD/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732777815; c=relaxed/simple;
	bh=+vMSvgAlPz0Dt7EVrCTMdPwKWsGGb+DMacYVkh5D+Ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RrB1ZYk6HbSkr7j92ACKW75j6UM/R9FogXe5YKnxDYlvUbW7dr+j2adbS2FleDcTp9jTDbEWGTR8yQRL3gJ5epUJ0TLjtwJnuhryhjuU21YxZBuZ1/KAxRTJvkngrKcHGhDbtFLBOZGeBj4HzksyPVdI//mkVQuZL/oOu6yqG7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=pJgv80B1; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=KBenspJmXk1F7wu0PYrbmb2kmjahWDoMgvVyEsfUguw=; b=pJ
	gv80B1oRzqHQ0MwY8bUu1CVxYBbFd+CUoBqOF+eryvcyPVCklAVpedHvixSPzyfvEWhc3owbamrVr
	9mE+dnOm7XCcdJ9gUk04NjUVLlcDZGc4kS+rylcqZjOBDTebA9xrXfylnMcsGWMoOEfI+uS/iOYQG
	hw0zlOe/7qjMRsBlxHnwCH9Cbeysnk1dxYQzjZXz1mZ+vpmHwAq+HKKnx3a5xu8Ik0wx6kiL9daZX
	0MI8G6/48zf7ZXiT3mOtgZPxFT7+oi71cRmPpt1EK1Bdxty1Za3DhpYA8vX6hlemvYWU6MVPyWDws
	jWmPz2Bg1+vbHiA7IWPFUott5j9eg8xg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tGYf8-0001EG-Sc; Thu, 28 Nov 2024 08:10:06 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tGYf8-000CjF-0Q;
	Thu, 28 Nov 2024 08:10:06 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Thu, 28 Nov 2024 08:09:36 +0100
Subject: [PATCH can-next v2] dt-bindings: can: tcan4x5x: add missing
 required clock-names
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-tcancclk-v2-1-fbf07f1f1626@geanix.com>
X-B4-Tracking: v=1; b=H4sIAC8XSGcC/2WNQQqDMBBFryKzbkomiRS76j2KCzOOOrSNkohYJ
 HdvcNvl4z/ePyBxFE5wrw6IvEmSORQwlwpo6sLISvrCYLRxiOamVuoC0fulCF1D2luvaw1FXyI
 Psp+pJxRJBd5XaMsySVrn+D0/Njz3/9yGClXtGtvbQdve42PkLsh+pfkDbc75BwUd2EerAAAA
X-Change-ID: 20241127-tcancclk-c149c0b3b050
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27470/Wed Nov 27 10:59:44 2024)

tcan4x5x requires an external clock called cclk, add it here.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v2:
- added clock-names as a required property
- Link to v1: https://lore.kernel.org/r/20241127-tcancclk-v1-1-5493d3f03db1@geanix.com
---
 Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
index ff18cf7393550d1b7107b1233d8302203026579d..384e15da27136c0bad39c4d9f6cc0456fb0d5b19 100644
--- a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
+++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
@@ -29,6 +29,10 @@ properties:
   clocks:
     maxItems: 1
 
+  clock-names:
+    items:
+      - const: cclk
+
   reset-gpios:
     description: Hardwired output GPIO. If not defined then software reset.
     maxItems: 1
@@ -138,6 +142,7 @@ required:
   - reg
   - interrupts
   - clocks
+  - clock-names
   - bosch,mram-cfg
 
 unevaluatedProperties: false
@@ -155,6 +160,7 @@ examples:
             compatible = "ti,tcan4x5x";
             reg = <0>;
             clocks = <&can0_osc>;
+            clock-names = "cclk";
             pinctrl-names = "default";
             pinctrl-0 = <&can0_pins>;
             spi-max-frequency = <10000000>;
@@ -180,6 +186,7 @@ examples:
             compatible = "ti,tcan4552", "ti,tcan4x5x";
             reg = <0>;
             clocks = <&can0_osc>;
+            clock-names = "cclk";
             pinctrl-names = "default";
             pinctrl-0 = <&can0_pins>;
             spi-max-frequency = <10000000>;

---
base-commit: e0b741bc53c94f9ae25d4140202557a0aa51b5a0
change-id: 20241127-tcancclk-c149c0b3b050

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


