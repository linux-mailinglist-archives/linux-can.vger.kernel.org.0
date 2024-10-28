Return-Path: <linux-can+bounces-1806-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B7C9B37CF
	for <lists+linux-can@lfdr.de>; Mon, 28 Oct 2024 18:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E01B7B20C9D
	for <lists+linux-can@lfdr.de>; Mon, 28 Oct 2024 17:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E891DF73D;
	Mon, 28 Oct 2024 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iftEwOQP"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D001DE8BC
	for <linux-can@vger.kernel.org>; Mon, 28 Oct 2024 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137223; cv=none; b=g766CQsocJOukhXl5mhEJlkNv7XcKAx6hw8tiC8n1MjhKzdZjaSVlbVeyYTaPoO7WVMre//UWAXfMNgl1c5ihdtZtn5qH9EclS7eaSqJec0l4+EmUgXWV6x7BjEbaIfDDXoA31PWIEmAmnbt1IJBXSdLcX4eIl3b5Xsjgv0kuoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137223; c=relaxed/simple;
	bh=PjmzZrky7c9XHiIloWKYccp5bYvY8EkYK6R8+nR4g8A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LcI6P494l2xchOGakMwwhoy7U21+irG2jZNct9BCU2vmXwnYzCpcDqh1Ed4toOyGCoPnwjETXE6eofYrAObvxnMnoYYais9pDFBFtc+lRJXp+8NStvBcPc+XPow5gdv2L9wCUBQisFIJxSDDd79hr4kvqqyIpdoN4aJXIZ4nU/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iftEwOQP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431695fa98bso44748875e9.3
        for <linux-can@vger.kernel.org>; Mon, 28 Oct 2024 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730137219; x=1730742019; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+24tbWmwYqjI0PixvLwCG5KaQzbdJT94obj/v2TLFYw=;
        b=iftEwOQPmfpp1sAIEhT51rV2Sfh1xe04uvb/ca//6tWKoAlssfSgXTcgdYPiPklstQ
         B+wbapJAY1/wX9urD2+Yfk+slITcezsZ5NmQirOH1YzInaIk3dHvNiWl4+feZAx9XteM
         Y5gVQWMXcl50PAcfUEQeOv65/FUixVTGCRsPdQdWTnHQ92ns0pEgTpEm5THG8rP7srIk
         O5hte5vvSuMjjsKVyCYsUc5GHtnWn6ibmeSUKCfk0ZqWkKEddwnd2NR0v5+xHtYaWydi
         jG3LfxJZnNfrC/6aTm6eHrLKDq9BTvoTbeUrgdqLGXqLxZNKS94Qi1VP+sTi0jm6ULHt
         B4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730137219; x=1730742019;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+24tbWmwYqjI0PixvLwCG5KaQzbdJT94obj/v2TLFYw=;
        b=u+41NwuGJXFrL6tqlW1yLt8An1JCxzrhb/lJ6kwV33zz6uRDda/c3WRaNCrUV2pUCI
         pNV4cM+4ten3MLZFU/TG1AwHqx7+1IYGjjLgQlAiiBDiia/jcnl0qVGL9Uga9ZmRB3TY
         mpcmzAm67qjOhYng5QzKXLZkAzrTc7TxZdxQvRFwqwKvNTChjhztTEqFHwxaKZP+InYA
         ODecoSxInaKVVXnqaAvrxGvNWKtPZQLKVkSY2eIPqCYjeopwfzM+Xm14aJWEbN8ZgBnz
         JaHIX7dFwhL8/PB+h/Y0NN/0HCPgNOu0BLUwDY3Zyz2tsLAnzY98AUW1QCEqbCDwD6wX
         4Vog==
X-Gm-Message-State: AOJu0YxhK1j1ie63n2IZ7t5DDGXdN6VrBK3MPEp15cRSFjACSVcz30/F
	Hx6IIsNq2mf8JAF9HoNfrugkVdwzeoQCsy3tnnRlqPIv4x5mBy6RwZm9Lzmu1vURrD3afvdWQgK
	F
X-Google-Smtp-Source: AGHT+IFE550FE2Nqygic/ljdueXDXIsWvxFQ/MLExhS5Kk1L7VSfa17/mmDjKm+s/AppiBgP1SXRCQ==
X-Received: by 2002:adf:cc8f:0:b0:37d:52b5:451e with SMTP id ffacd0b85a97d-3806118aa34mr6936830f8f.33.1730137218641;
        Mon, 28 Oct 2024 10:40:18 -0700 (PDT)
