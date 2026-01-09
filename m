Return-Path: <linux-can+bounces-6070-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9865D0A49A
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 14:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9D5C3139631
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 12:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A1335A94D;
	Fri,  9 Jan 2026 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk8xlc0m"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2F333B6ED
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963096; cv=none; b=d5Ws3tAVjbQQ2q1+4/hE1ga5UFrub+lAYYn65xwLAXCkwhjp/6kOZD8oSRDMulxKJbww8r5rfs8W7eJ/iyqle52sBR39GfYV9zeOMEt2tmnr0+AkSXl46SV1/2as9/8dYwZHREttc/tb1I7LZddXHGRZ4scVYh3YHQJIFkSLb1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963096; c=relaxed/simple;
	bh=oMqnKCGvM2MOVWH2H/4ovRIEzkEUK6rGC/U26bZ5M68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NjT3xtGRd6WRK+Tou+/O44P+AZ4UUWIdQOLjdLjOBA5cG4bXIVqCe+mTS2StPQ3NB5C/KupTCz+lI+AuEeQIv7zKTiZozV1X3VNpOP+gTDI5ASMIoUHv3CzMVFpYBveE2qR3Y8Xvsp2tw7ohBuk/1MwnFVmlK+8eJvjW/XFNIeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jk8xlc0m; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fb2314f52so2216389f8f.0
        for <linux-can@vger.kernel.org>; Fri, 09 Jan 2026 04:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963091; x=1768567891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hxPhHw80SEFh8tiFPx1w4hrDq9nTnH852UAWj9JfzxM=;
        b=jk8xlc0m17tWSrwtvET7Dn6Z/FWRdnwmnrHdF9RkpmtdlrE03NyjdxygCkx0DQFsle
         c1YIhQjOZ/QsTytYGISDp4j3JXva6saOol1fehkGVu+WB4548leUuhgZdx1G1qCDnH/m
         00wGMuiqVKKQIkLV1apx+UuYnnxyzVIbc2Dn9gB7fEeytd0CkJkWYT1uKT5cYzKKdzwv
         yZ8WETZrP1qOSXtCsy28KjUSFBPyblGyGmk3ILo93Bv1qxTN+EU76tPIbc0zyap76Un3
         aPDNkeTijC2CJk4ZUvAF3tjs2lVWtVaTPhjZJMATI6WXZG4YjgNWUfZizwRk4qdbEnK1
         z48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963091; x=1768567891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxPhHw80SEFh8tiFPx1w4hrDq9nTnH852UAWj9JfzxM=;
        b=ZopZsz+YPaYNspJ7DmnwN4nm+ktZei46Xb9pytH5NRBzdkwXCohx1QbhzpI96QbFo/
         ZhOJ/obprzOatAwDt+lSDB8CGoZKWwWUFYwXFOAvK0tmLD4hIDjZaUdGnsQAp65lAfwI
         RK8oOKrl2l1ENu5zYGxLktoiZBox9Q11xh/ByLs5JMmW4IhzyyVuTZIBau0KZEnX3Jda
         j4CPFKo4vqiIzpXbFJ1i3SXymR4qkfBYpmayF3gDLFGsxaV7CFEpLZiBa7Sz/RgPnMPe
         IG5YTNOScqkD+aeikWMM5YOU2YqagMRf3J44A10EcPdPUZuP/KOE0clwaJIcPyqhl5c+
         KBhg==
X-Forwarded-Encrypted: i=1; AJvYcCXb8hTFtYrbAy2u+xUSUBiRfwz2WBHCA1awR7x6ufVjJeX3E59Fbw87QaileObpU21OjgBhpm6STas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzCHCIegfdRMsNfw7yg0i1A9ierz8L44umByQTNnmx6re/zAeA
	PD9E3xKQFOlBt/6h9fGQPmRi5xdCgol5Bvc2Em/cbobpDrNCQnSuW8mE
