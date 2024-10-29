Return-Path: <linux-can+bounces-1833-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9A19B488A
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 12:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52501F2387D
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E6B205AA5;
	Tue, 29 Oct 2024 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gJy2LEX1"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55F8204035
	for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202392; cv=none; b=HaGZywHH77XixwFTfbgw8l4GjYIaQTe6q4ahwVeUkfRx3ubwDstQxLh8+YKwtp+EN5NOAuKTHZ1PS9JHrbxARrOYG683k1Fpp4OxeqoN9OVgyY1y5OhOYZNDuMki9DgNCeVBlVgt7HoehsFZXZ0SdCUIMFqcKHyB2F13o1OH/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202392; c=relaxed/simple;
	bh=05amL8SvxVx1O2sLPStVWErHa1NKdoFQ/D3/Oe7ZQH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JWHFCfTG87+aM5A+E+6LWDCWD5xJW56rfqktIYoMF8mG5ElnDOfo031q3FKbr9sB+MVFe7Bu3K1/SoZkiHbPwVZFROvzxwE7Ek4krQKIXn+S2l1GzDwdI3EhmXgCuuuiohqOXL+TBpTuGcCg0xU7qWnMcnYtT99ROQCUsN7nWRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=gJy2LEX1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso10526826a12.3
        for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 04:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730202387; x=1730807187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IxDkWg/vsTbegwMYodB782ex0h2qobbSL22Fla0Iv1A=;
        b=gJy2LEX1ismWYH1uWMLZjfQ1TYs7heZQ4dK2BCpnDtj86+L+JCXYF0Uu4DGUuDTmDx
         DKyWqaTBZ7zwJgpYTNUTIes0JFtaYa9YblDEX6DJmK8kzGfgWU3gWYXBVNl58zNgrxfC
         rsajVgg9lytpsPO0VoK+QUcbpHLjzMR5gkp3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202387; x=1730807187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxDkWg/vsTbegwMYodB782ex0h2qobbSL22Fla0Iv1A=;
        b=YUyMvx+eDh7D1d2Ox4BeDMc1GPMZFpFm9qJwpGxRem+7HJFbAui3p9T+YJo+/dnFwW
         ShYWytd3JQXcT/SCPlQN9c8fT73qYnaHXzzw9A/mNQp1YI+3HQjnxi0Pt8bqHllJit/i
         QSVvIHc23VET7DiJ33igPTu1EW6pisxY2vAOandiAObLnev7S5xugM70ZryihGA2cBLQ
         w85WNs39qwL3i3ltf/45RKeYHguLEVmAgr5Ni7ezR9BBbZm+TTwhZ4ZHk0GZV6444dRO
         339eekuMJcxj1r+tX+QH6ArYo1u5hExtc/J1c13iMVfTp2l+vz0qDGsEQwv7y9mWcfaR
         WRHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCDjj5o5pmarOrjrQJA2pB1KX0ko4CqOVo0k3Wg6rqHtds1/TTk8u4ybaiu10D37mGNpH7IPLvqjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg3HpFAo4bSZQ7fRe+pSvDyORea+8dgTZ200MhnMoOJvl42J01
	2hLPfiNMk+zJ3lEjeWekLTPplcmlBAGLHZD0xNi3ryuVpaRim0vy4fdiI01r6kQ=
X-Google-Smtp-Source: AGHT+IGs0NMmrdpvJR6bB5NncULQydlcvVJYr5FXrebgpvaHSMtDo/1P0dhuvOmM0yOgg+PhHaYuwg==
X-Received: by 2002:a05:6402:268f:b0:5c9:b6dd:dace with SMTP id 4fb4d7f45d1cf-5cbbf891a41mr8436361a12.3.1730202386878;
        Tue, 29 Oct 2024 04:46:26 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.41.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6297a09sm3869301a12.21.2024.10.29.04.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:46:25 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
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
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v3 0/6] Add helpers for stats and error frames
Date: Tue, 29 Oct 2024 12:45:24 +0100
Message-ID: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
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

Changes in v3:
- Drop double assignement of "priv" variable.
- Check "dev" parameter is not NULL.
- Drop the check of "cf" parameter not NULL

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

 drivers/net/can/dev/dev.c              | 45 ++++++++++++++++++++++++++
 drivers/net/can/flexcan/flexcan-core.c | 29 +++++------------
 include/linux/can/dev.h                | 38 ++++++++++++++++++++++
 include/uapi/linux/can/netlink.h       |  6 ++++
 4 files changed, 97 insertions(+), 21 deletions(-)

-- 
2.43.0


