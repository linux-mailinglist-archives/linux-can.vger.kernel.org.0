Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A2E1F4F5B
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2020 09:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgFJHo5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 Jun 2020 03:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgFJHo5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 Jun 2020 03:44:57 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8920AC03E96F
        for <linux-can@vger.kernel.org>; Wed, 10 Jun 2020 00:44:55 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d10so620352pgn.4
        for <linux-can@vger.kernel.org>; Wed, 10 Jun 2020 00:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3N8ySBXCAGSToWzkhjg9Ns1STm80jOJIgncP/xxN3eY=;
        b=xoSGSnf+KLwKshKMBjlYrdmyp9I/mKgs/ehf+r0czh6W2sBdz19OUpRNf2jQNbZ8eI
         XkpysDx8EabZpnTU0HzEI/WZZPkbYy6KjWFQPNuGSlDBhar4Rim+IjgczRpmssPjGaFq
         5q+EEIbBcHSXNKMOCUpXLtEVG1qvGo9eU766WhzeR7aL/XssyIVigCIRHKMCWPBiOhr4
         JfdZ8qF3+/t9Gt3fAM9CmfdZYsK7qNR0xNu9WCYztpKPmUxdeoiZWjekG5yH7MTzKmP/
         dwSSvI89/7/RxJqGYOFBW9hIxiwSogU/vjrni1TdE7bcElzLght6o7xpzpwUEl+hEVk6
         D16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3N8ySBXCAGSToWzkhjg9Ns1STm80jOJIgncP/xxN3eY=;
        b=RWTFTVrE9j8fIcvSteVRZ3q6+l0R1qL0Fh8FbmSduCUncRZpa550iNiw5hCMlGi3bQ
         b3AmaQ0un/EmXJo78/Kf0sWYxEcn1fkyGxZkNpxxEEHeWW21s1BSI4XZvB0Dgfp9TM+E
         I5T57sw+5nce/Vd1ttrT0qvAe+ISJruKhCDXMKFgfRrXiDoRo8KbM3WlQzs8i2QrQuC9
         DAsKAuc08jE0yqE0E28Lk2Hgt0l+e3+GgpageDvuwYV+Yczl2xO4gCQKT8qXqHzMPsTP
         rIfhlAlWlKncWGw4gO0ZxJY3YnaMovyVHhADpftJFojp7op+7YNErKwQpxVwtXOQmlsq
         NKjw==
X-Gm-Message-State: AOAM53141NjfRimkPOzYG6eCXfkbSkaxmsBnHoBzwIASZmIheZnL2lBW
        pjyQnptN2YzPlHZBwoFy8+bCv4rBAw==
X-Google-Smtp-Source: ABdhPJzoYmIM8knPdWEYW86S20yr4Ag0e99GnUnirnhqSIY4sncQXGP46ZktYkt2XLetXnM3Hw3f9w==
X-Received: by 2002:aa7:859a:: with SMTP id w26mr1547654pfn.10.1591775094260;
        Wed, 10 Jun 2020 00:44:54 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:630f:1dba:c41:a14e:6586:388a])
        by smtp.gmail.com with ESMTPSA id a20sm11516795pff.147.2020.06.10.00.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 00:44:53 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wg@grandegger.com, mkl@pengutronix.de
Cc:     kernel@martin.sperl.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/6] Add Microchip MCP25XXFD CAN driver
Date:   Wed, 10 Jun 2020 13:14:36 +0530
Message-Id: <20200610074442.10808-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

This series adds CAN network driver support for Microchip MCP25XXFD CAN
Controller with MCP2517FD as the target controller version. This series is
mostly inspired (or taken) from the previous iterations posted by Martin Sperl.
I've trimmed down the parts which are not necessary for the initial version
to ease review. Still the series is relatively huge but I hope to get some
reviews (post -rcX ofc!).

Link to the origial series posted by Martin:
https://www.spinics.net/lists/devicetree/msg284462.html

I've not changed the functionality much but done some considerable amount of
cleanups and also preserved the authorship of Martin for all the patches he has
posted earlier. This series has been tested on 96Boards RB3 platform by myself
and Martin has tested the previous version on Rpi3 with external MCP2517FD
controller.

Thanks,
Mani

Manivannan Sadhasivam (1):
  MAINTAINERS: Add entry for Microchip MCP25XXFD CAN network driver

Martin Sperl (5):
  dt-bindings: can: Document devicetree bindings for MCP25XXFD
  can: mcp25xxfd: Add Microchip MCP25XXFD CAN-FD driver infrastructure
  can: mcp25xxfd: Add support for CAN reception
  can: mcp25xxfd: Add CAN transmission support
  can: mcp25xxfd: Optimize TEF read by avoiding unnecessary SPI
    transfers

 .../bindings/net/can/microchip,mcp25xxfd.yaml |  82 +++
 MAINTAINERS                                   |   8 +
 drivers/net/can/spi/Kconfig                   |   2 +
 drivers/net/can/spi/Makefile                  |   2 +
 drivers/net/can/spi/mcp25xxfd/Kconfig         |   5 +
 drivers/net/can/spi/mcp25xxfd/Makefile        |  11 +
 .../net/can/spi/mcp25xxfd/mcp25xxfd_base.c    | 177 +++++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_base.h    |  14 +
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c | 538 ++++++++++++++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.h |  52 ++
 .../can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c    | 305 ++++++++
 .../can/spi/mcp25xxfd/mcp25xxfd_can_fifo.h    |  16 +
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_id.h  |  69 ++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c | 674 ++++++++++++++++++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_int.h |  18 +
 .../can/spi/mcp25xxfd/mcp25xxfd_can_priv.h    | 144 ++++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_rx.c  | 233 ++++++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_rx.h  |  18 +
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c  | 653 +++++++++++++++++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.h  |  86 +++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_cmd.c | 226 ++++++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_cmd.h |  84 +++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_crc.c |  31 +
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_crc.h |  15 +
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_ecc.c |  74 ++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_ecc.h |  16 +
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_int.c |  71 ++
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_int.h |  15 +
 .../net/can/spi/mcp25xxfd/mcp25xxfd_priv.h    |  50 ++
 .../net/can/spi/mcp25xxfd/mcp25xxfd_regs.h    | 661 +++++++++++++++++
 30 files changed, 4350 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
 create mode 100644 drivers/net/can/spi/mcp25xxfd/Kconfig
 create mode 100644 drivers/net/can/spi/mcp25xxfd/Makefile
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_base.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_base.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_fifo.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_id.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_priv.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_rx.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_rx.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_tx.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_cmd.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_cmd.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_crc.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_crc.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_ecc.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_ecc.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_int.c
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_int.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_priv.h
 create mode 100644 drivers/net/can/spi/mcp25xxfd/mcp25xxfd_regs.h

-- 
2.17.1

