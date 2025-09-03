Return-Path: <linux-can+bounces-4425-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8444AB41923
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4712B544E2B
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41D92EC54D;
	Wed,  3 Sep 2025 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeIQ+ija"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF92DBF4B;
	Wed,  3 Sep 2025 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889519; cv=none; b=HIvU2e7XXXMNTykBJ0ZNhdcoE5dkjCd03DnOyz7TxkvjUN5j35A38m5WwphgMmUK733+iiQfXgXpuSqEpXqUvgWSM/9i9m8oLxZ5VlA/bSmHd2MjCUIwQhDluW0m6eEzU3s1GNWBxCBgjHllgJjBU/EeMzkiNK7v917NvkQjEf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889519; c=relaxed/simple;
	bh=FBU7cyLxHkG0QQHaCLrIplnFvQzG+H73U4ukrGmq5zY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TzxrogCcDBfu6CXbL8oCbW4A0kllBLlEHhuXOL0aHSNdmttnl2QCDSAqScCWIai6b3TPXR7DkoCjnsptKOvIyOP1YrT9B8UJtC0JYm+JWoGtEUrw9qvhIAj2Zt7PH8rDefbfJyOIiHi/eXdb7TQDyY23wOCxomU3KmQFVDzEi78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeIQ+ija; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A505C4CEF0;
	Wed,  3 Sep 2025 08:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889519;
	bh=FBU7cyLxHkG0QQHaCLrIplnFvQzG+H73U4ukrGmq5zY=;
	h=From:Subject:Date:To:Cc:From;
	b=DeIQ+ijazsl/4nnGcNp3/aP4Ef8X/HHncPxjIwPAcsEemINsDJ1UF+HhaITRM8nbP
	 1Xp8z5G4GtYnGOAzog0WPgXaHRpRsr1hgnvhwPkxrSBdi+oFcGBSKxs92+gu///77U
	 RqD+krlnSp7+cs+d8iYCO1fKZ9ThoGIZ8SgTpgK5c0LShpLE4Fh04XaRzS7h8mQDh9
	 uHrpE7UB3o/JhUQICZRJftbjVtA/QxYP2bYKTXCHUaILuBjGuq3DnqgHsKwOP8gSvB
	 Jud1hZ8XeAayyEi7fDWERWOUsDZoLxTNoBj7vgb17vpDZag1zzwxXiXFa3aYZM03sw
	 Z5CNoVeJ/cC/A==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH 00/21] can: netlink: preparation before introduction of CAN
 XL step 2/2
Date: Wed, 03 Sep 2025 17:49:59 +0900
Message-Id: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADcBuGgC/yXMQQrCMBCF4auUWRtsq0LSq0gXaTLRwWZakyiB0
 rs72OX/4H0bZEyEGYZmg4RfyrSwRHdqwD0tP1CRl4a+7W+tvnTKWa6zYiwz8UutCVdl/BT01ej
 gjQc5yhio/tH7eHTC90fscoww2YzKLTFSGRqxxKvlHC0xjPv+A7itw+SVAAAA
X-Change-ID: 20250831-canxl-netlink-prep-9dbf8498fd9d
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5453; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=FBU7cyLxHkG0QQHaCLrIplnFvQzG+H73U4ukrGmq5zY=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GPP4gxTZHZ4u7DkWqbfrp7fPmkjJgNQJ2yoi47yc7
 z49oGTbUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCKRcQz/k82qorPqf2vNOGg/
 VWVHgV38zFmzv3eECdxmK/I5dVPJkOGfzUy5jrJpEbd8Ga/NXpby528zU3B9WfYWW6NUD223qcl
 cAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

In November last year, I sent an RFC to introduce CAN XL [1]. That
RFC, despite positive feedback, was put on hold due to some unanswered
question concerning the PWM encoding [2].

While stuck, some small preparation work was done in parallel in [3]
by refactoring the struct can_priv and doing some trivial clean-up and
renaming. [3] received zero feedback but was eventually merged after
splitting it in smaller parts and resending it.

Finally, in July this year, we clarified the remaining mysteries about
PWM calculation, thus unlocking the series. Summer being a bit busy
because of some personal matters brings us to now.

After doing all the refactoring and adding all the CAN XL features,
the final result is roughly 30 patches, probably too much for a single
series. So I am splitting it in two:

  - preparation (this series)
  - CAN XL

