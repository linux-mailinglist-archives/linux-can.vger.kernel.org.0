Return-Path: <linux-can+bounces-5487-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BCFC6888D
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 10:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA7774F1312
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 09:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D790031577B;
	Tue, 18 Nov 2025 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="i5sOfcwd"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7E310652;
	Tue, 18 Nov 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458004; cv=none; b=YFGeBptBpzw+YMc2jTuFxbiTpS25wBafQvB0l1tN8J9xP95pMHN5LYtsVnO80wcgvr6Pe1m7LGyw+yBS2sMOrljvhsBn8QrUBHIcuvaP5iD/M3T+r18TsBHOe9yr7YwTWY76hh1iuwVD4sRZ9GFt5IdTbCbTgVmiR4unCgp0FNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458004; c=relaxed/simple;
	bh=o/ioPXXZYh/dgl1Zd0IL9GbLfli276QgGGru0OCthHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YyxCYxNBylMOZ+tHj7ks+AdNWzJ5oJyQyYliUoA8XsUI2VQydxuy9vt/aSCfnpeweiUog7y313ZxZERBVGTCe7m2mmTgDujtB/2PguUUYZgpf4k41gcXmbUgdc3bvKhRDNPfVoVxg8DcyzdbH6kt4jKR6oFWHJd1R3Z24fyr6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=i5sOfcwd reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4d9fPs0mjKz1DHbf;
	Tue, 18 Nov 2025 10:26:41 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4d9fPr5Yzcz1DDMt;
	Tue, 18 Nov 2025 10:26:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1763458000;
	bh=/e4X68xG1gU6FLZnmngS77rn9PhpDpT87XyNVAA8OuY=;
	h=From:To:Cc:Subject:Date;
	b=i5sOfcwd0HfGz7TCIFUcfr02itnLnZT+YZ9LQrVLFtosndKP9kLhhFIRf2PprtdrZ
	 1amF9u7x5dCUrtWX+YhJrOEASjyly/waIpfSdqRiFhJi5PiGg1+wxGzn1eSQYfBZ49
	 +UDnW8rY4WrDauM40dSGCqxFKTceqzRfo60beLFTpTS2XlERIo6g2KYL/yBFHFaCc2
	 +WCstukx1Gvk7P7FHD+1Em+6c1CTZL2Oqe/IcQlJ+UC1ari+aePwKs0P0L83YchrAE
	 X1sZd4SUZU40U6YPWFJaaiaBeJZS/70q+6dqPPuQC/MLLKD2SzTzK0X+8izW5AdnU/
	 ecRtvoBWr81xw==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Subject: [PATCH 01/10] dt-bindings: Add vendor prefix for Frontgrade Gaisler AB
Date: Tue, 18 Nov 2025 10:26:34 +0100
Message-ID: <20251118092634.3576-1-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
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


