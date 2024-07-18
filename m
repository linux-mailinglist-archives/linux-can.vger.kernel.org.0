Return-Path: <linux-can+bounces-990-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3589352A4
	for <lists+linux-can@lfdr.de>; Thu, 18 Jul 2024 23:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0103B209A2
	for <lists+linux-can@lfdr.de>; Thu, 18 Jul 2024 21:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1909145A1B;
	Thu, 18 Jul 2024 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUGW17qo"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007346D1B4;
	Thu, 18 Jul 2024 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721336610; cv=none; b=E2z1D++aSGr5ahyUZQoqZdhSw6EQ7fkDp0u1sEefyb/BnYlCb/ZW+glpQ5je6ZXyPPmGHa2W1PqE+DHRarttS1WuQzXg5MaKbcUmZRdRYfBOUyP+qBIkISlaS9S6cnGsHPh/p6PcX0TyxD+tiPJuSSquZRx+BbsroLL0OtLNUIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721336610; c=relaxed/simple;
	bh=tpDd6q/V8iOf+WXPrdDsbV4X0F6AjvrfS9lQhPUW9F0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mwpRYlKH1b7W1w3NUUAVl+RUKAPoidLLGwmDd3SPGta18PX0sg6drNEKZWUy3Tx0xORBrCph788n2rXuflCADz7+CIRqOjjakujsiTReXgU1PMXgeVkAuxQqDb+YX5GGTc3bOozdCZoNRsafdSSyh2Zh6S67lKktHdgqm9Nq5sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUGW17qo; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ee9b1b422fso11952181fa.0;
        Thu, 18 Jul 2024 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721336607; x=1721941407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JJQ4SAUQ02gRsQ7zWKDy+PLr5g0PLqd/BBdjXOrguw=;
        b=bUGW17qo5mHqvJ/rU2xG/FVeM3mpwMM9RZA2W+sB+VaZ4XkZmEOHybgZVghFNkHiH7
         mtnKwTkhF+ekXKa1p0v+0yxNLaXmArOvq1uRS3bu5ZcTWaTCId8wQc6YVFNEwHluNy8l
         egF3C2LXywG6zfibY2Nw1Chsql1umEqeqF6JAGwA9cYcBFx93YACtbhv6pzRBdxHo0bR
         FF12jg0anzF3Y4V+vtShayjkw5qZB634vjnTpaT4Xo2tMwtNpeN4aLZ+hNKkH14Y5bQN
         gWHogwdfV5ZveMZWPu73dsSGt0oUR//FBRP2enP1woSqUiS4nZNzascSTuInFv2Bf4Ai
         6KNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721336607; x=1721941407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JJQ4SAUQ02gRsQ7zWKDy+PLr5g0PLqd/BBdjXOrguw=;
        b=UGyredqsxukvIAMMl/tpWJIAS1MSF43D5Ocpv+jhipa2eSq5lTkYB4h4ztSNslPayO
         zN6H3RZBAwGRx/iNQ+FvcwJHIv03MGYxpK/enfcfuYsXeaFdEuPNiUsQVG0LRys6rNze
         aG+axPL8uDK3MqaV3tq2mokxIA0923+J3P/P4EexXngxmVIL/MvcfsuMhyy2Mfvkp2o5
         F4ve6dPVqJW3AmEFJvvnLKFWc2kyMGWEMxlx8yYqhfU/n5asVD1AK49horBF7dIEdzHk
         lDDxdGOoJKfUX44XY/jUII4sYMwiXktgkZEEAAVotaVy0YtNLnakwY8OG7h+ew+HZqHJ
         4xJg==
X-Forwarded-Encrypted: i=1; AJvYcCX8FKFX3LnEXrNOOAdW7KZ0MYwsIyN2FugbN00g7ovp7+sxSZQovEKdXFmWoAQEXNWgKnGEluZxDoPRc4SDdJlqWYbIiyoLBwQHXQ==
X-Gm-Message-State: AOJu0Yyv5jW79dWIz6KgUSOoky/FkCQ7mnuVN1jrnhNXPIiKDU4uw+Dn
	oZ4QezuOJ+f2e+rYUawwJlBSnnNexGKlu3JrW7Qtn7wuYy6azG3P
X-Google-Smtp-Source: AGHT+IHmMQDSZX19kkj6DZBFH+OdSaeqNPaxl/szYwL2wGxhyzRp/HelLnRG2H9kn25S5v2SgFFssQ==
X-Received: by 2002:a2e:87c4:0:b0:2ec:35a3:20bd with SMTP id 38308e7fff4ca-2ef0641ed4amr11041511fa.22.1721336607055;
        Thu, 18 Jul 2024 14:03:27 -0700 (PDT)
Received: from ilordash-vm.mshome.net (broadband-109-173-124-203.ip.moscow.rt.ru. [109.173.124.203])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ef05c80310sm4516511fa.13.2024.07.18.14.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 14:03:26 -0700 (PDT)
From: Ilya Orazov <ilordash02@gmail.com>
To: mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	a-govindraju@ti.com
Cc: linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	ilordash02@gmail.com
Subject: [PATCH 2/2] phy: phy-can-transceiver: Add support for Microchip ATA6561
Date: Fri, 19 Jul 2024 00:03:22 +0300
Message-Id: <20240718210322.37492-3-ilordash02@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718210322.37492-1-ilordash02@gmail.com>
References: <20240718210322.37492-1-ilordash02@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
It is pin-compatible with TI TCAN1042.

Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
---
 drivers/phy/phy-can-transceiver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index ee4ce4249698..dbcd99213ba1 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -89,6 +89,10 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
 		.compatible = "nxp,tjr1443",
 		.data = &tcan1043_drvdata
 	},
+	{
+		.compatible = "microchip,ata6561",
+		.data = &tcan1042_drvdata
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
-- 
2.34.1


