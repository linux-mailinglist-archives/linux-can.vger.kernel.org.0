Return-Path: <linux-can+bounces-5092-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75320BB0B3C
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 16:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C794A39B2
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 14:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191932571B8;
	Wed,  1 Oct 2025 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Wxj75PsS"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47306239E8B
	for <linux-can@vger.kernel.org>; Wed,  1 Oct 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329076; cv=none; b=Fg35JzCiCxbeuPak+VUROgICjqbRpS3Ybc0+N+j7nKqsiFwZC9Xr2V1l7pYi905Xs1sLaf549wxtDaxD29X/zKAaBL1BSjiBSm7MslO98AoDfD+IdVFXeTvg0wC346xv1M/lpDwkgVdOoSTi2SmlS5I3WHvuVNrfXJtUGk3y0ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329076; c=relaxed/simple;
	bh=FAsFqYeUZuQ31kGHakGP2ACf849Vb9hTBg2GPoJWZHw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eKyK8j7wEayTVxcqC5zdUqgf94FYTJGcinfppy/NvTEmu7UooblJxTV2Gyw325RxDBPuxYfQgxebaCrkQjnuJj9a9Y76kkhrCP5T8JdMVSI7fVa1EyidW4GhTh/S8XI0uivr6zeanZ0ippxlP8tk87d9Op+nwgFH6ZxlB9XA+e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Wxj75PsS; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6364eb29e74so6834067a12.0
        for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759329071; x=1759933871; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZ7+vwcnXj2GI+/fcX0CASFcQANixNgUTj+XzHlCvHI=;
        b=Wxj75PsSpDRESg6UzaKnuEWFC6Viov5kPvzjJGlh9NixtDnNx9cOvImgsgtD3p5+Al
         7ZZkYUne++6Q/cOj6MPGpkopIad0CZHlWUVXDOGLCyujm07AJ9ACV5833TYUIDbdUllB
         ZZsVqASBUI7BL9wMceaUBUWp9rCXiBp0qGQkO87qowIRYnAU4YgNvahO5vdATvUJUA5b
         wPkcGFc36Ot+gEEirzkrf0x/kaWPDRCEoS07PvlYiZ7p8Y0a/JJBCz+EIxmSsZXdAPWe
         cLjCnGVC2YD1ILtyAFxuA+jBxWnCczbl8L4tlPoaAwh7hzjJhFvVKDRkxJ4Yo9q+saF5
         vm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329071; x=1759933871;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZ7+vwcnXj2GI+/fcX0CASFcQANixNgUTj+XzHlCvHI=;
        b=V0tk7sAEen0ND9N51Y5dBUQD4kIQgXGwPyTAdRFnHviL3fBsodogUKuiMC3sYCcdBe
         WkPJsp5lUeWnVw4KSTwqA4QAfFCdWAI5+HVfuRHVOKjZxW7XBZA+mdldbpU7bMAHF0Bh
         dtjv8FttUNmaGQHLnwE0TIrg1XIss9JVxI18f+BpJ5e/tkCb2vKUYAq8CJWUgHvzZTbG
         iuuitjn5XijvMaphrMTE5gKI4mRdA8/n2yiNBe/E4A6WoPbggMfFhPe2M/28SigrdsqM
         8mXOdEstEOndCJI48vvy2r6h64UsxdIUihHVx9LRSJGB7+uaa7rHJX6QMj5xgJiwU0iH
         6GrA==
X-Forwarded-Encrypted: i=1; AJvYcCU3SupFzbQ/YToFdhBOmgyv1vndPGc5Y16fMK+OSJlkWkgz9WmZ7XaC1tcYk99j3+pgZzpoyNNytLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd2DUAy1i8f8NRexILmTU75S1YlagXt2opv2Rn16+N0EQd8kOq
	CCmcc64WNQiXEe0WGGvBTd9ldLtV5a97/3qypSBEtRZ8FeLODhM6vGmzhaaxAsA1sns=
X-Gm-Gg: ASbGncvIVQeLBbAS8PWt+yPdNmcA7PadS8qtgLzlNf7V4Rt15Plgr8+mF0YUkz9yGVR
	ZMjYe7ICYOqlDybe1s1Nw1t1Su9y8j0B8PVVn4X/yHvclriRzd8+BB+C/WwdXCXcTQIzf0jZ0A+
	7JBj3N5G6Gcut3/IKxux5deCbjKiJ0ZIHeQqIJqMC8AF6L7TzFoCMwjG6ja0rri84RzEBXIWo++
	TnRqOKAN2J45JwhXbmxHg1An/cv2Wior/LylywVI4L0jdhh/A5GWKsqYdLfuI9ripp7aJ1UZ/Hn
	IiRdmYsQohCxEa1zcSNP6/5F9F4I7FSJZTTUAJkvKWAnEom+sCv5kUTovC8jeQ9ITYGLT5aj3T3
	vQx+64/EvFHuEER6iRyXDw2FLYB05zVXbtd+nEWEjYF2v
