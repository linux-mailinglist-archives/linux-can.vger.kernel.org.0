Return-Path: <linux-can+bounces-2239-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2829DA8CD
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2024 14:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EDB1B23F99
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2024 13:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5791FE454;
	Wed, 27 Nov 2024 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="jxHZVLsS"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72251FCF73;
	Wed, 27 Nov 2024 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714872; cv=none; b=lXiMvMJ1PqO4ysGGZCgbR2jfhRVWOS570BCpo77OjmdLBWSh6sOvUO59TU18AH3FCPWcn8kyiUXovMK8pVtdPwuVz8sGwp/GoPEMo+aDZtcBEBfDyTnGaVuPHro+k1XN9E5d0FMIIMG44+W+iDvfzCKRuRRWsttBdZEYjheTdwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714872; c=relaxed/simple;
	bh=QQuctVgVhgz9hFgdqE9wQRd9rI6sn4l6Z0AQ7l65FHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q7TQhfF9mDqp6EK0RLeSdsLl2qXFT6qRdk2P4HimDuJU5Hp7TSMADCV5ameHM0OebVBZSkZOmfrh/MpudjCGZv71zNjpRuLgzbX75P27TNv+50aN3lwphyNnsgsk46i8iBcsFAm65TogApHkwhvqi6XHiLD1oUFFZ1Wo/X5pYCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=jxHZVLsS; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=nzjt9R1rj2NgW88oWujFd2rga39hRVGQyf9XMSDHskU=; b=jx
	HZVLsSJnkEUiwtMeGnnBucIwGNyl2CUx7msRo8F191hEpBHTH84zl239G4god54LETT0hXwF17giG
	+GA68B1U4F0oufjHkTXyHV6Ugc+bMK71CoTkFRKfFVazR4WX5rsJrtLrvuhv2MYHD0PPbpmwo8q/9
	wK1gLRSHQGREDBXCb6UCzwqlutjAghETH4WhHp/C/f0dIPNpQXsf8rCXOuXAkf7t8ferAw6kRv578
	V8DGUQuIBmQ255XlTI0HELKBruony980xWppV6fQO9StXaxEzOev3JQze9FgiUrFaelMO9bm1wFXl
	NXeYpMVTMbMZw/+PxReZ2EUsniHOxPlg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tGIHn-000KXq-3W; Wed, 27 Nov 2024 14:40:55 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tGIHm-000HQN-19;
	Wed, 27 Nov 2024 14:40:54 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Wed, 27 Nov 2024 14:40:47 +0100
Subject: [PATCH can-next] dt-bindings: can: tcan4x5x: add missing required
 clock-names
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-tcancclk-v1-1-5493d3f03db1@geanix.com>
X-B4-Tracking: v=1; b=H4sIAF4hR2cC/x3MQQqAIBBA0avErBtQK6KuEi10mmooLFQiiO6et
 Pzw+A9EDsIR+uKBwJdEOXwOXRZAq/ULo0y5wShTa21aTGQ90b4h6boj5SqnGgWZn4Fnuf/VABm
 h5zvB+L4f9nFXUWQAAAA=
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
 Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
index ff18cf7393550d1b7107b1233d8302203026579d..f3f3cbc03aec13e517552d2e29ecea1585de8e36 100644
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
@@ -154,6 +158,7 @@ examples:
         can@0 {
             compatible = "ti,tcan4x5x";
             reg = <0>;
+            clock-names = "cclk";
             clocks = <&can0_osc>;
             pinctrl-names = "default";
             pinctrl-0 = <&can0_pins>;
@@ -179,6 +184,7 @@ examples:
         can@0 {
             compatible = "ti,tcan4552", "ti,tcan4x5x";
             reg = <0>;
+            clock-names = "cclk";
             clocks = <&can0_osc>;
             pinctrl-names = "default";
             pinctrl-0 = <&can0_pins>;

---
base-commit: e0b741bc53c94f9ae25d4140202557a0aa51b5a0
change-id: 20241127-tcancclk-c149c0b3b050

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


