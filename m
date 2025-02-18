Return-Path: <linux-can+bounces-2827-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60545A399A5
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 11:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A093A9C1C
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830B1238D35;
	Tue, 18 Feb 2025 10:50:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F41713D51E;
	Tue, 18 Feb 2025 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739875826; cv=none; b=UYXRjqIebqEHHakLzt9Z2jomcGwWhqBAb03TqW/Mv1nKHGithE5AJbDnChNM7HcAzCWAv3ln1NvtKBNoZgxYIkC3LMYrVm18S9T4e1uB0RfEf9K/qYQrTjbro6iDgl3+a3PXFivDJ+1mZ9AmNowHD+7jYTwTFqvURhlnRjdaHfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739875826; c=relaxed/simple;
	bh=xLv8w3Fbky0kCCpf57uEKBcLoqffxP3WyxBaT6XoSzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elz/NVVLOrW957cWRAloEqvDHPkg//hKvyCx35yv6qockNkBC9eWniJamY3M2rQqgPDjnWQA6ISboSz2y87htqb4MmiHsXFFoI50xr/hSuceTaE9ZtEpDWY/ABaE7LZy4/AM/g0H4o3ugG0JS7ul6BxMslcYG8HD2VdtT9qDxh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: BNZ3g/LZQB66Pbt8mlf7wQ==
X-CSE-MsgGUID: Ucyzv6IGSBS321Ws76bstw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 18 Feb 2025 19:50:23 +0900
Received: from localhost.localdomain (unknown [10.226.92.208])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 535BC42A47AC;
	Tue, 18 Feb 2025 19:50:18 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Simon Horman <horms@kernel.org>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 02/11] dt-bindings: can: renesas,rcar-canfd: Fix typo in pattern properties for R-Car V4M
Date: Tue, 18 Feb 2025 10:49:52 +0000
Message-ID: <20250218105007.66358-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218105007.66358-1-biju.das.jz@bp.renesas.com>
References: <20250218105007.66358-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas R-Car V4M(R8A779H0) SoC, supports up to four channels.
Fix the typo 5->4 in pattern properties.

Fixes: ced52c6ed257 ("dt-bindings: can: renesas,rcar-canfd: Document R-Car V4M support")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 7c5ac5d2e880..f6884f6e59e7 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -170,7 +170,7 @@ allOf:
             const: renesas,r8a779h0-canfd
     then:
       patternProperties:
-        "^channel[5-7]$": false
+        "^channel[4-7]$": false
     else:
       if:
         not:
-- 
2.43.0


