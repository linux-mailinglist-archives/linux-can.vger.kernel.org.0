Return-Path: <linux-can+bounces-1921-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4619C33A4
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A736B209C3
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 15:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AEA54670;
	Sun, 10 Nov 2024 15:59:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A283022097
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254371; cv=none; b=V46jQJBI9GnAjL+KFMbJbunIXlgJitmoeOfgzWf4JKnq2Yl2VxUaafoPj6lcUlH5ae9upj+dKXCeo+CYKAjJZ9pKxvwBMPFpL+j6/IG2fgDPPvjQi8v4NwHPSQ4yuhTs3bazr+YX5zyDpNmPqC1Wygt1xFDJ2+Oc/v4uhG5pmPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254371; c=relaxed/simple;
	bh=7foY+xCt0xeVtXGCm3TXRJaD8JBQtnThULnsCesTVGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R8J4iGoUz4O6Mfgama1gWzdgDMkKy1FVOuowUiZcrOkJt0NS1+spWdfioFRTfXuIwwR/UdXY3IAzApcP8qYUIO/pVc5nam8I9hwcczWtqjczdC64HcT20NrNTCtlo4FBHveVMsUT3jmhspz6UYCktJcC4MXQIlPjoINky7beNLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-720c286bcd6so3133715b3a.3
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 07:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254368; x=1731859168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maerS7/LVY4rHSOrjYy+iFebPeT1VaccfUJ13YJIBbs=;
        b=E+gbi9dLJdNhVEwteEE6h93ckZ9HQSd/JRQ66Au698mvjUeMo3D2L9EfvTL8fiuuGg
         pJliChhxlG080VLnIXUG2QTrjyM0N1h3N3Z/w1hFuHQfoDMMfZtN8VvgkS8JpWggsjCZ
         qofiVsnMK3S0DuUzjoc6aCAk3l792tbsl7jHoVO5VLLqQf/72sZ9754/Lbf3xrqBwrZU
         c8RNiXPnYw4s3+avieCK+JcNkTbl/VK2/tsyK1hSkYxa1bFAaEUdzdiw0FvNvwo3Vrfu
         0xFjlBlnOGYVZgBv4cU6BsO9W7udyaLsRpAUWuH8LkVVHvZ/eAujswPeEV0UK6FA/CvJ
         uugg==
X-Gm-Message-State: AOJu0YyZ2UsD8Jn4bbC4BhBNQ05sRsrUPQk/M1h8gNrEX+58c93C3giq
	Hpsyg/5TdKJywdrx0BM/ppdDiZcmi0kkUr9wIGnDZCwworZOAibn34Z8lg==
X-Google-Smtp-Source: AGHT+IEHui8KeHs+VmKKpGLdIQo3l8rXtXb1PFBDu3lKvIVRCMn9jaSLxGTG87msEOjrCfl7XfTq3g==
X-Received: by 2002:a05:6a00:1399:b0:71e:4196:ddb2 with SMTP id d2e1a72fcca58-724132a75e9mr12882842b3a.9.1731254368120;
        Sun, 10 Nov 2024 07:59:28 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078609ddsm7490959b3a.22.2024.11.10.07.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:59:27 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 00/14] can: netlink: add CAN XL
Date: Mon, 11 Nov 2024 00:55:49 +0900
Message-ID: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4458; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=7foY+xCt0xeVtXGCm3TXRJaD8JBQtnThULnsCesTVGA=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGN9zOFL92F330qtZs1sMl9YY3ww71plbsXX7COHjCh 8/zFF/87ChlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjARd1mGP5xZu5/6+TEe/xvh qrMsWetr13Yd8+svOaesNi0PYDGLOcPw343rYVDd1JshIkk33f4+E81+talMcMqF275XtBk/N1x +yQkA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Because of popular request [1] and to celebrate the fact that I joined
the kernel web of trust this week [2], here is an RFC to introduce the
CAN XL netlink support.

The logic is simple. The CAN XL basically just reuse the same kind of
parameters as CAN FD: the databittiming and the TDC. So the series is
just a bunch of refactor to either:

  - factorize code.
  - rename some variable to differentiate between CAN FD and XL.
  - make some function more generic to accept both CAN FD and XL.

