Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD953917F9
	for <lists+linux-can@lfdr.de>; Wed, 26 May 2021 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhEZMxO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 May 2021 08:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbhEZMv0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 May 2021 08:51:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D27BC06134E
        for <linux-can@vger.kernel.org>; Wed, 26 May 2021 05:48:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o127so642151wmo.4
        for <linux-can@vger.kernel.org>; Wed, 26 May 2021 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Czs5kXwrH/tFZuPzkMfogPeQprDHVJKI3DJ0y1eHbPE=;
        b=1jA/H1XgsRz3Vxwx1aRDSih9XyNMMzO08j49RjBZYjuQdu3vzTXUS8dMiZGyGzBeiL
         ayHszn86KZCaGsR1iv5G0QAZaAOMICc2APki3OfD1dcaVq9HSnr97u836xR9zPLO7vNz
         46tpxPNMoRJq5c+pj74IRrClfD3Y/U0+9iOUpZXlyz5B7ETdoUqPWVU99mpDYoo+gXnp
         FuV/V8hUUXnVLY1OY8c+mTGH3X510PSwwDEnQh8q/Vfx7xbQ8ZXcLOxq7XYKO3ke2NDZ
         6JkJ+saOUdWRMrQVSoGM68OdPQ3qz1Ve9BpRE/lcPcCpuJbcyXCxoqu/0dwXKvM/ks7n
         umeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Czs5kXwrH/tFZuPzkMfogPeQprDHVJKI3DJ0y1eHbPE=;
        b=rPcbSTY2fHH5sNF+t/KjwEx+45YJufl64KdIq8K0gfWRwLjQtBgDbMJbEac1e3HRmo
         saqFC486qMfJOqxcBG8rYYn+InbtvVmDQae511fA6dcWceOAUdp9qQJwzyukpjlrn8/r
         /8KSydiCPdLtXtG4+aLd2fN3QgZTts+GKIED46YvuktPdLqN5z6chQQrnIeCU6WYzpeQ
         XDUEVPu3Ae4pQj4rMfSidVZMmvVOq+7CuwbZzzjgoog9nr7qmz8Mi9DAJNxtz9RIt/Jt
         +PpOj0NkQ4g9m7YwEJQaGi62OXWlV4L42trpxFA0sDRSMFy1Vc7G/hQFSsOyx3XSXamg
         +qVA==
X-Gm-Message-State: AOAM531l7DshPPauPnyFJxQyWnZcUmAQdO5JckbDO/CHoNbgvWJp1t0j
        JOueCMMwo+M2YD0PtPybEX/thd+xzjJqVQ==
X-Google-Smtp-Source: ABdhPJwyeqirgYZxA/+H3MJ1EyUUeD3X3mqCKm0WOQ1Eu54zSqIwffknhc26oPv3HVVIHVtkuJoUhQ==
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr3297567wma.39.1622033316975;
        Wed, 26 May 2021 05:48:36 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.155.threembb.co.uk. [92.41.10.155])
        by smtp.gmail.com with ESMTPSA id a4sm1864100wme.45.2021.05.26.05.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 05:48:36 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: [PATCH can-next 0/5] m_can, tcan4x5x: device-specific interrupt handling
Date:   Wed, 26 May 2021 13:47:42 +0100
Message-Id: <20210526124747.674055-1-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc and list,

This series is a follow-up to the RFC here:
  https://lore.kernel.org/linux-can/20210514121946.2344901-1-torin@maxiluxsystems.com/

In this series we enable M_CAN-based devices to implement their own
device-specific interrupt handling, and add such handling for tcan4x5x.

In 1, we replace the clear_interrupts() m_can_ops callback with
handle_interrupts(), which returns irqreturn_t and has an extra
parameter, clear_only, which is used if it isn't necessary to handle
device interrupts, only clear them.

In 2, we use the new infrastructure in m_can_isr(). If M_CAN core
interrupts are handled, we still only clear device interrupts.
Otherwise, we try to handle any pending device interrupts.

In 3-5, we clean up interrupt enabling and clearing in tcan4x5x, and
handle device interrupts appropriately. We specifically look for fatal
errors arising from transceiver or power, and SPI errors, which are not
necessarily fatal, but are dangerous!

TCAN4550 shutdown is attempted by setting the device into standby mode.
There is probably a better way, but I understand we are limited by being
in the ISR context.

The patches are based on linux-can-next/testing.

Torin Cooper-Bennun (5):
  can: m_can: ops: clear_interrupts -> handle_dev_interrupts
  can: m_can: m_can_isr(): handle device-specific interrupts
  can: tcan4x5x: tcan4x5x_clear_interrupts(): rm unnecessary reg clears
  can: tcan4x5x: only enable useful device interrupts
  can: tcan4x5x: implement handling of device interrupts

 drivers/net/can/m_can/m_can.c         | 21 +++++++----
 drivers/net/can/m_can/m_can.h         |  4 +-
 drivers/net/can/m_can/tcan4x5x-core.c | 71 ++++++++++++++++++++++++++++-------
 3 files changed, 75 insertions(+), 21 deletions(-)


