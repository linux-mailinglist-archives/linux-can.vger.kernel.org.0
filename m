Return-Path: <linux-can+bounces-2936-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4ECA40624
	for <lists+linux-can@lfdr.de>; Sat, 22 Feb 2025 08:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D8B3B8382
	for <lists+linux-can@lfdr.de>; Sat, 22 Feb 2025 07:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3DC205E31;
	Sat, 22 Feb 2025 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0qlhudm"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F1B201270;
	Sat, 22 Feb 2025 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740210202; cv=none; b=VYOIYlv4xfuKpbl9c2pWgajfLXTL5elBWa3stxwxnB8dUI8sRpKpcc2uZ3Ev4suBB7f6HF/MpYF7ijc3Q9NMhsPn4rSbkI9ZfPaqXlCeSEtUyef4atdtz/1hUMnkVYQBs9V1Ac8dWvNYCrfq3xrlXT7tR8aF00aesf7ivJSKdhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740210202; c=relaxed/simple;
	bh=lx38Ii4qB/AI3pWRJSXPUS3zXu9HaBtlPizO41uROZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p74Z5oDxgs/zomrCjnA9X6cOLVmwfI85aUO/D2IcaCK/GspAXflCTEWLTI5bh8C/VgxoBPuDSf3dFwUJffcp/dNlpsGGDy48F4LX0I+YTkn/5Dsu7xB/XVjlPIDtdYqvkdCfJAOA2OK+QW3fxihcpcfHNpDKNIWNiWskcqLz6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0qlhudm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B175FC4CEE6;
	Sat, 22 Feb 2025 07:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740210201;
	bh=lx38Ii4qB/AI3pWRJSXPUS3zXu9HaBtlPizO41uROZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I0qlhudmD2QDht3ZDp3hHAAjIs6pXmiwLET/vwloNQ1aIBReLXqhwEchH4/KYF527
	 5JOftlPQM4y7O1pYJBP4zKSW+EagZcXkFx4EchbckMVn27dlhQv8KX3cnESbZm/fhj
	 HRoH3vOBXBCDmDyTNvYPYHv8XJ6EJ26OEDX62xfl5Zeq7xwgyws7+UQKq/mZYJx+qa
	 bUh4LUgmyAwMBkS9m/2ehMPSTZn+h0iBz05a86FeiTTeINTnv+ARQ3B9rExO23N9+5
	 vb7V1EfGs+99udRmcXBIqapFoO5tbtjxpd8tV3foCwfLWgoVMSgLxEKWZe67tfTysM
	 zsRsX9fJz379w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3F3C021B6;
	Sat, 22 Feb 2025 07:43:21 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Sat, 22 Feb 2025 08:43:13 +0100
Subject: [PATCH v4 1/2] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-flexcan-add-transceiver-caps-v4-1-a38dfadab763@liebherr.com>
References: <20250222-flexcan-add-transceiver-caps-v4-0-a38dfadab763@liebherr.com>
In-Reply-To: <20250222-flexcan-add-transceiver-caps-v4-0-a38dfadab763@liebherr.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740210200; l=1240;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=62w1D1rpX0pQNS5ptfX/YuY6csaGTzAr13ql41pZT30=;
 b=3WQsjjRLq1qmsSqQn1ymItbHsijT3UMwRseDCr6TGzSEUFdPeWyKO6S12bXBstobD6S13ZK0m
 0NG98sr2XVkDVPC4Ym6Ee5RbUjNyKAGJ+7TjsC4lmMLlwBo/35FX0LF
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Currently the flexcan driver does only support adding PHYs by using the
"old" regulator bindings. Add support for CAN transceivers as a PHY.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 73252fe56fe6c8e9fd19142208bb655dc86d47cd..37e3e4f487629f4df427dd8f711dc632f8dc5a2a 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -77,6 +77,9 @@ properties:
   xceiver-supply:
     description: Regulator that powers the CAN transceiver.
 
+  phys:
+    maxItems: 1
+
   big-endian:
     $ref: /schemas/types.yaml#/definitions/flag
     description: |
@@ -171,6 +174,12 @@ allOf:
         interrupts:
           maxItems: 1
         interrupt-names: false
+  - if:
+      required:
+        - xceiver-supply
+    then:
+      properties:
+        phys: false
 
 additionalProperties: false
 

-- 
2.39.5



