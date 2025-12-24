Return-Path: <linux-can+bounces-5930-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13164CDCEF9
	for <lists+linux-can@lfdr.de>; Wed, 24 Dec 2025 18:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B4B8302E7D6
	for <lists+linux-can@lfdr.de>; Wed, 24 Dec 2025 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC7F3195EA;
	Wed, 24 Dec 2025 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXtYOTNO"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6F2561AA
	for <linux-can@vger.kernel.org>; Wed, 24 Dec 2025 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766597613; cv=none; b=D+FAz1LCsn9x3jOMRz5fOmtZMJSPl6VzV8iWtHdwRW2iRV2Zwz33TMX/RZ9Vv67DlWDcFxvWK5wN1fyj+7oWw3y7r+p4bHpQssM69C97fYsbQ2fyQQQoYLFxjx8OoMC/09ilppdicrwdh/xHLcmVUZvuxrhhxoHa9Z5CmaVyMPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766597613; c=relaxed/simple;
	bh=iQJDc5BjJvP9KF1/sFbPLA3orXtbN8fxDAmUVgi3DEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VjzaVL/6Qm3M2xc7cDWYgSJMGQYDA/gs6eyER1ademdbM8osBeG8FuqnvSRaovGqc+zWq1prjP3DAd5MLgBEsldECPZtws9yNokvIL8sTV1EPAPzRDl90HOrkd7y/TzeTJFoc6bv6t/LsiWAoOEOxYUWFtSvC0o0dngnYLg7ik8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXtYOTNO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so40663945e9.2
        for <linux-can@vger.kernel.org>; Wed, 24 Dec 2025 09:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766597609; x=1767202409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RMK6RvtlrIjrfo/E3tzc/Jr4xeNGB2EO40kI4nwJnt8=;
        b=EXtYOTNOLiDPvwRGvEYW+OMQ3bOcrJTG4JsBeUdKPxOQftYtlPwSBSEWjd8/sGCsV3
         l4TJTrAXYW8dfpdBsrpEWJUsbVsklK7ifWVLKDbLTRuj96ObOQbtfpVOKCaP4/eNtbYS
         ZWBwijLv1WawlWiJ6ew4fTWQUrIhQyjb/3098yUxcCyWUULt0aHMCHHxU5tgcdamkWYl
         E4YiGYruOk04ZfmaqGf87ny9KVnIZymwNNu964Iv9prcE8k/8tRNEr55pPl8qwXdcCl9
         qrqP8JgCV+xslOjaBi9hA/N+EcYikfeEj+CeRHr03LAuIHHqusIEZpiAaXxgAmYaeTw3
         H2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766597609; x=1767202409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMK6RvtlrIjrfo/E3tzc/Jr4xeNGB2EO40kI4nwJnt8=;
        b=hhTNZ+PI5lUnV9NNa4yjoZaa2aqDf6DHmDokFUe/OOiBck5MjjdPO4QBiW8oYc8f6I
         Tgk9DsqNrCsrBJ6BAzy2zLhPigAh0cxJZotB6uXzxleW4Zu4p/oFCvyyTVYojhgP7i9M
         g4ZLLo/54iHFKjmv8hV9k/8gZN1ItUkmXlK5cMN/T7aZRrBFRakPD3egKfzd6OEfMgXG
         ZROsSib4138uPGQZPE/e/d4aebwZS5lctWtCeJZJ57NdmWoD9XqH39lyKXZbSZCLpU51
         /SNuCpEXzTdIJsNJ+UXnlglG4nyYjfGawPDMiBMTjmI1ilC3I/+aW/td7Op11eLkVY/6
         xqQA==
X-Gm-Message-State: AOJu0Yw1i2V/VzX+KmJ4lB5y9kmYAlBtgN+F/oru0wojIsfQVZfCWBhx
	B0qOAnq1ZQG+VegzpVnPulM7C8s9OfU12rg/DhHs0nWXHEtG2AyFCeyL
X-Gm-Gg: AY/fxX5YfWvLGaHWJS0aIb0AFtMHZ6ZfDP1Nl4F8JKYVBdx7vOoL1zC+1xpEgGIp15U
	ypo5AtWNIJtORUCtlM181qm2HPZd1+bvIVcllGmbhXdoovwzGzal2OUPrKfXbW9Vp1yX28M+P6Y
	KiFtpmZEvnx8uFoK4+OwUfumErkW3Q5LGVuVeIbROZACskBAe0/PiKIKP/nmfkrh6xxkp188Rj1
	cZdPX42ejF+WDOv/muvXNLCOwdqor/zv+/fTcb/O4cJsJZ+bIdbVqWF5COuMWl0DSfblGRzD9JE
	DYhbA+vtMVPt3QLBQIbg2cuZkWGq4TzUwZXBXGnU4tquUFwpJmAObxT0m+b0P2SABbcfmSb6oVT
	jLZfqsGDv2PkG1PhDQXr2NMkPCtbigHqQSolrq6ljYrG8qyHy7EdNmtwgq9FoVSgK7V9ipuhCPl
	8j0WsrLjODO9GTFu4q7GR8TPywmKJJvA6ixLFKLf4NQj3l5VmmIa7aQlhHNtBj1KNy4fS3pDMrd
	9JR4cHjmQ0XA+JwGnzBofPp
X-Google-Smtp-Source: AGHT+IHC7G9p2+PyEAcKRLFlt6+KZPgvqnsDBf0vCbs3EhS3aOpa9h0pknAbR4+kNyns1nzUHdyLZQ==
X-Received: by 2002:a05:600c:444b:b0:477:8ba7:fe17 with SMTP id 5b1f17b1804b1-47d1953bce7mr155031505e9.7.1766597608592;
        Wed, 24 Dec 2025 09:33:28 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:3371:7b65:aaf4:d2e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af20sm33237553f8f.2.2025.12.24.09.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 09:33:28 -0800 (PST)
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
Subject: [PATCH 0/4] Add CANFD support to R9A09G056/057/077/087 SoCs
Date: Wed, 24 Dec 2025 17:33:20 +0000
Message-ID: <20251224173324.3393675-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Cheers,
Prabhakar

Lad Prabhakar (4):
  dt-bindings: can: renesas,rcar-canfd: Specify reset-names
  dt-bindings: can: renesas,rcar-canfd: Document RZ/V2H(P) and RZ/V2N
    SoCs
  dt-bindings: can: renesas,rcar-canfd: Document RZ/T2H and RZ/N2H SoCs
  can: rcar_canfd: Add RZ/T2H support

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 42 ++++++++++++++++---
 drivers/net/can/rcar/rcar_canfd.c             | 18 ++++++++
 2 files changed, 55 insertions(+), 5 deletions(-)

-- 
2.52.0


