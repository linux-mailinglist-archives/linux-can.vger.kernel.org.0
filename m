Return-Path: <linux-can+bounces-5908-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6582CD8FBA
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 11:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD20E3012AE8
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 10:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24E832E745;
	Tue, 23 Dec 2025 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="A55H+83v"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAB8313286;
	Tue, 23 Dec 2025 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487394; cv=none; b=MkWNucySrGk/8U7ift0gl77xhx5HQ0ZdGWl7Zn0fIR57WFGQ1xJVJSWLphKQ/CuDS20HsyjdLgoGRyzFi96LIDEckiz9NEYxAxyybnK1CBniWkYrXx94zoCjz/P/t2Px9mxbo3eyjz5N+vCSzo1OwgVf9NFh0Rl4Ecs8P0f1YXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487394; c=relaxed/simple;
	bh=bkHHMY+0wVkh1Qd5ZUy9iTCXPJXHYITWPqR1DMXZlyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvcJpxmJanIYGVQk3JBbAedXlpq7dz0Ls6LCZ/hqSRXEru9LOFi6DkLQ6PC4DlXImUYU6Wp4bocpaqGMkIr3JUP+XnE++iSKJ5eNtcl2RN1r9h8dKIKjxnxZ2lTP5LDHx9dvHbPoGky/Qyw0ana1CqNn5UnDi59W52R7eI5Tu3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=A55H+83v reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dbBlC40x5z1DDTQ;
	Tue, 23 Dec 2025 11:56:23 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dbBlC1nC2z1DDXC;
	Tue, 23 Dec 2025 11:56:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1766487383;
	bh=saRW4wKdGXA5Pks874kXqzjxqCk8iEADz/lMXJaFTuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A55H+83vrT2rEBt+TanHILD5wbbm/Yqlhi7/f+9GWfzk87X5wwiMkU7kiVV88siqD
	 T7PQ2Q8al1ZrBfuac0uTJ1jFIzL2fxeAE1nja3fOLf177xzGp3nSgINRXKZE67pp53
	 n7oR8N7JxMARvZOtoit0nEdevzItOQ3fGpNbC/2LrOM+IGkvetvOxdjaF2htLvc3z1
	 ouiDRjmKzXBg14UTYuElcXTQJ8oEZO/q0is2+WDxYVCdTfQjTYCq9wtrVgysUp+9Er
	 5XcFD/TO5ucnBTTVbFwe5jAJZaOeSGNHTX/og8USThP9zX9WugFtiRoOaA1312x8+r
	 sveAJK0b7Hyag==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Ludwig Rydberg <ludwig.rydberg@gaisler.com>,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v2 01/10] dt-bindings: Add vendor prefix for Frontgrade Gaisler AB
Date: Tue, 23 Dec 2025 11:55:55 +0100
Message-ID: <20251223105604.12675-2-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223105604.12675-1-arun.muthusamy@gaisler.com>
References: <20251223105604.12675-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>

Frontgrade Gaisler AB provides IP cores and supporting development tools
for embedded processors based on the SPARC and RISC-V architectures.
Some essential products are the LEON and NOEL synthesizable processor
models together with a complete development environment and a library of
IP cores (GRLIB).

The company specializes in digital hardware design (ASIC/FPGA) for both
commercial and aerospace applications.

Web site: https://www.gaisler.com/

Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 424aa7b911a7..4e1b4eeff9ff 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -594,6 +594,8 @@ patternProperties:
     description: Fujitsu Ltd.
   "^fxtec,.*":
     description: FX Technology Ltd.
+  "^gaisler,.*":
+    description: Frontgrade Gaisler AB
   "^galaxycore,.*":
     description: GalaxyCore Inc.
   "^gameforce,.*":
-- 
2.51.0


