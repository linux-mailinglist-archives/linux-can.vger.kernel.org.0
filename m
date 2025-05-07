Return-Path: <linux-can+bounces-3558-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797B2AAE523
	for <lists+linux-can@lfdr.de>; Wed,  7 May 2025 17:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524424A8749
	for <lists+linux-can@lfdr.de>; Wed,  7 May 2025 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707028B4F7;
	Wed,  7 May 2025 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noyMKEK1"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01EA28BA91;
	Wed,  7 May 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632548; cv=none; b=SEeLe7HKa48Ua6oOpI3gpG8/RePwJh8e/sgHmbttgWS7dFM4lPjBAUdQm5Dyabi2YYIVqh5xQRa/ugFF6ZufwwFtKQj/FAY8pmjzBjurRv9FYfwiplBDAiM6cXhcgSpLnOi5CG8Ulh0G+fBMOarjP0rILW9eWDn37QLH+NYbCdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632548; c=relaxed/simple;
	bh=UCG9uUCi1T07aauhMZzXc1mEyWGFALTK5OrhIqBgmqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rL6cMf783/Txpzh/v5NDzOhtjrvR/5CQrA/SmqEQuyXW29EnTSQYs4l02UazMyu29u30N+XDGNDUy6I1inrWIAln0OyF90SZ5qWUyn833GX1YETw3f5wEoLzZXWDF8y4Kv7EE/ZU5x4FJ3I5Ru4V6eKyFLAXbiB3y9quBxjPfww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noyMKEK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1EFC4CEEB;
	Wed,  7 May 2025 15:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746632547;
	bh=UCG9uUCi1T07aauhMZzXc1mEyWGFALTK5OrhIqBgmqY=;
	h=From:To:Cc:Subject:Date:From;
	b=noyMKEK1FiH0vcsaVV6EVq7wZP01ngc3mnlvfZeKNNJzRYQiPexxYyQq7bv73W5q8
	 rxYjuR0+FozHa/P/g+Nwwep4Xa1MYYsTmJwdLeJThbtG7KJX1NEqXPARJIHm1OIOBn
	 jeac1QTqKgXeDfic/FPm8DBQOJZUIZKhTBCg5jzYldS+Rnqpp9fNhFbH3Lh8N+de2m
	 0jEmeaqYPbw7vR43LycegMaYj61OykRzMxlJFYtp/omKnTpZ1ZbksbNnpa70L7yaFt
	 6TaSghb7AGLrawMqosvsAbeaDEdycCfa1BFp3y737AcpWKsAepPIB/2xT3TjO+2FFO
	 2Cu1bad8uJlFw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: can: microchip,mcp2510: Fix $id path
Date: Wed,  7 May 2025 10:42:00 -0500
Message-ID: <20250507154201.1589542-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "$id" value must match the relative path under bindings/ and is
missing the "net" sub-directory.

Fixes: 09328600c2f9 ("dt-bindings: can: convert microchip,mcp251x.txt to yaml")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/net/can/microchip,mcp2510.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
index e0ec53bc10c6..1525a50ded47 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/can/microchip,mcp2510.yaml#
+$id: http://devicetree.org/schemas/net/can/microchip,mcp2510.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Microchip MCP251X stand-alone CAN controller
-- 
2.47.2


