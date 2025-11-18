Return-Path: <linux-can+bounces-5479-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90301C68802
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 10:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B0274EF553
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1CF315D55;
	Tue, 18 Nov 2025 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="m9OBLTvM"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0473002D0;
	Tue, 18 Nov 2025 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457696; cv=none; b=JED3SHFKEoaApIJ9C7CHo3gtBMIhX87ncjXOPPqfI6xIkRHDQkGi3vsHORWT0GFfYIu+6KkImoQPZw27mqmpoNgBU+qerL61Tu2K99R5fmljx2LCxXgj65Yg90ndxe5rHIQpNTbU8+3ELfKdH2vJwG1NWoodnTqjOJPrw7YN7kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457696; c=relaxed/simple;
	bh=TZyWk9jjqqbVyfqG7U5NY8aXjAHEJzA4VTnk5rwHIAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duYqREBvw5Bb5qPvldiwt9Lm9jgioL+RFoM17D6dv8BN3xRHw75wPB6zQzYQMXAVpQphpyLTNB7xWo3+Tg4a/9DwstgLiSs09rdV929YXyc9mEPS5XKILYl97USmOHttHN08eYCi3NI6D0dLAOGOkgD29U01kK/Qgk840mWpF3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=m9OBLTvM reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4d9fHv2GCLz1DQqn;
	Tue, 18 Nov 2025 10:21:31 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4d9fHt60PGz1DDTS;
	Tue, 18 Nov 2025 10:21:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1763457691;
	bh=dGU5JS1NOmLxMLxAUqMZLV4VSvB6qlG6yu1QcrvUIFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m9OBLTvM+netJc6jGiWfOMAuR4w09GOH12apDtOWfBI/v0IE+JP5Aob3XHeXB1t6i
	 o5Y2xldHiQpjd5pD4xf8cnV8ij4Zx0yZUAPf4filXZmi3lrRB0fCJdRG+0kuY5Pjx5
	 ekurOBi0zYI/9vJoclMTfQ2DgymUCAhp1GWETMVU0KG/AYr8oD7VqH77CYYKHUSlk0
	 OZe+NEzDE8q/995CfXGjgUdtqiMv2mgfVwFmLbeUi2Xp92RVLUOgmg4DaigvO9ZJb1
	 mU/zMpN8W0Ubkzz3kIVHNWQ46t82zfTTXw2fU7NmFjrs4Ps+XRtYeDXEL3MLsGvRpF
	 D+Az1iwFJ03sQ==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH 03/10] MAINTAINERS: Add entry for GRCAN CAN network driver
Date: Tue, 18 Nov 2025 10:21:08 +0100
Message-ID: <20251118092115.3455-4-arun.muthusamy@gaisler.com>
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

Add Arun Muthusamy and Andreas Larsson as maintainers for
the GRCAN CAN network driver.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0dc4aa37d903..14ddd48e063f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10706,6 +10706,14 @@ F:	drivers/gpio/gpiolib-cdev.c
 F:	include/uapi/linux/gpio.h
 F:	tools/gpio/

+GRCAN CAN NETWORK DRIVER
+M:	Andreas Larsson <andreas@gaisler.com>
+M:	Arun Muthusamy <arun.muthusamy@gaisler.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
+F:	drivers/net/can/grcan.c
+
 GRETH 10/100/1G Ethernet MAC device driver
 M:	Andreas Larsson <andreas@gaisler.com>
 L:	netdev@vger.kernel.org
--
2.51.0


