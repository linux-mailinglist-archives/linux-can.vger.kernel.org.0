Return-Path: <linux-can+bounces-1995-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 596E09C5DB5
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 17:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF091F21D2E
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 16:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114522076AC;
	Tue, 12 Nov 2024 16:51:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD198200C87;
	Tue, 12 Nov 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430296; cv=none; b=jrc6vIPYvh5JNp151PPBKN69TY87fxsb8GKZFCh3S4rYGsNp6Qtk5ROKw5rOM+KOIMkX0396to7y5GYX0Q2T9jPfqjfkJkmu/rqXFvXlKo8Uvz9rpoBqQMqrwScAlgV1CkID/nx28TtvwTWyvWnv9aKS/rYKJ2QyBsr/WorUbRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430296; c=relaxed/simple;
	bh=5L8TLzDnEKEudv9igBq/b9E4Nv43fTN0oLzftiA7l6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LZnkKwLHwiaQdfDssFhzhEZQGFI0RuS7p0d7EmmCDoDJJiNrqSo17ENjZe4jjhgnoWn6bU6xcNiZWhqbDnDRoD8a/DUX3Pu3ywMBVgrLmm67rjrrp5lmEP2znLrixjIRD264xCJ6YzPcpzpSsXND1heQ05rOJm+EercKtgZ91IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e467c3996so4788651b3a.2;
        Tue, 12 Nov 2024 08:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430291; x=1732035091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdC+2ptOlEEBQJc78TU3705ZfrXiufGPNTtOUFuAO1w=;
        b=UNg7t0Q/UdNFe8l1oIeTy3Eym7/gCsrqnQcIVufhUw4IhmgCPEKd7ImBSFKZTo+j/7
         A+Iu72xv+hcTw0al5L9TFuB2iDSG3htV4yXyUgFqWLHyAbusvx3co4AsPIm0g0YYA9Kn
         5iZAYIqYvIAMJw2xxzTBhVlvJisX3dc6qpTPx7ri1GvcuDGIjazbhRe0EaRvgXXuq45/
         66qOe2Lks1WbsmoFy49woyAt0dUtcFhfYjjYWZmQ78xDdDDgPyfU8dR2TxFXbxHD7i1g
         V7kbv7SxWEsEVVIgCW1CNbS8lYuQQOP+M9FJan09GPBMmEisqQOCt3CrqyFvILtGTRzA
         RHJg==
X-Forwarded-Encrypted: i=1; AJvYcCVEkNFU8E84trCrUtYCh19W/W+VdW6Sf9kx9BDTU9Z2CIkLXjjrEiIZOlSQnv2ZYPuUMJHRcFnxLVifoTQ=@vger.kernel.org, AJvYcCXuJmn90pm3dfubxiOZ1j4GhhMqbJTZ3Tc89NXcf5URsRXbDxDktjuuObi8UEZy4FbO22CfrfJl@vger.kernel.org
X-Gm-Message-State: AOJu0YwSpeAtu8GKtbOdBJXn4lEzBVztpVxDfLM2fdl7DpWhcE/PbAcl
	dQ7ztGrbpeLHcDB+RnZrjaZUpfgD3e4U7Id2fNsPoARwcpCPEXtsyXx9oQ==
X-Google-Smtp-Source: AGHT+IHYBjYvEyVc2jsgZ84ia1IHup+yDI8zBd3Dh+zAuD7+sws+ZXUn0Te+QeMmdVcPeLFDyqyitg==
X-Received: by 2002:a05:6a20:c998:b0:1db:f53c:f501 with SMTP id adf61e73a8af0-1dc22b95a3emr22550553637.44.1731430291278;
        Tue, 12 Nov 2024 08:51:31 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407860aa5sm11271260b3a.32.2024.11.12.08.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:51:30 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 0/5] can: netlink: preparation before introduction of CAN XL
Date: Wed, 13 Nov 2024 01:50:15 +0900
Message-ID: <20241112165118.586613-7-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3285; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=5L8TLzDnEKEudv9igBq/b9E4Nv43fTN0oLzftiA7l6Y=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnG7W2ec9pOTll15PWBj/f37XP79N7IKje8VbQq4IFKs VLGqounO0pZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAEykOZ2R4bLwz9bOmcJWSaf+ r7irsONpseZU7t0tl/Nsl5/l97B+osLwV/LsEym26Tv0/3A+szRr3Gb58Qqvyo3E2ZZXjz6PKlQ 8wQQA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

An RFC was sent last weekend to kick-off the discussion of the
introduction of CAN XL [1]. While the series received some positive
feedback, it is far from completion. Some work is still needed to:

  - adjust the nesting of the IFLA_CAN_XL_DATA_BITTIMING_CONST in the
    netlink interface

  - add the CAN XL PWM configuration

and this TODO list may grow if more feedback is received.

Regardless of this, the RFC started with a tree wide refactor followed
by a set of trivial patches to do some clean-up and some renaming in
preparation of the introduction of CAN XL.

This series just contains those preparation patch which were cherry
picked from the RFC and rebased on of top of linux-can-next/main:

  - the first patch group all the CAN FD parameters into a new
    structure. The plan is to reuse that same structure for CAN XL.

  - the second patch is purely cosmetic and fixes a trivial tabulation
    mistake.

  - the last three patches do some renaming: both the CAN FD and the
    CAN XL have databittiming parameters. In order not to get confused
    once CAN XL will be introduced, many symbols are modified to
    explicitly add CAN FD in their names.

The goal is to have those merged first to remove some overhead from
the netlink CAN XL main series before tacking care of the other
comments.


[1] [RFC] can: netlink: add CAN XL
Link: https://lore.kernel.org/linux-can/20241110155902.72807-16-mailhol.vincent@wanadoo.fr/

Vincent Mailhol (5):
  can: dev: add struct data_bittiming_params to group FD parameters
  can: netlink: replace tabulation by space in assignment
  can: bittiming: rename CAN_CTRLMODE_TDC_MASK into
    CAN_CTRLMODE_FD_TDC_MASK
  can: bittiming: rename can_tdc_is_enabled() into
    can_fd_tdc_is_enabled()
  can: netlink: can_changelink(): rename tdc_mask into
    fd_tdc_flag_provided

 drivers/net/can/ctucanfd/ctucanfd_base.c      |   8 +-
 drivers/net/can/dev/calc_bittiming.c          |   2 +-
 drivers/net/can/dev/dev.c                     |  12 +--
 drivers/net/can/dev/netlink.c                 | 100 +++++++++---------
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
 drivers/net/can/xilinx_can.c                  |  18 ++--
 include/linux/can/bittiming.h                 |   2 +-
 include/linux/can/dev.h                       |  32 +++---
 23 files changed, 133 insertions(+), 129 deletions(-)

-- 
2.45.2


