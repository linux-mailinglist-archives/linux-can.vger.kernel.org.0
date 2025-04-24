Return-Path: <linux-can+bounces-3469-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EE4A9AE05
	for <lists+linux-can@lfdr.de>; Thu, 24 Apr 2025 14:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5208E3B4EA5
	for <lists+linux-can@lfdr.de>; Thu, 24 Apr 2025 12:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE3527B509;
	Thu, 24 Apr 2025 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mwa.re header.i=@mwa.re header.b="fKuh/Lkq"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48022701AA
	for <linux-can@vger.kernel.org>; Thu, 24 Apr 2025 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499201; cv=none; b=XSaisvhBGA+e2hBkryPiei+afgBX6JWSr5+kiq7tXgCOovrT1bFeB669yCtXmeS6JCOP5wpjUaY2Sl5ajwd5CMengaKDzPNyKmg3tGodBQaNxgDIPxdpFj7Bx8lvmOegUfCbdBJEvrmfl0qYXtiEhaoNnS3T852dCz5oX91su7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499201; c=relaxed/simple;
	bh=DxBNQJBPeh8jU6Xckk6xFrDJjMmrCmkkKoxjle3sUXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BbDgRe84+QtAuM3SqpAX9toTlmQq5+hXe9frwuUioQa09JBLDijxmKKaLF7+FMC63a3eIi6V8jAxwkAetjFf7YpdlTSH7x4vvsjv9TkbkunwqA+X9vpwzM9UZrCYS43Zq6a4XOTATyeaCNRxT4LuiKk585RMMcO2schisTqEwmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mwa.re; spf=pass smtp.mailfrom=mwa.re; dkim=pass (2048-bit key) header.d=mwa.re header.i=@mwa.re header.b=fKuh/Lkq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mwa.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mwa.re
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so8637645e9.3
        for <linux-can@vger.kernel.org>; Thu, 24 Apr 2025 05:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mwa.re; s=google; t=1745499197; x=1746103997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LBeAKJ7KUcW1dQvt6wdl3NV+6b3AZQYzsiqjB7Iqsd4=;
        b=fKuh/LkqOZju5xY0QNfjc+bbIMzJspTkQUc5EsF0fxLrfjYdPELWjzQx7XUy5c5/tA
         cMzz1Kozrxro1WCt5ZSPviclG5emk3I7G/o7kK1Fpz1ZVcRodNTIQ2jS2wMPL4Guu+kR
         ei8qtvBO+l2NTFknc5sKEBuPav1Qr3bkI21yD6mpkIHGxJc7AZRu5hSOffD1Pv3rl4mv
         4skA/Iqx6k/ZDM6CcHjJTey1pgiJVSnr//SfZIwZis+t7EaQpvkYK5r2Azq/uO9AsMzI
         7kQlHxlG37T/3eVKMxU0t/c4tzRPPuQ2P1MnNRo67TyHEFZaTRm3FXoQ+1WALXeOElzp
         XY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745499197; x=1746103997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBeAKJ7KUcW1dQvt6wdl3NV+6b3AZQYzsiqjB7Iqsd4=;
        b=U56GdnUpuWEuYCUJQ9qTwqw1zFZ00TZ9tjmNetWDxmQ74D0Jt2Sb/u8lGc/j0rLG0p
         59E1j41QGEwsJzob/8AHDt06jabUjKYWrP4ITqCNd0BOAjXX7T2eMAG9Y2yY/tZF3jvI
         XgVbrXWzPkfEfv3fXr4pIfpZmU3FqI5UJfbHaWg7oE6keDWBPWbuq0m0nNZUEbiGwRfm
         Tdy7wNv0Ih9xvuWmd/Au3/CTxMNs9G4b0492vM85aeA7u9KsazIsr5DipLynElIKK+uC
         bRnlFLxQAtK0qA209DZ383eTBrK5hWa2He0QUEOSXsgfINx0E3/lktWKapTN42YQ33en
         6/qw==
X-Forwarded-Encrypted: i=1; AJvYcCU0j89+IQHGWoZWKfYYvlKZNc/Z1YB3UXrs2rijSxMfmpPKBpZRVX/ThvUBWj+w0JaLCFji/ToSSH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2/DzRCZvGP/5O4Fr9w/xmsqYTHvrGwG3UDeJLvSWtBvcpcsRU
	sCGO/bEO5HA4QUAxJfw88OVC77kJye5i5XMSWUCl2Y4t2mQvFQbhLx8qdmXqU/w=
X-Gm-Gg: ASbGncvSmBUY0w98Ht2euiNh2AVj9g3Ll8TR2PIhjB2kfAX/UhlIaYwkt7EgFMtkWKi
	8J5FyNxnuJAJXtmGaZ9R6Bha1KYvUfXC/c3LvXuAD/3Irp4QG1UDYn6xgWeKVPNnFO1I2rTtRqS
	Jhjd0px11ETNMf+hPxmMBRKRBnPWAJ1OzFZlryMU2HhZxNdq16r27q0E53G3WnX6IilBIYyylch
	wyf8u5bTaNVnZmn7fFROXFk4bQnLp/AHL/IVs8upg2L1/J1c6x35ICdaRupVQMC/M0CRE5qXpzA
	YGi65o3WEHEe79kMh4ZQKSEOygM6LXqbG6y4P2AoFWwiDByzGXlqHq3jIubx7/OzSt/YJvyIfMT
	y
X-Google-Smtp-Source: AGHT+IEppmH4zKcBOoPZazDeFre0hec+YmCx5L9B/fZlDtqDoVt95EXVe+b4uRH2rTi83dPaArW3UQ==
X-Received: by 2002:a05:600c:46c9:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-4409bd8fca2mr16008835e9.21.1745499196866;
        Thu, 24 Apr 2025 05:53:16 -0700 (PDT)
Received: from mw-ac-stu-3.corp.mwa.re (static-195-14-251-13.nc.de. [195.14.251.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2b8a9csm20471435e9.29.2025.04.24.05.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:53:16 -0700 (PDT)
From: Antonios Salios <antonios@mwa.re>
To: rcsekar@samsung.com
Cc: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas@mwa.re,
	jan@mwa.re,
	Antonios Salios <antonios@mwa.re>
Subject: [PATCH] can: m_can: initialize spin lock on device probe
Date: Thu, 24 Apr 2025 14:52:20 +0200
Message-ID: <20250424125219.47345-2-antonios@mwa.re>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spin lock tx_handling_spinlock in struct m_can_classdev is not being
initialized. This leads to bug complaints from the kernel, eg. when
trying to send CAN frames with cansend from can-utils.

This patch fixes that by initializing the spin lock in the corresponding
device probe functions.

Signed-off-by: Antonios Salios <antonios@mwa.re>
---
 drivers/net/can/m_can/m_can_pci.c      | 1 +
 drivers/net/can/m_can/m_can_platform.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index 9ad7419f8..06243cd43 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -143,6 +143,7 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_allow(dev);
+	spin_lock_init(&mcan_class->tx_handling_spinlock);
 
 	return 0;
 
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index b832566ef..c09c61d25 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -154,6 +154,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	ret = m_can_class_register(mcan_class);
 	if (ret)
 		goto out_runtime_disable;
+	spin_lock_init(&mcan_class->tx_handling_spinlock);
 
 	return ret;
 
-- 
2.49.0


