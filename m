Return-Path: <linux-can+bounces-2892-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 415BAA3D557
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 10:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE973B22BF
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 09:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C9E1F3B82;
	Thu, 20 Feb 2025 09:45:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8E01F153E;
	Thu, 20 Feb 2025 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044734; cv=none; b=QzEn6wUCqrBfv6yGADsyq8g/SckQ3Y1RDqCUiS0uTBsbOyG01A4SuA4lvQ3/UAJviBHa0P7NdnCbRyGKBL43Zr+LK62IrveIVeQx6mtNyadIOvtoagGHQWLTBsUQnDVrK8bTvMjJDKFGpb+QOtvWO7m/pPqjhIUzuyG9tB0ZSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044734; c=relaxed/simple;
	bh=XSseanK2TphLQ568BAzn8bBCOYzuMrDsufDxEPN8fvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NubJ1e+5B8p8Jw07I7U6BLj6izENMFEhUX2+adZ/pVIJoBb0qCaWGaKiG7euxfjw5CZHYTJJUvqewRwzC/DsypZyiQX6wFnCVJqx6iA5AnWB6DQD8z3Qq90mpPYV9tsKFFir5iIG3JNFpKwxMjdl2ysULkT3IF7AvW8nSGEPiSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: FIg5OJM5S+mMBhHq3Wyhgw==
X-CSE-MsgGUID: uXSIcSfcTfy8BsKTGnBm1g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Feb 2025 18:45:24 +0900
Received: from localhost.localdomain (unknown [10.226.92.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3A96142175B9;
	Thu, 20 Feb 2025 18:45:18 +0900 (JST)
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
Subject: [PATCH v2 0/2] R-Car CANFD fixes
Date: Thu, 20 Feb 2025 09:45:10 +0000
Message-ID: <20250220094516.126598-1-biju.das.jz@bp.renesas.com>
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

v1->v2:
 * Split fixes patches as separate series.
 * Added Rb tag from Geert for binding patch.
 * Added the tag Cc:stable@vger.kernel.org

Biju Das (2):
  dt-bindings: can: renesas,rcar-canfd: Fix typo in pattern properties
    for R-Car V4M
  can: rcar_canfd: Fix page entries in the AFL list

 .../bindings/net/can/renesas,rcar-canfd.yaml    |  2 +-
 drivers/net/can/rcar/rcar_canfd.c               | 17 ++++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.43.0


