Return-Path: <linux-can+bounces-3049-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328B4A5E2F1
	for <lists+linux-can@lfdr.de>; Wed, 12 Mar 2025 18:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3A316AE9F
	for <lists+linux-can@lfdr.de>; Wed, 12 Mar 2025 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AE72356D8;
	Wed, 12 Mar 2025 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwozdm6s"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89BA155A4E;
	Wed, 12 Mar 2025 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741801525; cv=none; b=W49c1sKS1G0lJspLfqFQfxn9CihSWCtZU8qcgkddLD4/gRjyHADxVYEn3uAo7oPz7vuJj/GrUypHDpNCLrUPXPv92IQGiKUVdU6uct1MO+db7sHfq7dCthWf74xaL25BtgmKoRJkoI+8+4jxxKJS9SreTM/GonZrJ0rffYyUpKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741801525; c=relaxed/simple;
	bh=lx38Ii4qB/AI3pWRJSXPUS3zXu9HaBtlPizO41uROZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PlGGtoLuCF8YvPd5O2e2b2vGTht19mC4c8LhgwHcBPiX+AV7EtqVUYqco74/ziCdnKRTzSrCaBsNYEKtjW4n3tGnruy87PQi6P2uIm5SPnNNjVC/BBGH0DlBkfgx64Ch3xPc8MwZt1o2AvedSlFTtdNqffjJzLvR8CJDAXHgnQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwozdm6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DCC7C4CEEA;
	Wed, 12 Mar 2025 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741801524;
	bh=lx38Ii4qB/AI3pWRJSXPUS3zXu9HaBtlPizO41uROZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Iwozdm6srOJ2BUI358DChciWMbxghN82umYlbou5N+Xqq85kNwh5DU+3GrSSljTyK
	 8dLP6GZgpIsDuEXXeTfbrFgma6ALzdU0pUwxvvP5PiuzhDXSwrxd6Z+fzKeJUZ4XDX
	 rz0zLzJ/uiDbdxP/gMqaNDr3NYiVevJETcHPCG4tNSt1r01FKkqbHY5Pwp2XlJnOUS
	 JApqjowHu/tF8bsTwrluvU4N1tUBKjJS9L4k4kJ0HVWgaA9fUUkuwV12OC+x409aqL
	 OfSw/9jecYxjwVJAuCDRch+mlZG40vLRKK3/IeVJJq1pS7kzriwhx8NnvGMoP9sPuD
	 u5rKeA31Zl/Og==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A16C2BA1B;
	Wed, 12 Mar 2025 17:45:24 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Wed, 12 Mar 2025 18:45:22 +0100
Subject: [PATCH RESEND v4 1/2] dt-bindings: can: fsl,flexcan: add
 transceiver capabilities
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-flexcan-add-transceiver-caps-v4-1-29e89ae0225a@liebherr.com>
References: <20250312-flexcan-add-transceiver-caps-v4-0-29e89ae0225a@liebherr.com>
In-Reply-To: <20250312-flexcan-add-transceiver-caps-v4-0-29e89ae0225a@liebherr.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741801523; l=1240;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=62w1D1rpX0pQNS5ptfX/YuY6csaGTzAr13ql41pZT30=;
 b=w0StHzeG3yjCTmwia2JcPgwssxDl2A9/pZOd9mcssUGPsQmT71i5++o2li3XNgCsEoMFpbyGl
 QUaOiHGIo0bDx5sb+cmbG7vCQ/KfXCM+iSIQnKJLgFbhodbg6AK9L/9
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



