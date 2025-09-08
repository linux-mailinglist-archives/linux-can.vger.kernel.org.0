Return-Path: <linux-can+bounces-4516-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C725FB48CE7
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 14:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CECB1667F5
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 12:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1455F2F8BF7;
	Mon,  8 Sep 2025 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKXrX9Ps"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2FE2F0C51;
	Mon,  8 Sep 2025 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333387; cv=none; b=GjIsf2F1BTbbiWhIV3PaCmb/TxzYtTdpznRtBmY7KGkBnq7ynxpyot3+P/6nLYs08uWBArUMlVCGC6JI3nGj6uqSaGV5WM2BNMlZZlRDq3etSoRy3EfGMMatrAP5ZroltKlqdJxVdX2jr4c/EzyARWQHuslevlgOkBYKg2syK1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333387; c=relaxed/simple;
	bh=tLBf2x0aUy7Pj20wyMSFrIn59yfzdxdn0mzULMoSMYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ast/k63qSwqVmv1IgrvrZBlw1PFrQ3jhNl4MYqgHaS173dDcvqTHUFJikZE31glYZogdpp6FoDZvPqtT7j49BhaVP0zy5TNCxpbnkgP8HKbpWEW6MBxskH/czmq25qtnJ9pgsmQ9OFsPxcqpqPipfLFgGXJ70V7M/SRsXMjGhQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKXrX9Ps; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45de221da9cso7075615e9.0;
        Mon, 08 Sep 2025 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757333383; x=1757938183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aF29gDbaZScA9f9y5T30f4pz/ssTg3xynxQbJY2OyqY=;
        b=VKXrX9PsTIm1woOS6njJdDUerppENAAgjSo1obsz9WCLdDc4OgEaIJWf11/HHjnhXp
         La7MLs11+IvOUU1Ngqc/a68tR/Zx/be2kvqkcU9ePxtFee9r7wWlTekcpvkKZwOJv3d/
         cdlgsullya8zwHEw69trCEyq6GNNFa7Cgv9DYUCnYJU999VzCZ6FYezVOZX0Vl8MPIg+
         L2jxEdrVBOzs1pphgQ8aRdOYU9EvrmKbEtWNUwknwtkDgLIe8intHxonLXMsmyOGY0Rc
         imWQGy6tFEvPhcxJ3W7DSZ0UOV/WV60nNsgwSNeQnoMB0q0JOUqsEicoztpELTfGghKa
         R7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333383; x=1757938183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aF29gDbaZScA9f9y5T30f4pz/ssTg3xynxQbJY2OyqY=;
        b=mvMy9Q4Vu8ZseQi+7RgfkAXdEiwc4c/x/pP7dXZ5ZwOpUrmtVlUJRPbzde0+xyfXve
         KVSi1DH6U08yS0p8cKIYDpcC81je0r9+SDR+CB8279JFxWBG40NdWXLApw+nVUckPING
         ppYMlA+lYe65YNUowKzkrf14+ZBBUIqaN4owOjKUg9mUo0dXFI70hhMcWznoqXFfv1QR
         D3TLLX+fiWbpslSL7NOb0U7xoC3PGbtZeRqsBxED78E3bSz6Q1bmVtGAzFi8modOY7Wd
         VAzm7YFDawtSIXUWgcMViVsJ3NPFQtOUYJkSb9cHLKsRVXsT2VdMvdyAkdf3jCInxpKj
         vryQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2wZsYPfb+EvkeENUTDDxMAJ+hVsqhK3t1FQG/TOqadkYVyqKQyawIKR2av3BiON3FnJFt2OWObrw=@vger.kernel.org, AJvYcCUWJTfCmeN7KFIGtMyKB8w/f58cBiv1LrwG3yG1ZptEC8cW/TXPD9Kbn2uT+KkA8AvCP9KxXgXZUl6RAANEKFCAdSQ=@vger.kernel.org, AJvYcCXlrQ1hTRoO/kufjyWPNed0sSXEI216MGjtt1rJm8NFujSQV12plY9IIkccZGJCmViQeyHC0pnAroGgoJS5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy89rVYMSM5htE1TmiSXsoJi5pO0j13656TJJixl2fr9o05hGor
	Tq4sB/fHt8jSVTbvAIyTxqJyuCGt9jyWN5ZTP8kIbRHbJR46PiJH5LED
