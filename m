Return-Path: <linux-can+bounces-3024-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2107CA56E90
	for <lists+linux-can@lfdr.de>; Fri,  7 Mar 2025 18:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFA416CC17
	for <lists+linux-can@lfdr.de>; Fri,  7 Mar 2025 17:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A910E23F26B;
	Fri,  7 Mar 2025 17:03:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA9A21D3D7;
	Fri,  7 Mar 2025 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367027; cv=none; b=CaitiFg2zrHnk4aJqs37ink3xlJZdtpmlgoBaalIyT+YqYW3AdDLBLjvYpmDk8X6Q1y+ug2/A4mzhQV/oOYGVl3T4r/vExHMXzXBSk6D9PuXcRLx34wC2C9f8sr9snEJQcDUzCGNbJSQWyjqKMnaaG5Moxz+FuGBAmVKyzYYf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367027; c=relaxed/simple;
	bh=e2zB3YVItrEFO5HQaM5For8g9Laax3Bo0hBz7C9JI5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r5Rdj9PQEqPRS3SsLobpwvUFOHLKK1dg8mYQ4aWuGIMbC3RwJgq9qFB8Qs7NWqCadxAvnM8Oz8rOSNGO9XCHdeFJWwI8+sP2vm71isD/PPmniCClqXb6WIQ5P9fF3CqSs1JS3LrI4t2S65akp4T+9CzgsP0Y92XEnUWORJxYzn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 8iHyRgHWRmSrMIfK3BIjDg==
X-CSE-MsgGUID: JVlkhBwHT+6ws2dP0Ofdyw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 08 Mar 2025 02:03:37 +0900
Received: from localhost.localdomain (unknown [10.226.93.104])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EB3054039AFC;
	Sat,  8 Mar 2025 02:03:32 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 0/2] R-Car CANFD fixes
Date: Fri,  7 Mar 2025 17:03:25 +0000
Message-ID: <20250307170330.173425-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses 2 issues
 1) Fix typo in pattern properties for R-Car V4M.
 2) Fix page entries in the AFL list.

v2->v3:
 * Collected tags.
 * Dropped unused variables cfg and start from
   rcar_canfd_configure_afl_rules().
v1->v2:
 * Split fixes patches as separate series.
 * Added Rb tag from Geert for binding patch.
 * Added the tag Cc:stable@vger.kernel.org

Biju Das (2):
  dt-bindings: can: renesas,rcar-canfd: Fix typo in pattern properties
    for R-Car V4M
  can: rcar_canfd: Fix page entries in the AFL list

 .../bindings/net/can/renesas,rcar-canfd.yaml  |  2 +-
 drivers/net/can/rcar/rcar_canfd.c             | 28 ++++++++-----------
 2 files changed, 12 insertions(+), 18 deletions(-)

-- 
2.43.0


