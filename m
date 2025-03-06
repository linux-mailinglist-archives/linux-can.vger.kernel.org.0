Return-Path: <linux-can+bounces-2987-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0F4A548E0
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 12:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C7E1894C81
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 11:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06476209F2A;
	Thu,  6 Mar 2025 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2ALoJCRw"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D291FC7CC
	for <linux-can@vger.kernel.org>; Thu,  6 Mar 2025 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259760; cv=none; b=hrWuZDg/JHdB2bJAn9aGQJE4ezbpHHWu5yNk7HmIkVsgsn7F5LD2XWHhx5crgbZHtNHyVo/PkaS4+25SuAa4q2x3RGMIBuo8EJSE/D+YooA7MVu4GBnSWs3KguZhkwxxo3VfrLL+HE/g3M+urP92Csp2FSVzKdX5cmBz5gIbor4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259760; c=relaxed/simple;
	bh=YevAipZm/+lyAcJ9AjGTXmRxKhKQj/5yvsZrO88ZVtA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PliTtvP1ciqvTmZXtPCpNetcXcl28tYliG0S464ZzJXXNPtj4/bXR5n6Cw1f3OuCEAS9ZbykQKI7KSI49wyfSxyGMH91BMZ8Em4aZLphwvE8o2ffyx4cq982S9e9vlCXJNST6FEpim2K+hZvyFSKj1ImxjbGgVfjFnxlfRGTEbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2ALoJCRw; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso792497a12.3
        for <linux-can@vger.kernel.org>; Thu, 06 Mar 2025 03:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741259755; x=1741864555; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWLJq7ftyKy37p7zHFjkyk8VxM1La8FbGatFxYaxm+o=;
        b=2ALoJCRw60pO6EnooOS0RR8MD6KUgp+vfENCNjHrrEWFAiBKPCO3k/lK0tjVmIUqpq
         YTlSyaFjsddYMMKbZqhfU0ZRQ6VDcmhOuJYc2vxWP3cCGArla/NhBkSVo7Mh383Zr4SN
         tZ+f3pukr36g2jkIl+ojPPc+zCxpYCWH2mW5w5Zh2HFAKFUXnv24ftQaE60139rDnUNf
         gZsJSyUfaETm5o+t5+9Ujr8QpJcYQ1EfOBdVrscweFi9b7zR1uTmrs8BxhA0Rmh7ODy2
         gUB0PpSL/X7Fvg/fK0BvHvax8c/tgkki4qJnrERF2cU/Ce8x28m57y8uBMv7E76Iexe6
         WuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259755; x=1741864555;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWLJq7ftyKy37p7zHFjkyk8VxM1La8FbGatFxYaxm+o=;
        b=EV9bw7rnqBzo4A+9DQ4HBYlrAQawyehSnLR1ag/w9V5oip9BpQ0GGK0IQwWEHGrB6+
         4clWTN24/H1rMmv05JAGeSYMkjGz5HR5SCyHmV7zCBHsXP40RWFWMlC0k3FkknEcNPdD
         +FDTkBWUBUcZ3+Itm+W/xeJf41ScXD/qCGs6OF4UbS4Tmc60Np1xYMn5gyvVROZ0IBA1
         SN7Uj9ha9Vx9Ito9n9ngmcMwTtCpYNeHNeBDB2tkKeTMtnS0oWiyvCjl3ClcBriA3+Re
         gdkhDZt3x/nrL4coC3wS/eRPMAsYW0aY9x65Oj+j7KHwYvMGsgXQAZA/eNAPEacFyqDi
         A0jw==
X-Forwarded-Encrypted: i=1; AJvYcCUYobhg/EKNMamaiwghRoLoPWI6EtO7iF0zwKp4I0tbRXZKG0RxmpZJKDqBUby85NjZnVkpM2JNjfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwacY9ea2RefjR1Rf69yCKyNem5NSzBG65jmifaEuCEdZoyNlut
	QrppfWFiLI2ANW05dIaeENENTYRGaujkOugiELiXUQvrV3cA0JDme4IriUOCBxo=
X-Gm-Gg: ASbGnctkuEQKhvYSb9ljzNXp1wtJG/xh+Qihl3rIDWqSYB33T1XDDOGMnJwry6Ri3BA
	0N/+iY14mIsgQm2HcltLhB4IuYsDMFGLBr5UdC+ISEj971Y8ub3nCJhbV4z/Zi0DGj9dR6mBtm5
	l7gZYPGZw4hY9P05KQtYbTK0xKzIsddapdDe1wPVkZeaxo9IBSUDLlXryio1pye4LnkL51PgnuR
	ms27NznznBrw11q+HRU1JaSHfNBT0h/2KrqE02eEeh+SDWYG54EGllBmuBTvXqAvwykJgdX50Kx
	khWBfza85SG8e8L40dPeOtlRN6Fiv2SVe+Je9dUjYw==