The feature is working™: there is a dummy driver at the end of the
series to show the traffic from the userland to a driver. This said, I
did close to zero testing. Once I had one CAN XL frame reaching the
driver, I call it a day, and decided to send the work. Regardless, it
is Sunday night. If I do not send it now, that would be next week-end.
Probably some mistakes are hidden here and there, but this should be
enough for an RFC level.

Also, I am not fully happy that can_dbt_changelink() requires 8
parameters. I will probably revisit this later on. But for the moment,
I think this is acceptable for an RFC.

Overall, I do not want to rush this series. Linus should send the rc7
anytime soon, and the merge window will probably start in eight days.
I do not think this series will be finalized by then. I still need to
give a deeper look at ISO 11898-1:2024 [3] to check that everything is
good. However, if I receive positive feedback on this RFC, I would
probably like to have the first patch merged so that I do not have to
rebase that tree wide patch each time someone makes a change.

I will send a second RFC series for iplink2 just after this one. Stay
tuned!

[1] https://lore.kernel.org/linux-can/CAEQ16vpxthctdrpv0kBKEZJA8VNYffjGGPBGBY93RmKDD49bAQ@mail.gmail.com/
[2] https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/commit/?id=81d335d3586c
[3] https://www.iso.org/fr/standard/86384.html

Vincent Mailhol (14):
  can: dev: add struct data_bittiming_params to group FD parameters
  can: netlink: replace tabulation by space in assignement
  can: bittiming: rename CAN_CTRLMODE_TDC_MASK into
    CAN_CTRLMODE_FD_TDC_MASK
  can: bittiming: rename can_tdc_is_enabled() into
    can_fd_tdc_is_enabled()
  can: netlink: can_changelink(): rename tdc_mask into
    fd_tdc_flag_provided
  can: netlink: make can_tdc_changelink() FD agnostic
  can: netlink: add can_dtb_changelink()
  can: netlink: add can_validate_tdc()
  can: netlink: make can_tdc_get_size() FD agnostic
  can: netlink: make can_tdc_fill_info() FD agnostic
  can: netlink: document which symbols are FD specific
  can: netlink: add CAN XL support
  can: netlink: add userland error messages
  !!! DO NOT MERGE !!! can: add dummyxl driver

 drivers/net/can/Kconfig                       |   8 +
 drivers/net/can/Makefile                      |   1 +
 drivers/net/can/ctucanfd/ctucanfd_base.c      |   8 +-
 drivers/net/can/dev/calc_bittiming.c          |   2 +-
 drivers/net/can/dev/dev.c                     |  12 +-
 drivers/net/can/dev/netlink.c                 | 422 ++++++++++++------
 drivers/net/can/dummyxl.c                     | 224 ++++++++++
 drivers/net/can/flexcan/flexcan-core.c        |   4 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c         |  10 +-
 drivers/net/can/kvaser_pciefd.c               |   6 +-
 drivers/net/can/m_can/m_can.c                 |   8 +-
 drivers/net/can/peak_canfd/peak_canfd.c       |   6 +-
 drivers/net/can/rcar/rcar_canfd.c             |   4 +-
 .../net/can/rockchip/rockchip_canfd-core.c    |   4 +-
 .../can/rockchip/rockchip_canfd-timestamp.c   |   2 +-
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    |   4 +-
 drivers/net/can/usb/esd_usb.c                 |   6 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c   |   4 +-
 drivers/net/can/usb/etas_es58x/es58x_fd.c     |   8 +-
 drivers/net/can/usb/gs_usb.c                  |   8 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |   2 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |   6 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  |   6 +-
 drivers/net/can/xilinx_can.c                  |   6 +-
 include/linux/can/bittiming.h                 |   4 +-
 include/linux/can/dev.h                       |  39 +-
 include/uapi/linux/can/netlink.h              |  21 +-
 27 files changed, 606 insertions(+), 229 deletions(-)
 create mode 100644 drivers/net/can/dummyxl.c

-- 
2.45.2


