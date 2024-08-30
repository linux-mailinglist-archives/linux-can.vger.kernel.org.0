Return-Path: <linux-can+bounces-1273-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C869F966B67
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 23:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0588E1C22559
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 21:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A041C174C;
	Fri, 30 Aug 2024 21:44:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B91BBBEB
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725054259; cv=none; b=hbUpfe04IM8V4PyhASSt6xI5G35f/tNsYPNq62UAO8odVV4C7BXlrLmR6gN2k9gQKvCJLCs7EOq3Iaoo2enE+SeIGfrHg3/RMaX0zdH+hxXJqvxTvV8oPTmAPezbfDM2O/MQ7wPnzGEnsq5Zp2h2Ot5wu4AsmRM18CD0Z+GFnnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725054259; c=relaxed/simple;
	bh=orAAXJWUtD5reYPwOwvRpeWjLxOMXkkLGzPfR93Eh4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dT7FAlqgy3L0ZFvk/FxZQrcKJ4ho1GtGSzBN4HVcr2pdCoLD38PzUWG5we6R9PtyodKMMnJp6w8s/+lfsyu46WT3mbDPIIeMxCYdGmw9FjNlHqjis4Lmwypy8LeFyl6Q/8rdpRqIVbyCKZySi+lPoxo4rUmQFBE0NtZ2rBoUqDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9Pj-0002hl-Nu
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:44:15 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9Pi-004FNr-Df
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:44:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1E9E132E481
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:44:14 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id CD81132E44F;
	Fri, 30 Aug 2024 21:44:11 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 973c4f51;
	Fri, 30 Aug 2024 21:44:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 1/6] dt-bindings: can: renesas,rcar-canfd: Document R-Car V4M support
Date: Fri, 30 Aug 2024 23:34:34 +0200
Message-ID: <20240830214406.1605786-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830214406.1605786-1-mkl@pengutronix.de>
References: <20240830214406.1605786-1-mkl@pengutronix.de>
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

From: Duy Nguyen <duy.nguyen.rh@renesas.com>

Document support for the CAN-FD Interface on the Renesas R-Car V4M
(R8A779H0) SoC, which supports up to four channels.

The CAN-FD module on R-Car V4M is very similar to the one on R-Car V4H,
but differs in some hardware parameters, as reflected by the Parameter
Status Information part of the Global IP Version Register.  However,
none of this parameterization should have any impact on the driver, as
the driver does not access any register that is impacted by the
parameterization (except for the number of channels).

Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
[geert: Clarify R-Car V4M differences]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/68b5f910bef89508e3455c768844ebe859d6ff1d.1722520779.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index d3f45d29fa0a..7c5ac5d2e880 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -32,6 +32,7 @@ properties:
           - enum:
               - renesas,r8a779a0-canfd     # R-Car V3U
               - renesas,r8a779g0-canfd     # R-Car V4H
+              - renesas,r8a779h0-canfd     # R-Car V4M
           - const: renesas,rcar-gen4-canfd # R-Car Gen4
 
       - items:
@@ -163,14 +164,23 @@ allOf:
           maxItems: 1
 
   - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              const: renesas,rcar-gen4-canfd
+      properties:
+        compatible:
+          contains:
+            const: renesas,r8a779h0-canfd
     then:
       patternProperties:
-        "^channel[2-7]$": false
+        "^channel[5-7]$": false
+    else:
+      if:
+        not:
+          properties:
+            compatible:
+              contains:
+                const: renesas,rcar-gen4-canfd
+      then:
+        patternProperties:
+          "^channel[2-7]$": false
 
 unevaluatedProperties: false
 

base-commit: cff69f72d33318f4ccfe7d5ff6c5616d00dd45a7
-- 
2.45.2



