Return-Path: <linux-can+bounces-989-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4119352A2
	for <lists+linux-can@lfdr.de>; Thu, 18 Jul 2024 23:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509F81C20F57
	for <lists+linux-can@lfdr.de>; Thu, 18 Jul 2024 21:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC74144D35;
	Thu, 18 Jul 2024 21:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUrJAMYW"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396278297;
	Thu, 18 Jul 2024 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721336609; cv=none; b=CgvvMsbtaB/iJg3Mw2B2WstMQ4nJ3XP3MiWqOj9E/9H94xex7vBBlg2C+0ppr6EhjcqAtOHrGVoC69Fx/JJV81ck6YV+dOGOYyzVswlU+bHuzRbNuoFuuDzRUqswy0NWIQOP9UCTh2k1kynLNYoPIt1lN4TG04s8n5bBG05WUwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721336609; c=relaxed/simple;
	bh=rpgMkZiLKf+sjKsbyhuE9QXOCOqmw+pblS7+3J9MsdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CA4QGmyOwxuAmoOWVJvlT5/Ap35wDGywuvxRLzIwu1ppumsqHdjFVfCquPPe2RuAejMnNcu3THaMhE/K3JN9da4VbcmmvAo7aY9zQbEZkXusxz0ZWYW+n3oC+hF7wveZIcg1yUn5LVufAXlVI9T7h9r6feeBjzLxVeqlIqgPGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUrJAMYW; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eecd2c6432so20839841fa.3;
        Thu, 18 Jul 2024 14:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721336606; x=1721941406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ng8/MluP5o8TGqH9RO1LUWdUmWhLfHB51ju7l5WzX4=;
        b=QUrJAMYWnI0a7GQghdfL7zow6mTKMWU11gtXtHeuaHaWlxBkEThuU23+GfSmwPu60u
         AW60wrV0gvjEY/buKNdE8+twzIwZ4IKnz6O2yQbkR7afzZyRXOcqFZoJG2GoscxFdYO+
         pQC4AQailp0BWQxb5MI1gJ6l56iG/yp0JKtIDeLdxZK8SECw03eB4Xq+nWBhevslaHpl
         4VDSpbUK8MifSeOun8RvJUGK120kmkkPEoB6cYl1X/i3pcNSz9PpFlxlNH/e73ogf21l
         AZZCgqRjhc+jcuXU0UwAYdB2iDwWRZs+0afceqhRM//lbo9Hn1FoZ9hTv8cjaB1lvp97
         LVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721336606; x=1721941406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ng8/MluP5o8TGqH9RO1LUWdUmWhLfHB51ju7l5WzX4=;
        b=iOOtP5rppsvA8WBTnzVDHPFGTlnxystlqbz/il7DQgavPMYS/w7/4Lx6QzAz9lO5Z4
         wBig/dhoz09mVPz7RkP1yEt4ZQpMoqVXkcC3hn3mNEufftRMA1vKYFPtkG/hFAYf7KCB
         LenjmDimkXBr0uWOEr5glmBu5BzVoLKzh4WlVF2j3FdFBFbTy0XIfnieUuhW8w+vH0xZ
         k7yLnI3j3+Yic16af192tm2KK6nRcgjSHJKB3LcSlryjifIC58TU09pJc+dbSzLasQTW
         L7nAheMgjWzvLTRW8D7pgKgK3TUD2Hg8AqWXvK3zWdtEuoExyI4m4qEYHcIyOQ0mFUiZ
         ce3w==
X-Forwarded-Encrypted: i=1; AJvYcCXeIrRyBILZXmVIe6u6KXADJ0ab+sZD4epK/TWP7Lv1CPZaw6xNYD121R4v4AuLQqBbAkeIK2FeHsOZvnjGATweYOxBMOeYEFKWjA==
X-Gm-Message-State: AOJu0Yz1PXSp4fGY5N4KNXLVNn05jvnYNUCJapGRKfL7q6NAHlJqNKtv
	BaP+yr1euyp96n5Ttc/RpoKApSh3Aq5fvHx4bgS9v9ZsyXf8kXnM
X-Google-Smtp-Source: AGHT+IFtLRuDysLz+zGkK8nebDG8VhuqMbu8VfFfGsXzrU09Na8CGTIsRluoTBh3S2mHGVy2roCHVA==
X-Received: by 2002:a2e:9f55:0:b0:2ee:7a7e:8ebd with SMTP id 38308e7fff4ca-2ef05d43ad8mr29097631fa.46.1721336605904;
        Thu, 18 Jul 2024 14:03:25 -0700 (PDT)
Received: from ilordash-vm.mshome.net (broadband-109-173-124-203.ip.moscow.rt.ru. [109.173.124.203])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ef05c80310sm4516511fa.13.2024.07.18.14.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 14:03:25 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561
Date: Fri, 19 Jul 2024 00:03:21 +0300
Message-Id: <20240718210322.37492-2-ilordash02@gmail.com>
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

Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
It is pin-compatible with TI TCAN1042.

Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
---
 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 79dad3e89aa6..03de361849d2 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -18,6 +18,7 @@ properties:
       - nxp,tjr1443
       - ti,tcan1042
       - ti,tcan1043
+      - microchip,ata6561
 
   '#phy-cells':
     const: 0
-- 
2.34.1


