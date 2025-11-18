Return-Path: <linux-can+bounces-5489-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 59380C688E1
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 10:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22B6A380814
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 09:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB173126DB;
	Tue, 18 Nov 2025 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="kKTuKmxc"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E112FC862;
	Tue, 18 Nov 2025 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458218; cv=none; b=dh4nrX2FCHXrX4cdTCvL/ETR1itahv2dxNfp6p+jLE8KIIZL+2z1P4z8VwkQwmdWNDmpKB/0Oex54orfykgEBUkcEDLk96M6MDlThegU4GtE5I3MR+RNGbDMzqwgqE3TLRttR/hH8+6nAkAFz4wlag/OZ74AIrssU/D6BRZ4lts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458218; c=relaxed/simple;
	bh=o/ioPXXZYh/dgl1Zd0IL9GbLfli276QgGGru0OCthHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5qcat2EmJqBNPBHpv1nQM9IIXgRSsxiyWl3VrjRWv81SBrfkGLaYa+0WlyrwabcVTKi/HY87a6EYOAmvFKcGkbJZDD7kRsYlcabIjiLmrf9xwYsa1v0luS/3/HvPFXyyWQcCDaT6ckXsXGJ7DMyY0/tmZv0DlrjKXWSV6P17Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=kKTuKmxc reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4d9fHq5vp8z1DQqY;
	Tue, 18 Nov 2025 10:21:27 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4d9fHq3fw3z1DDqw;
	Tue, 18 Nov 2025 10:21:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1763457687;
	bh=/e4X68xG1gU6FLZnmngS77rn9PhpDpT87XyNVAA8OuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kKTuKmxc2dfYbaIgbHEwzd+xYMHf2X5cDd4nU9B/iwUQvqqe3VeX1ffkrkuOVl1em
	 kM7bcbYTbe/J609JgJ6NJ9jMVL+w/uT6b5VjwX95beQqESxwl5Rl1axrAiTdKX4Jod
	 pm28QW8kGIRTe6u1BWH9CInS6n3KUNNaLx3C69Yum+j1gmT2mM0yxkLUA7vWY5JUUC
	 Iq0rnkQ4WF3FOG5skYHjI66qIZmQb4KdwQjVnNJ4W+7K8T9/Bw8HapK5oAZ27fqh1l
	 LHs6fM2/JnJ/RppL5Tdr87EhzfFNJxMFrmwwDPQfemwqcuapIRKqn3EBGtUoWkjOg5
	 j+ZRe4pmURcwA==
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
Date: Tue, 18 Nov 2025 10:21:06 +0100
Message-ID: <20251118092115.3455-2-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
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


