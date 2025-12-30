Return-Path: <linux-can+bounces-5964-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D22CE9991
	for <lists+linux-can@lfdr.de>; Tue, 30 Dec 2025 12:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE6BE30319B4
	for <lists+linux-can@lfdr.de>; Tue, 30 Dec 2025 11:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FEB2EAB83;
	Tue, 30 Dec 2025 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baiuzfF3"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E02EB5B8
	for <linux-can@vger.kernel.org>; Tue, 30 Dec 2025 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767095899; cv=none; b=sq7CqQch6F1PFkBFFvg56SHxPfBnfflx7uJQC+l4jlNdRBmgtUzOFZfrsd3DaFQnBVj6VjaNWiEWCtay7ORYcKb9vlK04y2Qj9K680h3liGaH5oUKZYaPiuAF4t+MA+2ca6eNz+neFQCDPYPKysvKxYHQWMSjWSGS6jQH+UcAqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767095899; c=relaxed/simple;
	bh=d+2xPnB7dGcuqosjk+/+C48fm/uyvYVZTjvqvtwvvhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oWL2xmwyKZj4GwNBG+m7F7jN3LgSsW2euiKJnZw+Gc0S3o0szoDSEKhqj9IMBMFG6X8ReeiwQypeDjwEn31YFxga3oYVWUjJ6clJxs7mKTpt1+q+RNY8UyxHNX/OxNdNG65FsEJR3+LFG/c4bwz3QKfOwkhVHYOggLaV2vzzfa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baiuzfF3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-432755545fcso2133797f8f.1
        for <linux-can@vger.kernel.org>; Tue, 30 Dec 2025 03:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767095896; x=1767700696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W0jaMee74R6Jd9SG5nA70iiwro5sWea56YIglMn+Zr4=;
        b=baiuzfF3UU6ygGOIx9NyEzBfFfOpEOmfs+1BHCJiYrPyQQIbVuNwpJQWoW28v4+18y
         4EARyobDvE2LwiwDFKqR1S+xeaQBHlsIhzYhKSkiBKMYC47q6XiCUsQ4ejuBVs+bOzO4
         rDP7t5jY0EBH20PhusMFoiycuypUhQctd3WcftHvnEMsuFg8CPdtFJZDonRzVAcjCgab
         NArfLy3Z66//aFkkCj9oJ5J+r2W9T1MZ1iAbkO69ZyhLqZTCHWurrKTx4QDy9XAUEi1z
         iDsvZUNaGSjARUzZZa4qXQMGJ58wfeqJ7+8+cONG2yPLhJMuNGMavX3uKQG3Sh0ieRvM
         bBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767095896; x=1767700696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0jaMee74R6Jd9SG5nA70iiwro5sWea56YIglMn+Zr4=;
        b=Otu7rRTAnpvyUwQGXBvwRp8jf5wkz0KBtDQcBOqwJ8yQOQah6BMcq61I5i+Hh2W2UF
         UCE0DVDcB+bLIPDjLVaTSoyNtg++5HXu17Nk4xWDQYliwIP8pSbP4dzKnUWQunfl8LwI
         1c/H7Di76fasZlYXV7GGB017Bdbj0D1UlGhPLACY/nuTn3cP6QZDoNF1Xu3+0rGPP88L
         lW0lk0HctA0uWn9XdJaB7vj2H6pfBADcfUcAjwtnd4KS0YIrgJc8OmkRZq0CSPn2GC8C
         ThgeK8Dwfg1ppVurtY0oFKdG6vrKBQ5uMsE4qZT5o5Ha9/90yeug4RDgaIGFspxJCyVn
         ACCw==
X-Gm-Message-State: AOJu0Yy+HNd4+zF0YQ3fPPVaBxtYgYR/YQJEi6W5KqUmPg8p/u7j+OJ5
	wgco61uyDCF8GeYO9FG0O6HdIt1U3HoNxZjQPr8/j/FPFtFSLCmXiwTI
X-Gm-Gg: AY/fxX4JL/ITKzYBxq+EignLusBe/zRvmOSqFWk06nbBClvcYMqJ7dppHqlyahXhczp
	evbqKF9uzP0UX1IRlypDna/XZdARE8pTJtyosface8uMT1gtdh1/voL2MAEIkpGnnz0IrA8DuLe
	sdGKN818LYHCUC67qBgbm6NcokUn57EUYZcOqiGKKyZoJGJZO1YgK4XIFiJqljN/c55MkkmH3xb
	n8NHmuBVnzpi70U5wacajzc4XH6OjkVKYwpjPSe001ReZzqj1F5esnj7OzWYWS7Pc/46OIfI1hL
	88R2GHBEPZr81QJMbtZhHCcOaiYpvg1CGNV1/CXv8Kshh07xKLiamWaEyAxb0ZMXlSTWKPN7fz/
	TM0/U49Js2KTFiK7Kp82avYJ225mMZIy+qtbjJLYLKXXH7znAOIKTBVtqhTA99TgSAXNh4cuk3o
	V6Tff5BpA3hKUnSwgDXnq6Os3z2l5oVmP+KOS6oCROnPn7XDr3wphPg54cadmr/8YnppIkPrZYA
	UN8V5c1T21I8bP45EQZNzY36zvv9HSUIzw=
X-Google-Smtp-Source: AGHT+IF+6i7CSCMBwqHi/Xt/YB4sbRzK+in76u0B0d54P5QGmXa5sdLX5u/TXPE8fZQwP1UlLp/jrw==
X-Received: by 2002:a05:6000:288b:b0:431:a50:6ea7 with SMTP id ffacd0b85a97d-4324e50685emr42413913f8f.49.1767095896306;
        Tue, 30 Dec 2025 03:58:16 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:efaa:981e:926e:8957])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm68337227f8f.35.2025.12.30.03.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 03:58:15 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/4] Add CANFD support to R9A09G056/057/077/087 SoCs
Date: Tue, 30 Dec 2025 11:58:10 +0000
Message-ID: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 59 +++++++++++++++----
 drivers/net/can/rcar/rcar_canfd.c             | 18 ++++++
 2 files changed, 65 insertions(+), 12 deletions(-)

-- 
2.52.0


