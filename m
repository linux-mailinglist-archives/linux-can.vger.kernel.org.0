Return-Path: <linux-can+bounces-2893-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F453A3D558
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 10:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5073B26F6
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 09:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E2E1F30A4;
	Thu, 20 Feb 2025 09:45:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4372F1F1927;
	Thu, 20 Feb 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044738; cv=none; b=kedXUgnJ8giTdDMnUCJYJluR/g4Sjz/l6QpUVK4drOaFDho6web+ADJzgXCrj3v4Lm3aPMrlVM5HboLJ+gNylK8KFVVZ4mjlfM70cWt9dTWiEBChIiBvd9Yo2mzmG3eiVwbjouXpDbxo0TT+HPHNInL5osFQWuh7UNqvi91X910=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044738; c=relaxed/simple;
	bh=nmoslHvD67N2BtaJSu3v4ZCe+zmcvgU0hREdnxqkabI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWkpzp0zRuvoYm78T4QJLf8vB+619DLNyughTgBah9NwX++PllUIAIo2zXZFC/fzo7FA1IlZved+Y4fkxESTt1khzYv+EBHTYcT/cqJvsROliDSBDcHn7Y8C/BiFiotgIpjsBSzKLQ98cgMyy7Jjj1Uk37RLvcxvocHhZzdwo88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: r5gLnlU5T6yRVFrhyaWXtQ==
X-CSE-MsgGUID: fKPlCf7US1qzj4efxaljmQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Feb 2025 18:45:29 +0900
Received: from localhost.localdomain (unknown [10.226.92.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A5C7742175B9;
	Thu, 20 Feb 2025 18:45:24 +0900 (JST)
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
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: can: renesas,rcar-canfd: Fix typo in pattern properties for R-Car V4M
Date: Thu, 20 Feb 2025 09:45:11 +0000
Message-ID: <20250220094516.126598-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220094516.126598-1-biju.das.jz@bp.renesas.com>
References: <20250220094516.126598-1-biju.das.jz@bp.renesas.com>
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
Cc: stable@vger.kernel.org
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Added Rb tag from Geert
 *  *  Added the tag Cc:stable@vger.kernel.org
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