Received: from localhost ([2001:4091:a245:81f4:340d:1a9d:1fa6:531f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f744esm117408815e9.34.2024.10.28.10.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:40:18 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v5 0/9] can: m_can: Add am62 wakeup support
Date: Mon, 28 Oct 2024 18:38:06 +0100
Message-Id: <20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP7LH2cC/4XOTQ6CMBCG4auQrh3DlH9X3sO4KO0gjUpJC1VCu
 LuFuDBuWL6zeL6ZmSOrybFTNDNLXjttuhDZIWKyFd2NQKvQjMc8xTiuYDC9lvCUooOXuNPYgzO
 jlQQ+B+RQSlR5VSVYq5IFpLfU6Pc2cLmGbrUbjJ22PZ+s1y+NuEf7BGKoiozLAlOhkJ9rMT10b
 ekozZOtuk9/xWxXTIPYKBF+RiqEyP/EZVk+aKLTGSEBAAA=
X-Change-ID: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931bd8
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4574; i=msp@baylibre.com;
 h=from:subject:message-id; bh=PjmzZrky7c9XHiIloWKYccp5bYvY8EkYK6R8+nR4g8A=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNLlz3i1l97ltzN8+evMnOe3jCZNSGpdPbW6yWxf9o0tH
 rf657aadZSyMIhxMMiKKbLc/bDwXZ3c9QUR6x45wsxhZQIZwsDFKQATSc1h+O/LpDzV/p6y3/GN
 GW97zrY3nD+2aPPzKF+hJ4cjEnX4tDYzMnzpX3WNkzP8dNu9DdJ28rmFNzYE3VjNeatsHa/u3ZT
 aPgYA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Hi,

Series
------
am62, am62a and am62p support Partial-IO, a poweroff SoC state with a
few pin groups being active for wakeup.

To support mcu_mcan0 and mcu_mcan1 wakeup for the mentioned SoCs, the
series introduces a notion of wake-on-lan for m_can. If the user decides
to enable wake-on-lan for a m_can device, the device is set to wakeup
enabled. A 'wakeup' pinctrl state is selected to enable wakeup flags for
the relevant pins. If wake-on-lan is disabled the default pinctrl is
selected.

It is based on v6.12-rc1.

Partial-IO
----------
This series is part of a bigger topic to support Partial-IO on am62,
am62a and am62p. Partial-IO is a poweroff state in which some pins are
able to wakeup the SoC. In detail MCU m_can and two serial port pins can
trigger the wakeup.
A documentation can also be found in section 6.2.4 in the TRM:
  https://www.ti.com/lit/pdf/spruiv7

This other series is relevant for the support of Partial-IO:

 - firmware: ti_sci: Partial-IO support
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/am62-partialio/v6.12?ref_type=heads

Testing
-------
A test branch is available here that includes all patches required to
test Partial-IO:

https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62/v6.12?ref_type=heads

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

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
Markus Schneider-Pargmann (8):
      dt-bindings: can: m_can: Add wakeup properties
      dt-bindings: can: m_can: Add vio-supply
      can: m_can: Map WoL to device_set_wakeup_enable
      can: m_can: Return ERR_PTR on error in allocation
      can: m_can: Support pinctrl wakeup state
      can: m_can: Add use of optional regulator
      arm64: dts: ti: k3-am62: Mark mcu_mcan0/1 as wakeup-source
      arm64: dts: ti: k3-am62a-mcu: Mark mcu_mcan0/1 as wakeup-source

Vibhore Vardhan (1):
      arm64: dts: ti: k3-am62p-mcu: Mark mcu_mcan0/1 as wakeup-source

 .../devicetree/bindings/net/can/bosch,m_can.yaml   |  22 ++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi            |   2 +
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi           |   2 +
 .../boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi     |   2 +
 drivers/net/can/m_can/m_can.c                      | 117 ++++++++++++++++++++-
 drivers/net/can/m_can/m_can.h                      |   4 +
 drivers/net/can/m_can/m_can_pci.c                  |   4 +-
 drivers/net/can/m_can/m_can_platform.c             |   4 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |   4 +-
 9 files changed, 152 insertions(+), 9 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241009-topic-mcan-wakeup-source-v6-12-8c1d69931bd8

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>