X-Google-Smtp-Source: AGHT+IHSKv/iLY4xG1FTSXhFmi2aztkk4M5rcVMuXstlVjF4Qr5KDJ4BrcjybmmrVGWo69K5HXyYQQ==
X-Received: by 2002:a05:6402:5110:b0:5e5:c1fd:bf56 with SMTP id 4fb4d7f45d1cf-5e5c1fdc40amr2678822a12.26.1741259755275;
        Thu, 06 Mar 2025 03:15:55 -0800 (PST)
Received: from localhost ([2001:4091:a245:8327:80ad:8144:3b07:4679])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e5c7472100sm793530a12.27.2025.03.06.03.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:15:54 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v5 00/13] firmware: ti_sci: Partial-IO support
Date: Thu, 06 Mar 2025 12:14:38 +0100
Message-Id: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ6DyWcC/4XOQQ6CMBCF4auYrh3TllrQlfcwLto6yCRAsWAjI
 dzdoiYmLnT5ZvH9M7EeA2HP9quJBYzUk2/T2K5XzFWmvSDQOW0muVSC8wIG35ED02gJnQkDmZo
 8RA1CglXgZJ6V1jilVM6S0QUs6f70j6fXDni9pczwOVbUDz6Mzx9itlzfuWT+zsUMOJS500t3p
 wtxsGasyQbcON+wBY/qA0qx+weqBApnCzT2rHiOX+A8zw/mfljsMwEAAA==
X-Change-ID: 20241008-topic-am62-partialio-v6-12-b4-c273fbac4447
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Kendall Willis <k-willis@ti.com>, 
 linux-can@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7677; i=msp@baylibre.com;
 h=from:subject:message-id; bh=YevAipZm/+lyAcJ9AjGTXmRxKhKQj/5yvsZrO88ZVtA=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJPNq88dqfCad2hSYcKoqKzxa1//vJjVhd9eKYs8C3b0
 bTmqZoSHaUsDGIcDLJiiix3Pyx8Vyd3fUHEukeOMHNYmUCGMHBxCsBE9FMY/gemnDrY/llP1nOu
 yfIJDAuPxlZ0qOstiHQy1EwIjOzWVGL4H8xiaPcycWb85CeLwt5W7DR/67J+1ekm640PHvcFxK3
 aygwA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Hi,

up to last series, the Partial-IO support consisted of two independent
series. As this last rework introduced file-based conflicts, I merged
the mcan series introducing wakeup support into this series:

  can: m_can: Add am62 wakeup support
  https://lore.kernel.org/lkml/20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com/

Series
------
The series contains three parts:
 - m_can support for Partial-IO, in particular 'wakeup' pinctrl support.
 - ti_sci support for Partial-IO, which checks wakeup-sources if they
   are enabled for Partial-IO
 - DT description of system states on am62, am62a, am62p and the
   enabling of wakeup support on the starter kits that support it.

The series is based on v6.14-rc1.

Partial-IO
----------
Partial-IO is a low power system state in which nearly everything is
turned off except the pins of the CANUART group. CANUART contains the
mcu_mcan0, mcu_mcan1, wkup_uart0 and mcu_uart0 devices. These can
trigger a wakeup of the system on pin activity. Note that this does not
resume the system as the DDR is off as well. So this state can be
considered a power-off state with wakeup capabilities.

The wakeup capability of a device is described in the devicetree with
the wakeup-source property. This can hold phandles to system states in
which the device is capable of wakeup. Additionally a WKUP_EN flag is
set in the pinctrl of devices that are wakeup enabled.

On poweroff ti_sci checks if potential wakeup-sources for Partial-IO are
wakeup-enabled by the user. If that is the case, the poweroff is done
by TI_SCI by sending a PREPARE_SLEEP message with a specific mode. Once
sent the system will poweroff apart from the CANUART pins.

Dependencies
------------
This series requires an updated DT binding for the wakeup-source
property that allows the use of system-states which are also being added
in this pullrequest:
 - dt-schema wakeup-source binding update
   https://github.com/devicetree-org/dt-schema/pull/150

Testing
-------
After enabling Wake-on-LAN the system can be powered off and will enter
the Partial-IO state in which it can be woken up by activity on the
specific pins:
    ethtool -s can0 wol p
    ethtool -s can1 wol p
    poweroff

These patches are tested on am62-lp-sk on linux-next.

Best,
Markus

Previous versions "firmware: ti_sci: Partial-IO support":
 v1: https://lore.kernel.org/lkml/20240523080225.1288617-1-msp@baylibre.com/
 v2: https://lore.kernel.org/lkml/20240729080101.3859701-1-msp@baylibre.com/
 v3: https://lore.kernel.org/r/20241012-topic-am62-partialio-v6-13-b4-v3-0-f7c6c2739681@baylibre.com
 v4: https://lore.kernel.org/r/20241219-topic-am62-partialio-v6-12-b4-v4-0-1cb8eabd407e@baylibre.com