X-Gm-Gg: ASbGnctIncqEuJ9Od36CUO08Iw8XWpqc54MIS+ROcQoiuXbsdxuBCmLH5jxfNrvTccX
	IhfgWroavF+AB+B0l7zABizqSUfpM0Kw8RkXskDhCDIGiDb4Gk8MAOZw76zK/DnlXY3zy/kRl19
	7Op3xn+GdhcWSm3lmsw15EQj7AE7IFe8O7eRyq0UCTJTGN2nHCDjkvAg6Hju7aAwwI51r5sf2Vv
	4tgql1JoaYz+cx+vJMLHjwd/GVM4Qt9dF7HSxW05ocNysgjiOSqAuchYYv6Tux5IlyL97rpFSEW
	ieCs7xobW1twpEZmeeitDqCyBtIk7Sz11iI+0w8SUe7J8HUAjIce5cqHwolincyNrAf3UjwLTiE
	qALcJZfj5gtd3FJ9DlyuN77ATcxi15nsMnRg33I7tW22U0mJFhbd6qDMtqaYYLVWwstf8/DSdew
	EH+TH2N8sgHNi8
X-Google-Smtp-Source: AGHT+IFl2ArUlZoUmXDMr1mr7YRCZ/zsPphU4IX2kB2gggELowbCYeT8py2xc4M+Qu0EKDQ0cb31ug==
X-Received: by 2002:a05:600c:1f16:b0:45d:d5c6:482 with SMTP id 5b1f17b1804b1-45dddec845bmr66816655e9.18.1757333383238;
        Mon, 08 Sep 2025 05:09:43 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e543e9f444sm9646415f8f.60.2025.09.08.05.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:09:42 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 0/4] R-Car CANFD Improvements
Date: Mon,  8 Sep 2025 13:09:29 +0100
Message-ID: <20250908120940.147196-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The calculation formula for nominal bit rate of classical CAN is same as
that of nominal bit rate of CANFD on the RZ/G3E SoC and R-Car Gen4
compared to other SoCs. Update the nominal bit rate constants.

Apart from this, for replacing function-like macros, introduced
rcar_canfd_compute_{nominal,data}_bit_rate_cfg().

v2->v3:
 * Replaced "shared_bittiming"->"shared_can_regs" as it is same for RZ/G3E
   and R-Car Gen4.
 * Updated commit header and description for patch#1.
 * Added Rb tag from Geert for patch #2,#3 and #4.
 * Dropped _MASK suffix from RCANFD_CFG_* macros.
 * Dropped _MASK suffix from RCANFD_NCFG_NBRP_MASK macro.
 * Dropped _MASK suffix from the macro RCANFD_DCFG_DBRP_MASK.
 * Followed the order as used in struct can_bittiming{_const} for easy
   maintenance.
v1->v2:
 * Dropped patch#2 as it is accepted.
 * Moved patch#4 to patch#2.
 * Updated commit header and description for patch#2.
 * Kept RCANFD_CFG* macro definitions to give a meaning to the magic
   number using GENMASK macro and used FIELD_PREP to extract value.
 * Split patch#3 for computing nominal  and data bit rate config separate.
 * Updated rcar_canfd_compute_nominal_bit_rate_cfg() to handle
   nominal bit rate configuration for both classical CAN and CANFD.
 * Replaced RCANFD_NCFG_NBRP->RCANFD_NCFG_NBRP_MASK and used FIELD_PREP to
   extract value.
 * Replaced RCANFD_DCFG_DBRP->RCANFD_DCFG_DBRP_MASK and used FIELD_PREP to
   extract value.

Biju Das (4):
  can: rcar_canfd: Update bit rate constants for RZ/G3E and R-Car Gen4
  can: rcar_canfd: Update RCANFD_CFG_* macros
  can: rcar_canfd: Simplify nominal bit rate config
  can: rcar_canfd: Simplify data bit rate config

 drivers/net/can/rcar/rcar_canfd.c | 84 +++++++++++++++++--------------
 1 file changed, 47 insertions(+), 37 deletions(-)

-- 
2.43.0