X-Gm-Gg: AY/fxX68iLc+VTo9WMK97bNeHHGmYbw07W0xWREtMo/AhcXZ+ZFKf/pjDK/Hk7jp/FY
	eikn6dsjoFG5l73a61dwuyyWHz3Bb8qlX+Tl5qCn11dSQ38S17TWxB8GuWmuCFG2pn61WboO32P
	EjwQz6rP0EZmj6Fle4jihdTicLHc7v9TmQT7+ls34JGrobJ1b6gPc1cYhn6c7Ltms52cTWdtDW6
	8sdBoqONcimmfeHV9d8QZwFMkNBdGZEOlqWctsovVxTjQwKBMWsZGMBTTS1HBl4DM7mkXTMhmES
	6ucaUnxS3HaiEUEWPMIqRyNiTA2xobxEQ22AX2BsQmUefyukYZr0jeid9/hipKiJRDSaQxBpZwZ
	v46zzjfuqJMK7G/1MsKnh/7EsOmku4mD7wGI9cxBM2+CVC5N5dzMf8lCrNEclRr7CqlLyQWVp9U
	m4ny8ZJ5B7X8Iwlrbxu0DfSObvnDEDO7v8NjXkwq6kDUVLaqNSGinykaB35pmuIF0mAIArfiVuj
	Zz09RzTREiwyohN94oQM9g=
X-Google-Smtp-Source: AGHT+IFm+Lt3i21xsuQCozdlJluIaSR7hDnRRWusnsKqhRZsf5JKbN09iM9dYvvrnTqLDhayJrBm9A==
X-Received: by 2002:a05:6000:18a6:b0:431:2b2:9629 with SMTP id ffacd0b85a97d-432c37a6c08mr11093766f8f.51.1767963091223;
        Fri, 09 Jan 2026 04:51:31 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:3d06:ce2:401e:8cb8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dad8bsm22837291f8f.8.2026.01.09.04.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 04:51:30 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 0/4] Add CANFD support to R9A09G056/057/077/087 SoCs
Date: Fri,  9 Jan 2026 12:51:24 +0000
Message-ID: <20260109125128.2474156-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series adds CANFD support to RZ/V2H(P), RZ/V2N, RZ/T2H and
RZ/N2H SoCs.
The CANFD controller on RZ/V2H(P) and RZ/V2N SoCs is similar to the one
on RZ/G3E SoC, while the CANFD controller on RZ/T2H and RZ/N2H SoCs is
similar to R-Car Gen 4 SoCs but with some differences in terms of
number of channels and AFLPN and CFTML bits.

The patch series includes:
- Specifying reset-names for RZ/G2L and RZ/G3E CANFD controllers.
- Documenting the CANFD controller on RZ/V2H(P) and RZ/V2N SoCs.
- Documenting the CANFD controller on RZ/T2H and RZ/N2H SoCs.
- Adding RZ/T2H SoC support in the rcar_canfd driver.c file.

Note this patch series applies on top of:
https://lore.kernel.org/all/20251126155911.320563-1-biju.das.jz@bp.renesas.com/

v2->v3:
- Updated commit message to clarify that reset-names existed previously
  but was dropped for patch 1/4.
- Grouped single compatible entries into an enum in patch 3/4.
- Updated commit message about disallowing reset-names property
  for patch 3/4.
- Added Acked-by and Reviewed-by tags.

v1->v2:
- Moved reset-names to top-level properties.

Cheers,
Prabhakar

Lad Prabhakar (4):
  dt-bindings: can: renesas,rcar-canfd: Specify reset-names
  dt-bindings: can: renesas,rcar-canfd: Document RZ/V2H(P) and RZ/V2N
    SoCs
  dt-bindings: can: renesas,rcar-canfd: Document RZ/T2H and RZ/N2H SoCs
  can: rcar_canfd: Add RZ/T2H support

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 62 +++++++++++++++----
 drivers/net/can/rcar/rcar_canfd.c             | 18 ++++++
 2 files changed, 67 insertions(+), 13 deletions(-)

-- 
2.52.0


