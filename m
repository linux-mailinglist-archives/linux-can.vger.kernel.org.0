Return-Path: <linux-can+bounces-5468-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 80717C65399
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 17:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74C943666F9
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 16:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129732D5924;
	Mon, 17 Nov 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shfyhP/n"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D681729B200;
	Mon, 17 Nov 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763397520; cv=none; b=ZJq07zaHsr93feppamjcPcBfu1r2TCj7OlPNdwdlRQH/yeBWt+o1ubyN6njec5gZJ85RHHlWc6cPb8JEhgDczpPA+vH6c0nYXu7JFp8lKQBS/eXHnOodKq+5GaBA737bXk+wo2NTT2x6QEOGA1GdQzmka/4liTVsz8Pzc8ZD3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763397520; c=relaxed/simple;
	bh=ggY0CM1uMMAhQmcHdo4hDKorWC1gmId184WwoW3Rkko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QsZOyyjsXvRzlXLUjQr+hKHa0+KymLf3XX+V0vHb3eoTDOTvtvtILPB/oatBsc7OZbXF0aEFi5pL/HrV6LOL3QJc3jnYiMY/L6OEsa08k7A62VZ1rdOuHJj4qSk4tndeG/S0I+TI8mbC8HrhY2bC2a2ENb175jKKN+u2RGc+mOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shfyhP/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D64C116B1;
	Mon, 17 Nov 2025 16:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763397519;
	bh=ggY0CM1uMMAhQmcHdo4hDKorWC1gmId184WwoW3Rkko=;
	h=From:To:Cc:Subject:Date:From;
	b=shfyhP/n9j/AUTeyS3ba/BIKKGqjwXhLWBuJTvepk2GnW821mRWcUIUy1rE7gAiJJ
	 fqa0fqLM5v94yI49iNnRKYn3Lf6BEF7dqiKZ0zQAaAOOEr3Fp1KSJyQ9M/hOpIe3KR
	 Xwig9B1W79hAzqT/Q6My9c2ap9GWDqjOcNZA1ASx7+kgQpaBEnX1ESxF9wVZTPVnEV
	 StHpPIIYgF5kLKrHUawOmZULcbcFg1ue2tAZv+o+CUXaz56rpufj0Al+x780cZcEVd
	 TxYZNKNFUSYo3WC2oBisT9sbCR5U2LMh4ftJn0VHfGUzRguF+TlfLzTLX8vuyF+qhr
	 12/zC4gQvt41Q==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [net-next v1] dt-bindings: can: mpfs: document resets
Date: Mon, 17 Nov 2025 16:38:18 +0000
Message-ID: <20251117-twitter-sternness-f2b3a1506a6f@spud>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1974; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=o0IWfGy7dLFMHxxCcDJkwRXrJajdOduLEpHVlJIjoLc=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJnS/hU3S0LTBUTVNjAcP3/uq9YBrjRusf8SQsHL7F6U+ ZjHV7zvKGVhEONikBVTZEm83dcitf6Pyw7nnrcwc1iZQIYwcHEKwETu8DD84Xm+6NAC3pP7TSX0 9jQF1Z197jrV+1yc7/uqv8p7865sEmVkuL/NY8vNvlkJIcd+mfwvm/Spn7WWJXW3zt8uY5ZFjtY LmQE=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The CAN cores on Polarfire SoC both have a reset. The platform firmware
brings both cores out of reset, but the linux driver must use them
during normal operation. The resets should have been made required, but
this is one of the things that can happen when the binding is written
without driver support.

Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN controller")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
This is the second mistake in this binding, both spotted because of the
driver being written (although this one sat downstream for a while for
w/e reason). I wish I could say that I'd send the driver soon, but I am
busy upstreaming things I wrote and therefore understand at the moment,
so a driver that I'd have to go understand and review before sending is
low priority, sorry!

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Vincent Mailhol <mailhol@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: linux-riscv@lists.infradead.org
CC: linux-can@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 .../devicetree/bindings/net/can/microchip,mpfs-can.yaml       | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
index 1219c5cb601f..d2a378064c50 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
@@ -32,11 +32,15 @@ properties:
       - description: AHB peripheral clock
       - description: CAN bus clock
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
   - interrupts
   - clocks
+  - resets
 
 additionalProperties: false
 
-- 
2.51.0


