Return-Path: <linux-can+bounces-4277-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F73AB2FC30
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 16:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF4F3BED08
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 14:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037562E4250;
	Thu, 21 Aug 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv8rR0z8"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317D2E0934;
	Thu, 21 Aug 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785674; cv=none; b=XqxlMFsAou/N/8ldX0zOgiB0R4S5y7H46woibfUNBx42xNfsgaOU9obN4uxKthD4hAqC+rd/eNYH+M5Nh8eofsuPUFjLAB0nXIGH4oA6mjEIA0yiRhmF2+UANs2L5bBB3w9/Bo+g3qfzW2StL20RJx/DS5oYOdmoaSDrqQw5ah4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785674; c=relaxed/simple;
	bh=KgL45VHGgnyoU2RwRV1ifjU9PjjOnG8pW1cf8cwYuSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IG6ukoxmA8CFrjJZCdDG4XWMqxJsptfWhdsdcSBl8fQHotDueJ+75kEmGmyeCXpAxMZxJbKl9khnQ1fNuRsijW2rUSKuUABklUsz1sv0qW8i5Zx8A1RSL+as9UOQP1CjS6+z8e7H3mInoLOP5OfIsTD0ZrXPf7sSWC/yAU4FVDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv8rR0z8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a20c51c40so8734575e9.3;
        Thu, 21 Aug 2025 07:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755785671; x=1756390471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bosipIRuVUCtBBaIWjqpKagJIPPd5q6csCY/VhWmKw0=;
        b=Lv8rR0z8PBh4H1M026P2xgaaO5QZqoJy0pgpOzRAaV8LHFBXHQkwoyZC0XYtYz57ul
         Jp5DNjFCyqS1T80SAP+NuoE8LbIBCMnJwuQjFTlsT6bvOsY+8FPACw08e4jqLL8z5Lpa
         +BMAf2GZdIX96tFN97KEZ0inbqywBac5/qy6BbQHL7GUOsBlK6QtQGQN8RGO3Gx6JSfo
         A3lJV67R8uTrs0DKzCyTmpiK3a9j9REEpJrNvwdK0DYvVa/+43DaBkXs8Z5S6BGU4tsn
         lWnnEKtt5+e43yUXwqPenUZdhIbcchoE8O1ZzQSQhQoCRB76kGXqRt9U+keMkaT2pI0C
         qPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785671; x=1756390471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bosipIRuVUCtBBaIWjqpKagJIPPd5q6csCY/VhWmKw0=;
        b=lrn54r1lWPf9wTkwubDGUidjE9rG2dqZ38ddk/gkzASsvkGAkZoEcZGMb77jLBlBfO
         UBBKmq0sGT5VxcQUGmLppPBeiIg5EDnW7XO/2qpUkEtbwwnsdijxxDnPfBew55hM4eVv
         tvfy/3M9oi5COxMjKP7WOvhvCCTTsjM+c3a/akLHNgCZE8xHG689OLzbPQs1AZ2aALqQ
         OkYhUp6iNNRdHCNXlk2rtXBZ6S3kwG8nTFnBM/PtVQDxO772wEXYQj6lutB7wTFI+pFd
         JnvqeK8PNPOVVU5aZTEX66cqSuv0AYOxtHWeNPumfEtGKLDqLIG1ruSP6ASqXPHfFQwU
         3GpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcxxFgUYIsZ9lv5kIkXkd4yCIBV3eIKr7+4NQ88uBpOmP4OQLYSIx+Mq2hqdOpyRnppxFwEbiz/lI=@vger.kernel.org, AJvYcCVaTHkNKl/e4Wb3gKLoUHia56QvRLZjwgqYp+OVMgUvD/9TIQ6tp6Mpn0WOHhOQZYuefx76M6y0QUb9xXGp@vger.kernel.org, AJvYcCVwokaA97C69BRl+GHSzZUa+ME3DF/JPM9rVG9/tpTDdNSTBxtIr1PmX8y4aolvlcLwdX48ZY59klewzQ6JUKX+Ljs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws8VRo87tWLLonHpMr8u6ssxy0PlC1nHofYaced1kd+jndzjZi
	yuOlf0g+vZFLE9uvz6an8AkuTVsSMOZW4AyvUlmWWPtesyzusNLrnHjv
X-Gm-Gg: ASbGncuz711cwip6vLqToQ/5zA6IJr+GgWFHVvitKaFYNaFHwc66MTEWEihOSUHlV+V
	uBpqcd63FVF9Amf9f6Ur+eXPWo2PT/OioGuEKQ1z5VXycZQjRgLSfqDxTP1/Uok76rI5w9zcPCA
	IABN/JxRP8c7lURPqPQ+AHY/PuwODeufOmhutX5fzv8iCQBeDPFkvLpWTjH5Ix1A0eTNtSl1ub8
	ALjcZBKgph2C/Ve6PKbM9z5qtuOyjZ27mD3hjkQaSPztl3XI4enf4f1HZbaY39AfLAevX6KCz1F
	3/eQ7XCCLws7ocenTF42kmEvSqLzZ/lUTFgtgg4vCD3/6HE3jbbb/xspWYCj7MfHaVcaILg/a80
	OId8GBcS+qxoPOv6+3FZ1pzQSzhirFHpRjveU4ZolzU1Lhz/12faEDSgIh5q2IcjDdIYU23u8sP
	nmSh5AdnWD
X-Google-Smtp-Source: AGHT+IHZS+jXyLMzpNR2tf42wJNhHytgial/pGBLRpPS2kALIyCLUcv3DawHNwnBylCxyrkfJ4oSwQ==
X-Received: by 2002:a05:600c:458d:b0:459:e200:67e0 with SMTP id 5b1f17b1804b1-45b4d7dcc58mr23137065e9.10.1755785671123;
        Thu, 21 Aug 2025 07:14:31 -0700 (PDT)
Received: from biju.lan (host31-53-6-191.range31-53.btcentralplus.com. [31.53.6.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db1be3csm33203505e9.1.2025.08.21.07.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 07:14:30 -0700 (PDT)
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
Subject: [PATCH v2 0/4] R-Car CANFD Improvements
Date: Thu, 21 Aug 2025 15:14:20 +0100
Message-ID: <20250821141429.298324-1-biju.das.jz@bp.renesas.com>
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
that of nominal bit rate of CANFD on the RZ/G3E SoC compared to other SoCs.
Add shared_bittiming variable to struct rcar_canfd_hw_info to handle this
difference.

Apart from this, for replacing function-like macros, introduced
rcar_canfd_compute_{nominal,data}_bit_rate_cfg().

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
  can: rcar_canfd: Add shared_bittiming variable to struct
    rcar_canfd_hw_info
  can: rcar_canfd: Update RCANFD_CFG_* macros
  can: rcar_canfd: Simplify nominal bit rate config
  can: rcar_canfd: Simplify data bit rate config

 drivers/net/can/rcar/rcar_canfd.c | 89 ++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 37 deletions(-)

-- 
2.43.0