Previous versions "can: m_can: Add am62 wakeup support":
 v1: https://lore.kernel.org/lkml/20240523075347.1282395-1-msp@baylibre.com/
 v2: https://lore.kernel.org/lkml/20240729074135.3850634-1-msp@baylibre.com/
 v3: https://lore.kernel.org/lkml/20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com
 v4: https://lore.kernel.org/r/20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com
 v5: https://lore.kernel.org/r/20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com
 v6: https://lore.kernel.org/r/20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com

Changes in v5:
 - Rebased to v6.14-rc1
 - Merged m_can and ti_sci series to avoid conflicts and show
   dependencies more easily
 - Added definitions of system-states for am62/am62a/am62p
 - Moved wakeup-source definitions into board dts files as they require
   a bit of support on the board.
 - Updated ti_sci support to walk through the wakeup-source phandle
   lists
 - Added pinctrl settings for mcu_mcan0/1 on all boards
 - Minor style updates for ti_sci support for transfers without response
 - Update and move the dt-binding for wakeup-source from the m_can
   binding to the dt-schema repository

Changes in v4:
 - Rebased to v6.13-rc1
 - Removed all regulator related structures from patches and implemented
   the wakeup-source property use instead.

Changes in v3:
 - Remove other modes declared for PREPARE_SLEEP as they probably won't
   ever be used in upstream.
 - Replace the wait loop after sending PREPARE_SLEEP with msleep and do
   an emergency_restart if it exits
 - Remove uarts from DT wakeup sources
 - Split no response handling in ti_sci_do_xfer() into a separate patch
   and use goto instead of if ()
 - Remove DT binding parital-io-wakeup-sources. Instead I am modeling
   the devices that are in the relevant group that are powered during
   Partial-IO with the power supplies that are externally provided to
   the SoC. In this case they are provided through 'vddshv_canuart'. All
   devices using this regulator can be considered a potential wakeup
   source if they are wakeup capable and wakeup enabled.
 - Added devicetree patches adding vcc_3v3_sys regulator and
   vddshv_canuart for am62-lp-sk
 - Add pinctrl entries for am62-lp-sk to add WKUP_EN for mcu_mcan0 and
   mcu_mcan1

Changes in v2:
 - Rebase to v6.11-rc1
 - dt-binding:
    - Update commit message
    - Add more verbose description of the new binding for a better
      explanation.
 - ti_sci driver:
    - Combine ti_sci_do_send() into ti_sci_do_xfer and only wait on a
      response if a flag is set.
    - On failure to enter Partial-IO, do emergency_restart()
    - Add comments
    - Fix small things

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
Markus Schneider-Pargmann (13):
      firmware: ti_sci: Support transfers without response
      firmware: ti_sci: Partial-IO support
      dt-bindings: can: m_can: Add wakeup properties
      can: m_can: Map WoL to device_set_wakeup_enable
      can: m_can: Return ERR_PTR on error in allocation
      can: m_can: Support pinctrl wakeup state
      arm64: dts: ti: k3-pinctrl: Add WKUP_EN flag
      arm64: dts: ti: k3-am62: Define possible system states
      arm64: dts: ti: k3-am62a: Define possible system states
      arm64: dts: ti: k3-am62p: Define possible system states
      arm64: dts: ti: k3-am62-lp-sk: Set wakeup-source system-states
      arm64: dts: ti: k3-am62a7-sk: Set wakeup-source system-states
      arm64: dts: ti: k3-am62p5-sk: Set wakeup-source system-states

 .../devicetree/bindings/net/can/bosch,m_can.yaml   |  18 +++
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts           |  60 +++++++++
 arch/arm64/boot/dts/ti/k3-am62.dtsi                |  22 ++++
 arch/arm64/boot/dts/ti/k3-am62a.dtsi               |  27 +++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts            |  76 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p.dtsi               |  27 +++++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts            |  76 ++++++++++++
 arch/arm64/boot/dts/ti/k3-pinctrl.h                |   2 +
 drivers/firmware/ti_sci.c                          | 134 ++++++++++++++++++++-
 drivers/firmware/ti_sci.h                          |   5 +
 drivers/net/can/m_can/m_can.c                      | 111 ++++++++++++++++-
 drivers/net/can/m_can/m_can.h                      |   4 +
 drivers/net/can/m_can/m_can_pci.c                  |   4 +-
 drivers/net/can/m_can/m_can_platform.c             |   4 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |   4 +-
 15 files changed, 562 insertions(+), 12 deletions(-)
---
base-commit: 7ec162622e66a4ff886f8f28712ea1b13069e1aa
change-id: 20241008-topic-am62-partialio-v6-12-b4-c273fbac4447

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>


