Return-Path: <linux-can+bounces-6146-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CDDD1FEE2
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 16:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19B7E3007684
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9E33A0B20;
	Wed, 14 Jan 2026 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQN8X8K5"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858E32D4B68
	for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405531; cv=none; b=GQwAFQ0NiJVB9k/LzLAbcKXS+nYd8R+IYMyJswPHOKjgIibaYMNKYvXZMiDSqGG8LoYq7vJp+jNOt2Bl3hCRTikQCELzHy88k7zLKQy0dnqP/wn05kDjYGynFs4BZuXCmL9i3LmsWJJD3qQXdzW4d9XFFH8pPElw4sMj/WsIwyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405531; c=relaxed/simple;
	bh=Up2AstbZWFGTvOK9odG/3yJUO1giaEyY5igE6wJD6Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K6vj549/Yx27wfjVM1PI4T8EsZc+8zTfe0v+9IsJb8ibpqRB3M6UShaa7QJCwOf+ERmSVSnQPyTJBCAVbDtcYCFxRudfQvdULGghThhU1bw5C29QSGV7qOUSGLeZ+NoB1kciqRF0BTgmhQDg6292Kv5f5J5wtaHAZxZti32i6cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQN8X8K5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47d3ffa5f33so40355815e9.2
        for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 07:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768405528; x=1769010328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+KLyVPl7ef6pflNddejrx56gS9wwrDJcy0wiU6lH7IE=;
        b=BQN8X8K5oQLntQjbYTr+qhNa4mEVDEazwQOTi8zvqXTP66WodEGasnj5jA5f4v6syZ
         qcZj7ooOnq4mdp3IFHyXJnowIKriPjqvOgfYDEz0vIvtZ4DI0HtRyZOVTmRlOTXcYcCt
         f+zYcg4kuLG6ec0LtWQq1xxutTtkwEUXMvN/E2VeH1XG3UlyPgt2YUJd8lrtzXR0d49h
         2Wx0cCaHJRfEYrigIjB8pevhZ//5N8MqXaFEj87J7AWPPLM5FKUUqZwY8QnoAgUsY7XR
         N411LOXwcg5kSeYnfuXD0DlS0KZGjbZ8evhgZiuFQBycik6ms6FlParQzi1uUKfCgJ79
         gTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405528; x=1769010328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KLyVPl7ef6pflNddejrx56gS9wwrDJcy0wiU6lH7IE=;
        b=Y2rX5yxhZ4KQg9Q0MiN/i8Yjv2ntSjCDTBCK4vmR+zpl3uLyOjHa0tOTUG0iK1RZgl
         c2pJDmcrDOGdPJi2l8quD8BP7jai6eFY3mP1ObtJE+am0K4UppB10CVdS0H9pmT3E+Kd
         9D2wzLpJF8beq3iLjRSyJ524tMKgrpgunCOy/81W4ZrZ+oOhbVhBOyIdqhZSwUszPFZy
         fHNRWJ5mzFl5U+Lv/RhMv4Gfq02VAKD0sO7rd6acr0xntx4UsPWB4Vw6PcjynHdAxBOu
         06wnASYvfcqDloZ+rk1dNVjLnGGQlPtRsgCOOZderh9HZfIkjPC458dqRugDM2N8+/HZ
         ducw==
X-Forwarded-Encrypted: i=1; AJvYcCUINR3pczSrLmpso+00PV/fCv7cu3JZW8pWDKPffjnGVmhdEK9BaogxdundCSzpjRszaBpPTGEa4qY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyHbv+IKnHLRsAR9NXmUvPOP8awyIXpEvE6ROmwQdlgI7LxshU
	e3uROEm742Qwv2Umee8DlCIDo0n4NKN7Tsy+DCySjxPX+oUbRiOCtU9j
X-Gm-Gg: AY/fxX7ds62R6XGFGZxbGo0e8Ji2KjgBYsqSzuS8Pklvh8GrX7GYj5FVGppPwg08HK6
	BnJNeIeRlsHPviTMODm9x87L/Et2OwJrjUQd2HWYOnlEkZIZFXbRFC6KW4ZreywVquQytJzK1C1
	YYjz6sIc2xry2+ZOUMxhJvIgFaITy8ua4S1MXQUqvGM41xQf7/LBSTW4Km0ZbMmqkpKnvcUkdUc
	jhYHGmjzgn2+0qfsGWFoU4MZoVFjUe3ryXryjcPHiN7EaNOrJNObG/KdnViZ/Qn7Gs+2vz9nV7C
	W2NrPdWpxcsefLihsSZaHiXkrrD7FrhOT+AWX9N1Be0D8T2JUysX6JNergDV2hZqIw1TQ1vr/5U
	nJZH/l54uSeNlBQdwwT33+hJeK/d+qHzbj6rYTe5dMviKFPkcIQrCvgGsAFeG6K0HMrpoCHPq2Q
	pDLJ2u2CWRSLCwKIJnMJSl5ZKdxPGGgHvroWVGjDyHH2tql+YODqX8+3rb2FlVRo23oT7YQ+ngP
	rZinXuFwU2vfaS5HRwDV9Pn
X-Received: by 2002:a05:600c:3483:b0:477:9fcf:3ff9 with SMTP id 5b1f17b1804b1-47ee33a0fe7mr38193535e9.27.1768405527738;
        Wed, 14 Jan 2026 07:45:27 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:7f20:df14:ac2b:3d74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee544387fsm33867105e9.0.2026.01.14.07.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:45:27 -0800 (PST)
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
Subject: [PATCH v4 0/4] Add CANFD support to R9A09G056/057/077/087 SoCs
Date: Wed, 14 Jan 2026 15:45:21 +0000
Message-ID: <20260114154525.3169992-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

v3->v4:
- Added Reviewed-by tag for patch 1/4.
- No changes made for patches 2/4 and 4/4.
- For patch 3/4:
 * Dropped Reviewed-by from Geert due to below changes.
 * Moved single compatible entries into an enum and to below oneOf.
 * Synced the resets/reset-names handling with other similar SoCs.

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

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 79 +++++++++++++++----
 drivers/net/can/rcar/rcar_canfd.c             | 18 +++++
 2 files changed, 83 insertions(+), 14 deletions(-)

-- 
2.52.0


