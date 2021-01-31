Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42546309AD5
	for <lists+linux-can@lfdr.de>; Sun, 31 Jan 2021 07:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhAaGXS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 31 Jan 2021 01:23:18 -0500
Received: from mail-yb1-f170.google.com ([209.85.219.170]:38893 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhAaGXN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 31 Jan 2021 01:23:13 -0500
Received: by mail-yb1-f170.google.com with SMTP id i6so7093824ybq.5
        for <linux-can@vger.kernel.org>; Sat, 30 Jan 2021 22:22:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=n7EIXkLZv/X5oQxwJG8viHYhY7qWY6jWtsVHF69ah0U=;
        b=a26MoMAJXo3pRK25P1uCnCvdnFItiPZRz+Zna3W+rsJbL8+WpyW42NNgpg7RURNhmd
         wFkZGyBWL8fydGLuRa0FQCp0cYo5IksybSyzgfFNaT1yW9dhjlkrujia2yLupLV3HPCT
         smLTIAb1t8sAY+BVLSW+k/VCnWtNeMNV0UzbSBlEXRq9b111KsYlEBd30SYM4L8bE2Zc
         Zu/NX8lrDe04Ch1TaMZqcebhX2XdX6x2V/YFltyBdgLMmg+iAMUfm2Y8z9QkvZf6YZyj
         nFdhYvnfgYYSUSTaHuXbIwInsOF6JDBQfKNskDm6s9I5KsQiyYlFFqXO39wfXxeDtN9q
         T3Jw==
X-Gm-Message-State: AOAM533W1VJfszYgtDu9Vr5YNpYnNCxM7tSRLskCftHyc+Y/TLzYeqj1
        H6sN97LM+p2lnFyP4k7T1DtL4sG/XIHg63mshTYYWE+ct8kiHg==
X-Google-Smtp-Source: ABdhPJw+2yw6aEEeTbprC+DGzAJ/vWt/GFfHscwmar+yYcYxEJX7RV27LELYe+O7tiS9lYLJxmbkw/yXBuV8gx1KlUw=
X-Received: by 2002:a25:84cc:: with SMTP id x12mr176749ybm.487.1612074152044;
 Sat, 30 Jan 2021 22:22:32 -0800 (PST)
MIME-Version: 1.0
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 31 Jan 2021 15:22:21 +0900
Message-ID: <CAMZ6RqK0rTNg3u3mBpZOoY51jLZ-et-J01tY6-+mWsM4meVw-A@mail.gmail.com>
Subject: [Question] Sending CAN error frames
To:     linux-can <linux-can@vger.kernel.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Jimmy Assarsson <extja@kvaser.com>,
        Christer Beskow <chbe@kvaser.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

The socket CAN API handles the CAN errors (as reported by the
microcontroller) by emitting some RX CAN frames with the
CAN_ERR_FLAG set.

My question concerns the transmission path: I would like to
understand how drivers should handle *TX* CAN frames which have
the CAN_ERR_FLAG set.

The socket API allows sending such frames. For example doing:
    cansend can0 20000123#0011223344556677
will generate such frames and it will reach the xmit() function of
the driver.

However, contrary to the other flags (EFF, RTR, FDF, BRS), the
ERR flag is not present on the data link layer. Instead, the data
link layer is responsible for detecting errors and signaling those
as soon as they occur (thus interrupting the transmission).

While the ISO standard does not explicitly forbid having upper
layers generating such frames, it is not documented. Also, I am
not aware of CAN controllers allowing to generate error frames on
demand.

My initial expectation is that those error frames only make
sense in the RX path and that we should drop such TX frames in,
for example, can_dropped_invalid_skb().

However, after looking at the code of other drivers, it appears
that one (and only one) of them: the Kvaser hydra, does actually
check this CAN_ERR_FLAG flag in the TX path:
https://elixir.bootlin.com/linux/v5.11-rc5/source/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c#L1421

I would be thankful if anyone knowledgeable about the Kvaser hydra
could explain to me how the device handles those error frames.

Also, please comment if you are aware of any use cases for TX
error frames.


Yours sincerely,
Vincent