X-Google-Smtp-Source: AGHT+IGhaPJZ+pdATMOB6NLajxj8vfIMYMv1ysU2+urnfpp0W7ld7Wzhv8E3LNyQq7Dh1yAejCE0Jw==
X-Received: by 2002:a17:906:590e:b0:b45:420c:81c0 with SMTP id a640c23a62f3a-b46e8b83817mr361442566b.36.1759329071180;
        Wed, 01 Oct 2025 07:31:11 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b353efa4c35sm1379932466b.26.2025.10.01.07.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:31:10 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: [PATCH v10 0/4] can: m_can: Add am62 wakeup support
Date: Wed, 01 Oct 2025 16:30:18 +0200
Message-Id: <20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPo63WgC/4XSzWrDMAwA4FcpPs/DkhP/9LT3GDv4L6vZmnROm
 rWUvvvUdqNlBHwxyEafhKwTG1PJaWTr1YmVNOcxDz0FIJ5WLGxc/554jnTBUGADQlg+Dbsc+Da
 4nn+7j7Tf8XHYl5D4rDggNwGislaCj4YRsiupy4drhdc3ijd5nIZyvBac5eX2lwao0bPkglvdY
 tDQuAj44t3xM/uSnsOwZRd9bh7Ftio2JHbRUc+QtHNqQWwfRDRVsSVRyhSDcN4ptAuiuosI1YH
 SKTjIVgXd6UDNLoj6T2xFg/U56ovotbeggjVyaY7mLhpKqYmGRGU1OgMiKukXRPsgoqiKlkRBH
 yM7jDEq/U8831arpK897ex02y/m3Zg4vW/ztF716TDxaz2LljLOP4SzryDtAgAA
X-Change-ID: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931bd8
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vincent Mailhol <mailhol@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7474; i=msp@baylibre.com;
 h=from:subject:message-id; bh=FAsFqYeUZuQ31kGHakGP2ACf849Vb9hTBg2GPoJWZHw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoy71lwm2b8lLk8WKrhte4HZxOjv65htM46WLrGsXO/Am
 HRU/UR6RykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEwkS4nhN1uD1Tvvo9LF+s/O
 zNF/puf7qOlyianqvKD+sG69fwob1BgZ/pQEParT9rL6eXiW6duaXddX8hpq/ekxVVDiTzJe/am
 HGwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Hi,

This series adds support for wakeup capabilities to the m_can driver,
which is necessary for enabling Partial-IO functionality on am62, am62a,
and am62p SoCs. It implements the wake-on-lan interface for m_can
devices and handles the pinctrl states needed for wakeup functionality.

am62, am62a and am62p support Partial-IO, a low power system state in
which nearly everything is turned off except the pins of the CANUART
group. This group contains mcu_mcan0, mcu_mcan1, wkup_uart0 and
mcu_uart0 devices.

To support mcu_mcan0 and mcu_mcan1 wakeup for the mentioned SoCs, the
series introduces a notion of wake-on-lan for m_can. If the user decides
to enable wake-on-lan for a m_can device, the device is set to wakeup
enabled. A 'wakeup' pinctrl state is selected to enable wakeup flags for
the relevant pins. If wake-on-lan is disabled the default pinctrl is
selected.

Partial-IO Overview
------------------
Partial-IO is a low power system state in which nearly everything is
turned off except the pins of the CANUART group (mcu_mcan0, mcu_mcan1,
wkup_uart0 and mcu_uart0). These devices can trigger a wakeup of the
system on pin activity. Note that this does not resume the system as the
DDR is off as well. So this state can be considered a power-off state
with wakeup capabilities.

A documentation can also be found in section 6.2.4 in the TRM:
  https://www.ti.com/lit/pdf/spruiv7

Implementation Details
----------------------
The complete Partial-IO feature requires three coordinated series, each
handling a different aspect of the implementation:

1. This series (m_can driver): Implements device-specific wakeup
   functionality for m_can devices, allowing them to be set as wakeup
   sources.

2. Devicetree series: Defines system states and wakeup sources in the
   devicetree for am62, am62a and am62p.
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/am62-dt-partialio/v6.17?ref_type=heads

3. TI-SCI firmware series: Implements the firmware interface to enter
   Partial-IO mode when appropriate wakeup sources are enabled.
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/tisci-partialio/v6.17?ref_type=heads

