Return-Path: <linux-can+bounces-672-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEA08CCD59
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2024 09:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EBB282F20
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2024 07:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156E213CABD;
	Thu, 23 May 2024 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yBaEPaHv"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945A313CA8C
	for <linux-can@vger.kernel.org>; Thu, 23 May 2024 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450867; cv=none; b=ONmphVmYHVEEXiystwvudzpzSSfeb6fn7B6k6Kst7OXcRnUU7kmTsPVaomGN46b+PGUtDLN84qNgIq3ZaJboChM/Zu7Ij0fBoJHD96Esbsxbyx9ooxiRhae23TlM040wtySRd5I3yJLU52bUYGrxVu6ZkAkrYzXfW22dwPUDv7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450867; c=relaxed/simple;
	bh=6TUTSQLYTCUXIs3aeg91Rm5y9++WOvlHb8bfQgVmnOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yht7U5rMzlv7caFImyV+Xa1O1aCg0GVclhn7igAOuLNljwlTNGbmw3M0b0viSRPPhEFCdiJqOGQz7LcSBziTfjZ6G2say0l7zSGoUecJMIVPm/+uRTcHp2DOBWdvDy7cJokuL3peAZRAr+pTlg7PbUuFRNcY1yU4VL5fhl5dnw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yBaEPaHv; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e564cad1f6so104704441fa.1
        for <linux-can@vger.kernel.org>; Thu, 23 May 2024 00:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716450863; x=1717055663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NO+7TP5WD33s7UxZDGhnr50qHmYrw+DG3n3RuvKTKAk=;
        b=yBaEPaHvMhb6JhqKTT7NICNmNkBb7AcJDdinIQxt+Wje26d/lB74llcw+xJ14oGq7Y
         ouXflFjtN89OI5+MsRnSXoLZeIeBGLMA/IwU1pNP1Tt3rGGrry9WgiLr59WZDgWBTxzs
         oEA1aQddfbDiSMHJNNbg5YbOzAxjwmtKCvqU8eEHX+rLJUws4au4BtmPpe4QXOkYlraH
         V1vckaPyMShn6cGqZD9DzzVxiVZgCTtftqhnSzXOVp/SEFVpZFUIbdjx7lKYko2NKHwY
         KQyBKvoS7LrmFvis3zY5OnNaWQaEHz3I+NBCrI8YGy+JWg4O/no0cLyR3mSgy+rq5feb
         c3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716450863; x=1717055663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NO+7TP5WD33s7UxZDGhnr50qHmYrw+DG3n3RuvKTKAk=;
        b=ovhak4weVSw3TiVB/eQfcIbaV5+gxFe3C4WQdQD3xaPbYCoky5fmOPOip+Qw82ZAMC
         ZFdPs65ivh7m7Q2zqOkjcK6DUOoO9s435tVuKwucqse4yDYYTRGyNUs8a+3x1bYPKLH7
         VzzhAsjJKHpv3hCUD2PBsTSo/x4L9hXj08YWZhikvB2UlAp/FlybVxg3gkqM8d4XFK0U
         bMUhkThOa4BM65Jo7dcqf0GtfzN+KrBMDPvoo9fiQ4PfdXNDr2U8/lL4N9nh8B2agbem
         oeixwBQm023ZPKCnr2lZdZV2IqiRMA4Dbi/EU/AzE+DYVWf1ft5nigxCVhrJNr+9Pov1
         7NkA==
X-Forwarded-Encrypted: i=1; AJvYcCVcgP/O8n5gPBJc1gL2iMvmtwoj09sE+3aJwtFDRzjPEcXLvKmZBnhkrOkZmDBtT/6dMXM3fdCLnT2ZOfV8ZJtNkjvDb3XIwIZc
X-Gm-Message-State: AOJu0YzeO6O3N/xSAK/jw157VW9aaiEmhXSadbJcV8IO1ManLKWzo1Kj
	1Mkr9xt/3O+lC17UAh8jUI06oH9+23HCYoJnczXG8RqKLZSiSErAADHhNZqP0Qw=
X-Google-Smtp-Source: AGHT+IG1TPrM5IWcLsL0gQR7Oe9oP76a2EOliWzZVJoOaGxGy+vZJRo/X57iPhY+5O8GnBw4G2JH9A==
X-Received: by 2002:a2e:874c:0:b0:2e7:2907:a63b with SMTP id 38308e7fff4ca-2e94946e2bfmr26921751fa.21.1716450862499;
        Thu, 23 May 2024 00:54:22 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad074sm36501833f8f.70.2024.05.23.00.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:54:22 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 0/7] can: m_can: Add am62 wakeup support
Date: Thu, 23 May 2024 09:53:40 +0200
Message-ID: <20240523075347.1282395-1-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

am62, am62a and am62p support Partial-IO, a poweroff SoC state with a
few pin groups being active for wakeup.

To support mcu_mcan0 and mcu_mcan1 wakeup for the mentioned SoCs, the
series introduces a notion of wake-on-lan for m_can. If the user decides
to enable wake-on-lan for a m_can device, the device is set to wakeup
enabled. A 'wakeup' pinctrl state is selected to enable wakeup flags for
the relevant pins. If wake-on-lan is disabled the default pinctrl is
selected.

It is based on v6.9-rc1.

This series is part of a bigger topic to support Partial-IO on am62,
am62a and am62p. Partial-IO is a poweroff state in which some pins are
able to wakeup the SoC. In detail MCU m_can and two serial port pins can
trigger the wakeup.

These two other series are relevant for the support of Partial-IO:

 - firmware: ti_sci: Partial-IO support
 - serial: 8250: omap: Add am62 wakeup support

A test branch is available here that includes all patches required to
test Partial-IO:

https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-lp-sk-partialio/v6.9?ref_type=heads

After enabling Wake-on-LAN the system can be powered off and will enter
the Partial-IO state in which it can be woken up by activity on the
specific pins:
    ethtool -s can0 wol p
    ethtool -s can1 wol p
    poweroff

I tested these patches on am62-lp-sk.

Best,
Markus

Markus Schneider-Pargmann (6):
  dt-bindings: can: m_can: Add wakeup-source property
  dt-bindings: can: m_can: Add wakeup pinctrl state
  can: m_can: Map WoL to device_set_wakeup_enable
  can: m_can: Support pinctrl wakeup state
  arm64: dts: ti: k3-am62: Mark mcu_mcan0/1 as wakeup-source
  arm64: dts: ti: k3-am62a-mcu: Mark mcu_mcan0/1 as wakeup-source

Vibhore Vardhan (1):
  arm64: dts: ti: k3-am62p-mcu: Mark mcu_mcan0/1 as wakeup-source

 .../bindings/net/can/bosch,m_can.yaml         | 20 +++++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi       |  2 +
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi      |  2 +
 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi      |  2 +
 drivers/net/can/m_can/m_can.c                 | 43 +++++++++++++++++++
 drivers/net/can/m_can/m_can.h                 |  4 ++
 6 files changed, 73 insertions(+)

-- 
2.43.0


