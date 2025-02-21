Return-Path: <linux-can+bounces-2918-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F90A3ED78
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 08:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 030747ABB08
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D24C1FFC44;
	Fri, 21 Feb 2025 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YK1KafAJ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4231FF7AE;
	Fri, 21 Feb 2025 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740123680; cv=none; b=MJBRAVUeB3X99MUUDMbD+EbdXkOuKSHTLu0YF3lNgj4QWoOfTmMtX16QdY99a0Sij4hHe8qPYr2922AGtgiA2prAJoXp+o5NjvtEhU5HCdfMXBPJDw1jvNNTUcEKSa3EmLIndcXz+lqrNBeK5Ba08PkfnLEGVfNO5V9xTSlpG/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740123680; c=relaxed/simple;
	bh=GxjnPRKP6VluCAQngEp1L3VY4UceDn4OUYybTJ33/xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBOwqSkMymScRPaDNyfvfgV3NWooArwQj0qLk5ANN7J/c/d5GnznfI7uuzku+9eNKLB/ddmMmp2mpSoe6fPgPFx0Na3sqnxUDpruJ9fo/BJOb5di2GHdXIIGXeoNQTqZgx4GZ6FkjGCOb0fdtvB3/4qSCEDNZbfG+/H474gjo/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YK1KafAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73404C4CEF1;
	Fri, 21 Feb 2025 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740123679;
	bh=GxjnPRKP6VluCAQngEp1L3VY4UceDn4OUYybTJ33/xg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YK1KafAJYzbMT54CNLa2IFMJlL7YgspnpOjl0A4XPlxx5Ck/sk00YfQhngPn94W9M
	 0nDLqwPK15J1qhb7FnHwsrihVfWHC/a54+gkRWG46kANQwd3AjOSLSYe/wSZpZQqOv
	 IHAAdVemnFDz293svhtpJbFBknc++SIWrhvlGg0y9gwDfP+rPveQ+aEtTs0gD54/a5
	 YiScANmjQnGxltuprP5nr3HAmEqTdnRkvI3DXERJxcngvNUHlo0oqWJlAJlievT98K
	 4hDyx1aGe9RXReey5jhor/Hj1IQtXHSr61I6ZP4J0q+VJdJMBtLFw0uSziL7qMZ9IN
	 +yTecnYVUbDiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62667C021B3;
	Fri, 21 Feb 2025 07:41:19 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Fri, 21 Feb 2025 08:40:04 +0100
Subject: [PATCH v3 1/2] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-flexcan-add-transceiver-caps-v3-1-a947bde55a62@liebherr.com>
References: <20250221-flexcan-add-transceiver-caps-v3-0-a947bde55a62@liebherr.com>
In-Reply-To: <20250221-flexcan-add-transceiver-caps-v3-0-a947bde55a62@liebherr.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740123678; l=1303;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=qGldsWkHXoJq4VyhjFnQi+9QTMHx9E7aGj44ABCTLso=;
 b=Q9ocQ9FALv0H15DumWrZlCQSijdSVHcPsar8wMgAG99pzRT7T/ftg1/Mp2gujHUQeRqO7pMOk
 G9jC257IXOHBesNTgFDzJRpg1lfdv51eFoI6KRfs/FEIkqVUwDNsin2
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Currently the flexcan driver does only support adding PHYs by using the
"old" regulator bindings. Add support for CAN transceivers as a PHY.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 .../devicetree/bindings/net/can/fsl,flexcan.yaml          | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 73252fe56fe6c8e9fd19142208bb655dc86d47cd..81125883cf86b9d19616bde378f74bdb6a32f1b2 100644
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
@@ -171,6 +174,18 @@ allOf:
         interrupts:
           maxItems: 1
         interrupt-names: false
+  - if:
+      required:
+        - xceiver-supply
+    then:
+      properties:
+        phys: false
+  - if:
+      required:
+        - phys
+    then:
+      properties:
+        xceiver-supply: false
 
 additionalProperties: false
 

-- 
2.39.5