Devicetree Bindings
-------------------
The wakeup-source property is used with references to
system-idle-states. This depends on the dt-schema pull request that adds
bindings for system-idle-states and updates the binding for
wakeup-source:
  https://github.com/devicetree-org/dt-schema/pull/150

This is merged now and upstream in dt-schema.

Testing
-------
A test branch is available here that includes all patches required to
test Partial-IO:

https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-partialio/v6.17?ref_type=heads

After enabling Wake-on-LAN the system can be powered off and will enter
the Partial-IO state in which it can be woken up by activity on the
specific pins:
    ethtool -s can0 wol p
    ethtool -s can1 wol p
    poweroff

I tested these patches on am62-lp-sk.

Best,
Markus

Previous versions:
 v1: https://lore.kernel.org/lkml/20240523075347.1282395-1-msp@baylibre.com/
 v2: https://lore.kernel.org/lkml/20240729074135.3850634-1-msp@baylibre.com/
 v3: https://lore.kernel.org/lkml/20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com
 v4: https://lore.kernel.org/r/20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com
 v5: https://lore.kernel.org/r/20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com
 v6: https://lore.kernel.org/r/20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com
 v7: https://lore.kernel.org/r/20250421-topic-mcan-wakeup-source-v6-12-v7-0-1b7b916c9832@baylibre.com
 v8: https://lore.kernel.org/r/20250812-topic-mcan-wakeup-source-v6-12-v8-0-6972a810d63b@baylibre.com
 v9: https://lore.kernel.org/r/20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com

Changes in v10:
 - Change dt-binding to be able to set pinctrl-names = "default", "wakeup";
 - Fix wording in the dt-binging
 - Fix mcan commit message to have correct naming of the SoC
 - Change function name from m_can_class_setup_optional_pinctrl() to
   m_can_class_parse_pinctrl()

Changes in v9:
 - Update the binding to accept the sleep pinctrl state which is
   already in use by other devicetrees
 - Modify suspend/resume to not set the sleep state if wakeup is enabled
   and a wakeup pinctrl state is present. If wakeup pinctrl is active
   this should be kept enabled even after suspend
 - Modify m_can_set_wol() to use pinctrl_pm_select_default_state() to
   get rid of the manually managed default pinctrl.

Changes in v8:
 - Rebase to v6.17-rc1

Changes in v7:
 - Separate this series from "firmware: ti_sci: Partial-IO support"
   again as was requested internally
 - All DT changes are now in their own series to avoid conflicts
 - wakeup-source definition in the m_can binding is now only an
   extension to the dt-schema binding and a pull request was created

Changes in v6:
 - Rebased to v6.13-rc1
 - After feedback of the other Partial-IO series, I updated this series
   and removed all use of regulator-related patches.
 - wakeup-source is now not only a boolean property but can also be a
   list of power states in which the device is wakeup capable.

Changes in v5:
 - Make the check of wol options nicer to read

Changes in v4:
 - Remove leftover testing code that always returned -EIO in a specific
 - Redesign pincontrol setup to be easier understandable and less nested
 - Fix missing parantheses around wol_enable expression
 - Remove | from binding description

Changes in v3:
 - Rebase to v6.12-rc1
 - Change 'wakeup-source' to only 'true'
 - Simplify m_can_set_wol by returning early on error
 - Add vio-suuply binding and handling of this optional property.
   vio-supply is used to reflect the SoC architecture and which power
   line powers the m_can unit. This is important as some units are
   powered in special low power modes.

Changes in v2:
 - Rebase to v6.11-rc1
 - Squash these two patches for the binding into one:
   dt-bindings: can: m_can: Add wakeup-source property
   dt-bindings: can: m_can: Add wakeup pinctrl state
 - Add error handling to multiple patches of the m_can driver
 - Add error handling in m_can_class_allocate_dev(). This also required
   to add a new patch to return error pointers from
   m_can_class_allocate_dev().

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
Markus Schneider-Pargmann (TI.com) (4):
      dt-bindings: can: m_can: Add wakeup properties
      can: m_can: Map WoL to device_set_wakeup_enable
      can: m_can: Return ERR_PTR on error in allocation
      can: m_can: Support pinctrl wakeup state

 .../devicetree/bindings/net/can/bosch,m_can.yaml   |  25 +++++
 drivers/net/can/m_can/m_can.c                      | 112 ++++++++++++++++++++-
 drivers/net/can/m_can/m_can.h                      |   3 +
 drivers/net/can/m_can/m_can_pci.c                  |   4 +-
 drivers/net/can/m_can/m_can_platform.c             |   4 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |   4 +-
 6 files changed, 141 insertions(+), 11 deletions(-)
---
base-commit: 24c4d4041c2ec11c47baf6ea54f9379cf88809fc
change-id: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931bd8

Best regards,
-- 
Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>


