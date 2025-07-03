Return-Path: <linux-can+bounces-3941-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3BCAF801C
	for <lists+linux-can@lfdr.de>; Thu,  3 Jul 2025 20:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD88583A03
	for <lists+linux-can@lfdr.de>; Thu,  3 Jul 2025 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AD12F2C73;
	Thu,  3 Jul 2025 18:34:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9B32F2C6B;
	Thu,  3 Jul 2025 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567662; cv=none; b=ik3MssmLoo7g4iq/bAl0NTiBPg/kkxhifS/+HGzHFuhfLUe/gjXEFqXlNiegkyaLlZOqq0f/8CdYOGq5J4qfYwFzAYtCKduIEPI+Iall6qDHL7UcmPB6qnCoMP/vpjF0bmL1wvnAy9fgD9OGaDkrm2zTMuS1v8YO1Oa9IjQg8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567662; c=relaxed/simple;
	bh=JIYPEoh6dphXPyN/j/1HYem+qD2zUpQid13Os3rleAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AoZk3W1B+oNxJkjUCziWMTVfqH8WUuDY+Vfcv6YTG7DHgYe1tLZhdKCcA0jRqe+3zwr5H5SzHi1YDF7flSf4BF1vvcxQPJG7GmAg9z792wFvkg/D9kafT7pFqJ9VepH/Xx7xglnXTQJthd9/4lbxZvx+AuLSqrTYEOb1U7CupY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: TisQh2Z3TBi8gtPN3S7e4g==
X-CSE-MsgGUID: jZWZiK+pRWKox50tV2YDgg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Jul 2025 03:34:17 +0900
Received: from localhost.localdomain (unknown [10.226.92.64])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 13E91401D15C;
	Fri,  4 Jul 2025 03:34:13 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 0/4] R-Car CANFD Improvements
Date: Thu,  3 Jul 2025 19:33:58 +0100
Message-ID: <20250703183411.332828-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The calculation formula for nominal bit rate of classical CAN is same as
that of nominal bit rate of CANFD on the RZ/G3E SoC compared to other SoCs.
Add shared_bittiming variable to struct rcar_canfd_hw_info to handle this
difference.

Added the patch "Drop unused macros" to this serires.

Apart from this, replaced the RCANFD_NCFG_* and RCANFD_DCFG_* macros
with simple functions and replaced RCANFD_CFG_* macros with FIELD_PREP
macro.

Biju Das (4):
  can: rcar_canfd: Add shared_bittiming variable to struct
    rcar_canfd_hw_info
  can: rcar_canfd: Drop unused macros
  can: rcar_canfd: Replace RCANFD_NCFG_* and RCANFD_DCFG_* macros
  can: rcar_canfd: Replace RCANFD_CFG_* macros with FIELD_PREP

 drivers/net/can/rcar/rcar_canfd.c | 170 +++++++-----------------------
 1 file changed, 39 insertions(+), 131 deletions(-)

-- 
2.43.0


