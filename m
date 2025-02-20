Return-Path: <linux-can+bounces-2884-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854C0A3D304
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 09:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55FD189C09D
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 08:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D971EB181;
	Thu, 20 Feb 2025 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpYXMCjw"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13B1B87D1;
	Thu, 20 Feb 2025 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039738; cv=none; b=CotDG6EJBwq8z2TSO/w/Bx+MkRNPRWLPCxd6DlZA2phuDC7gyxeOOjsnsShGp5U0OSV1TMZ2fltUYydvWNH0tKSNJdr2D0ulqf8cP8rS2iTT57sak/CYSmd+HsrsECEDIf/iCAV3Iu6d3suqFYepZejq667EsOa8krHina16lMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039738; c=relaxed/simple;
	bh=yjWF3QHEZzfOEG6vK4+7X0S8TNQLDNe4aasRWsFl73A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sulfy+lCl8d2UU14VPy3HeBF6J/jLsEPjg1rLP7LEr8UtDYL6XGFGRv9ll0Q0h+n0E6iIjP3MtbshWD/OisVOHh5g9ey177qAHiBXRLewUIoZR9An0oStoQ4IVyr0z9+ZnK6kMiueEjPNPhqVd4YfKtJmRsA7DXtSaoklnSbnq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpYXMCjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0B92C4CEDD;
	Thu, 20 Feb 2025 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740039737;
	bh=yjWF3QHEZzfOEG6vK4+7X0S8TNQLDNe4aasRWsFl73A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XpYXMCjw11WlOxsTi4YTFYpx7hc7wdwAj1nbSySg0AHDnEl8WYJH8a65TOIrhRFls
	 2oY2gaOfDR0hJAipLNaTQdloqFBfnHG7dcL68gj/dh/y9t7sLsTakMO6d2uHmr6hnU
	 Wq/emNsPTgFOyL38NQM1T6G7SFnbt+kr/rJpaFR9kStcmCEIFaBkCiYCeSUQEHm1AE
	 2IRtajjf8k+tqjNapWF4cjasqCpOYjJEc4E4fkqal4Qr4rzXHbvGyc0rLo2JJWgvZZ
	 ksBQ86xsByY0M87yK+SyG8po6S7HlHW/l5NZ49+j2gd1faKeL7wM/Gd6y1tmkPTlIF
	 DqQ/HfVUu/s3g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1D6C021B2;
	Thu, 20 Feb 2025 08:22:17 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Thu, 20 Feb 2025 09:22:10 +0100
Subject: [PATCH v2 1/2] dt-bindings: can: fsl,flexcan: add transceiver
 capabilities
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-flexcan-add-transceiver-caps-v2-1-a81970f11846@liebherr.com>
References: <20250220-flexcan-add-transceiver-caps-v2-0-a81970f11846@liebherr.com>
In-Reply-To: <20250220-flexcan-add-transceiver-caps-v2-0-a81970f11846@liebherr.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740039736; l=981;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=rYXmxFzExtgpILQ/SNCUYYIlRALmdQAqdKj3Yq2bYU8=;
 b=bMg+Z7zb4hahUp3welT22AvMxrxFl9jVH0LXHi4p6pT5A4Nwi1nCQfrGenyaQQclBomRQPeAS
 rh6On+1+bGfB8QErThTvlrNALaIY0NnwRN1TtmU+YmqBUlQjyZlsRKI
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
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 73252fe56fe6c8e9fd19142208bb655dc86d47cd..a7b9ae2b2546b801623117179e16c4ffc11a234e 100644
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

-- 
2.39.5



