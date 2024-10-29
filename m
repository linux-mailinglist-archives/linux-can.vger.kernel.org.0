Return-Path: <linux-can+bounces-1824-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08FE9B44B1
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 09:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D9F1C22187
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 08:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B941204097;
	Tue, 29 Oct 2024 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CxNak1L5"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610D204034
	for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191569; cv=none; b=G/G/oCFAYGHVXfxT2IygDcq7hvujtQN4xUrJfyHAW+uPlTfVMXxz2hR7LezK0w/VlYqNbLj6/sDV20gfJIcecVz8RdGEnYuWaaPJFV/EG1CB3a7zOwpzt4mx6dmAMZ6hp8r5WvXcVd+hjzNIvO+qRbXbkSyKoF44VKuTrQtCRE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191569; c=relaxed/simple;
	bh=oMsPeNDPYjX24/xrsdIKUnroAYKkElkCjISZqScZwOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1SwXOdohefw6tnIXCRZTy5OMnc8HmENZjB+X/qo7RjUti92/U6M22SYeb/Pe707HdKCcluQUCJoyJ2Rm+tML4ETUu64tUUT1BJ4MZw/Z9cRMPWmnr7PT9CPaiFh98EiHDEgP2/NaKt20yZA6cK4fJn4U+peJdvjrYlySAk0LLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=CxNak1L5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99e3b3a411so988553166b.0
        for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 01:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730191564; x=1730796364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FgWCepazzfo33UdtIIMN3k0wsxQsDr435va3n4Xr8tQ=;
        b=CxNak1L5JQf0Yt56A7ip3UAPeRZSXzEMbKxHWHOR0H7db/CrB8pYS/Y3PYLtDo0mmK
         a5eBiGMuoMqqLPh1iLfAhycSWZXgC29Po0z62ifisHe89n3SbtNEO1oW/IPz5IcaC2Qi
         jVWOLkMDuraD04+Adjqh3GXhzxOTjY1W/Cxlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730191564; x=1730796364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgWCepazzfo33UdtIIMN3k0wsxQsDr435va3n4Xr8tQ=;
        b=drqbkHt/7zjvFCwSgt+zRMpSb4LMuSpIJZHXFHhWNqA37axhsEMItDKGzibFMKOIJ/
         VwPkFN4jrK7n6FTWCk/GvBLGgv72oxSAD3lduH9IrgR4xuzhkNewlPF8u5M94q3YZYOw
         eLXtFGIlnYZnCkGjBEnRvz1Luv96tvX3f+KFmcqTFhFLakCyG/jevbTIQnc/H5NmtGpG
         RB/oftdZTcPFuIqE/5X8hrRnUmA9xd5gMBg0AM7MT9A39T5R/LZDA63NCHEk8P7Heb4+
         K1Gpkg1ZydNNugKs9EgjTtipFWL/9sjZZrheGB2gvTwjDqMBHSIYwsXCYIWv0lsKrEgp
         NYSA==
X-Forwarded-Encrypted: i=1; AJvYcCUYnfIH2AwlrV9I1uEOXVytcf7GIj9PBCmD3KGQYKX4I4N3lzzqC8WcFm9pR23+0b3WMhRXWrIwppQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCwJgNcHYs9uwKuyokalXMDppZpcdxqAo7zMh46m6+DfvarF0c
	lze0lks4KHhEIhzi6AofV1J+j7YSXYB0CwlD/vdGE1asyQ2a4DzbTtZtp9jG4tY=
X-Google-Smtp-Source: AGHT+IEPwkX0IhV+bKZax/ZDnKCtE6vuHXhCdpPupl5TYU7s9VlSPImd24020c4tF67SdJTKa0gPiw==
X-Received: by 2002:a17:907:1b98:b0:a9a:8263:d2c7 with SMTP id a640c23a62f3a-a9e2b347278mr87267966b.7.1730191564353;
        Tue, 29 Oct 2024 01:46:04 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-40-68-117.business.telecomitalia.it. [79.40.68.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7dacsm450134166b.9.2024.10.29.01.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:46:04 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Gal Pressman <gal@nvidia.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Han Xu <han.xu@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v2 0/6] can: dev: add generic function can_update_bus_error_stats()
Date: Tue, 29 Oct 2024 09:44:44 +0100
Message-ID: <20241029084525.2858224-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series originates from some tests I ran on a CAN communication for
one of my clients that reports sporadic errors. After enabling BERR
reporting, I was surprised that the command:

ip -details -statistics link show can0

did not display the occurrence of different types of errors, but only the
generic ones for reception and transmission. In trying to export this
information, I felt that the code related to managing statistics and handling
CAN errors (CRC, STUF, BIT, ACK, and FORM) was quite duplicated in the
implementation of various drivers, and there wasn't a generic function like
in the case of state changes (i. e. can_change_state). This led to the idea
of adding can_update_bus_error_stats() and the helpers for setting up the
CAN error frame.

Regarding patch 5/6 ("can: netlink: extend stats to the error types (ack,
CRC, form, ..."), I ran

./scripts/check-uapi.sh

which found

"error - 1/934 UAPI headers compatible with x86 appear _not_ to be backwards
compatible."

I included it in the series because I am currently interested in understanding
whether the idea behind each of the submitted patches makes sense, and I can
adjust them later if the response is positive, following your suggestions.

Changes in v2:
- Replace macros with static inline functions
- Update the commit message
- Replace the macros with static inline funcions calls.
- Update the commit message

Dario Binacchi (6):
  can: dev: add generic function can_update_bus_error_stats()
  can: flexcan: use can_update_bus_error_stats()
  can: dev: add helpers to setup an error frame
  can: flexcan: use helpers to setup the error frame
  can: netlink: extend stats to the error types (ack, CRC, form, ...)
  can: dev: update the error types stats (ack, CRC, form, ...)

 drivers/net/can/dev/dev.c              | 45 ++++++++++++++++++++++++
 drivers/net/can/flexcan/flexcan-core.c | 29 +++++-----------
 include/linux/can/dev.h                | 47 ++++++++++++++++++++++++++
 include/uapi/linux/can/netlink.h       |  6 ++++
 4 files changed, 106 insertions(+), 21 deletions(-)

-- 
2.43.0