And so, this series continues and finishes the preparation work done
in [3]. It contains all the refactoring needed to smoothly introduce
CAN XL. The goal is to:

  - split the function in smaller pieces: CAN XL will introduce a fair
    amount of code. And some functions which are already fairly long
    (86 lines for can_validate(), 216 lines for can_changelink())
    would grow to disproportionate sizes if the CAN XL logic were to
    be inlined in those functions.

  - repurpose the existing code to handle both CAN FD and CAN XL: a
    huge part of CAN XL simply reuses the CAN FD logic. All the
    existing CAN FD logic is made more generic to handle both CAN FD
    and XL.

In more details:

  - Patch #1 moves struct data_bittiming_params from dev.h to
    bittiming.h and patch #2 makes can_get_relative_tdco() FD agnostic
    before also moving it to bittiming.h.

  - Patch #3 adds some comments to netlink.h tagging which IFLA
    symbols are FD specific.

  - Patch #4 to #7 are refactoring can_validate() and
    can_validate_bittiming().

  - Patch #8 to #12 are refactoring can_changelink() and
    can_tdc_changelink().

  - Patch #13 and #14 are refactoring can_get_size() and
    can_tdc_get_size().

  - Patch #15 to #18 are refactoring can_fill_info() and
    can_tdc_fill_info().

  - Patch #19 makes can_calc_tdco() FD agnostic.

  - Patch #20 adds can_get_ctrlmode_str() which converts control mode
    flags into strings. This is done in preparation of patch #20.

  - Patch #21 is the final patch and improves the user experience by
    providing detailed error messages whenever invalid parameters are
    provided. All those error messages came into handy when debugging
    the upcoming CAN XL patches.

Aside from the last patch, the other changes do not impact any of the
existing functionalities.

The follow up series which introduces CAN XL is nearly completed but
will be sent only once this one is approved: one thing at a time, I do
not want to overwhelm people (including myself).

[1] https://lore.kernel.org/linux-can/20241110155902.72807-16-mailhol.vincent@wanadoo.fr/
[2] https://lore.kernel.org/linux-can/c4771c16-c578-4a6d-baee-918fe276dbe9@wanadoo.fr/
[3] https://lore.kernel.org/linux-can/20241110155902.72807-16-mailhol.vincent@wanadoo.fr/

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
Cc: Robert Nawrath <mbro1689@gmail.com>
Cc: Minh Le <minh.le.aj@renesas.com>
Cc: Duy Nguyen <duy.nguyen.rh@renesas.com>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Vincent Mailhol (21):
      can: dev: move struct data_bittiming_params to linux/can/bittiming.h
      can: dev: make can_get_relative_tdco() FD agnostic and move it to bittiming.h
      can: netlink: document which symbols are FD specific
      can: netlink: refactor can_validate_bittiming()
      can: netlink: add can_validate_tdc()
      can: netlink: add can_validate_databittiming()
      can: netlink: remove comment in can_validate()
      can: netlink: refactor CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
      can: netlink: remove useless check in can_tdc_changelink()
      can: netlink: make can_tdc_changelink() FD agnostic
      can: netlink: add can_dtb_changelink()
      can: netlink: add can_ctrlmode_changelink()
      can: netlink: make can_tdc_get_size() FD agnostic
      can: netlink: add can_data_bittiming_get_size()
      can: netlink: add can_bittiming_fill_info()
      can: netlink: add can_bittiming_const_fill_info()
      can: netlink: add can_bitrate_const_fill_info()
      can: netlink: make can_tdc_fill_info() FD agnostic
      can: calc_bittiming: make can_calc_tdco() FD agnostic
      can: dev: add can_get_ctrlmode_str()
      can: netlink: add userland error messages

 drivers/net/can/dev/calc_bittiming.c |  10 +-
 drivers/net/can/dev/dev.c            |  33 ++
 drivers/net/can/dev/netlink.c        | 607 ++++++++++++++++++++++-------------
 include/linux/can/bittiming.h        |  48 ++-
 include/linux/can/dev.h              |  42 +--
 include/uapi/linux/can/netlink.h     |  14 +-
 6 files changed, 471 insertions(+), 283 deletions(-)
---
base-commit: 2fd4161d0d2547650d9559d57fc67b4e0a26a9e3
change-id: 20250831-canxl-netlink-prep-9dbf8498fd9d

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


