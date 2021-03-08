Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6B8330B14
	for <lists+linux-can@lfdr.de>; Mon,  8 Mar 2021 11:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhCHK2t (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 8 Mar 2021 05:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhCHK2n (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 Mar 2021 05:28:43 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6C6C06174A
        for <linux-can@vger.kernel.org>; Mon,  8 Mar 2021 02:28:42 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id i9so5666234wml.0
        for <linux-can@vger.kernel.org>; Mon, 08 Mar 2021 02:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OwtJs97mEPki8AulyYu0pUS1gYtdgWgh/Bxu8+Jl0X4=;
        b=jCUIS+cVyZjXxkXv888qoybubvdI1RHut8aLYUtb4hmGXhxvPZicWUU8MPrcRsH64U
         83qzb9Qrn2W39zNl1IC8qbRfcYEDY86FZKMBugC1Ezoxc3DxlIavKHNjk7YRwYmOsgn+
         /2rRm3dU9EK/TZwAe218EMCAYCnMX2lp0X+0z9iEUDpPIGufQnQDKagSqWwlUsiAg/Vu
         JKgni7q1/uwzVHu696KrsAA4F1nKZ5RCPxIywW99FBUnkndcUdl1xFvmpjykxmWIbAa1
         FDNewLTrir0679U08Rpq5xmA+4wSwjCDbPUB4u0Ugzgpcu2sFNEDvQ8LxII8rIi7MMim
         kNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OwtJs97mEPki8AulyYu0pUS1gYtdgWgh/Bxu8+Jl0X4=;
        b=D9ziLZ9G0/0OD7AqLYWguLtPaQ95d5kNBceGL6XHQ8qRD821lgeBT1I6HXHdAtM27Y
         bTIb5rl7XqwAcI97mAMMBZgNxS/GkinvNGP5+lpMEVb/Sc9UJLwNzdG+3imV0PKnj5P7
         4LXJrnihdyIjTJidn17Xp9KorjtP3AylPPi5nw71/YuYVYo5lhCvbnedE61PG48EZSdb
         jFBWWMoGq3RYjhOD3a/bZsU6UPUmgZy93WJrsnsNdmoWA4RWvkfm9SYx5dbgHYyueP9X
         pIqwUxrvJmIhX9QYeL38QKDAWifm7HyXPDd6pFbsAzRO+1VK3vgvOAZQ9eTqKajTg1Wj
         W22Q==
X-Gm-Message-State: AOAM530smQ3daawVobUZu3Jaem12xwjT6vac2BSnOQuQpxNZz9ViI3Bp
        0cQdGnaPB3USi6MaYQ0BnUquqHYl3DE4eOlZ
X-Google-Smtp-Source: ABdhPJwXw16R0/0Zb5TYH4bVkbV/+HlWaKrnKqtkumSH3eRwxKdcR+jbh6PjZRLJFgUTiP7nCuB3Wg==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr21699220wmq.143.1615199320954;
        Mon, 08 Mar 2021 02:28:40 -0800 (PST)
Received: from localhost.localdomain (92.41.6.207.threembb.co.uk. [92.41.6.207])
        by smtp.gmail.com with ESMTPSA id i17sm6416455wrp.77.2021.03.08.02.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 02:28:40 -0800 (PST)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Pankaj Sharma <pankj.sharma@samsung.com>
Subject: [PATCH v2 0/3] can: m_can: stabilise peripheral m_can RX and TX
Date:   Mon,  8 Mar 2021 10:24:25 +0000
Message-Id: <20210308102427.63916-1-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In this patch series, rx-offload is utilised in the m_can driver,
instead of sending skbs directly from a threaded IRQ using
netif_receive_skb() (which is meant to be called only from a softirq
context). This should fix the major stability problems with M_CAN
peripherals (tcan4x5x being the only practical example at the moment).

I have tested this with a Raspberry Pi 3 Model B and a TCAN4550. The
driver no longer crashes outright, and TX works consistently and echoes
correctly. RX is also much more stable, but I think more testing is
required with different hardware to really ensure stability.

There is definitely at least one outstanding issue. In my tests, if the
TCAN4550 encounters bus activity immediately after init, such that RX
FIFO 0 is already full by the time the IRQ handler is first called, then
in the initial round of RX polling, the frames are apparently read out
empty (DLC = 0, ID = 0). After this point, RX works as expected. I
assume there's a data race hidden in the init process somewhere, but I
have failed to find it!

On my hardware setup, I still have occasional incorrectly-read-out
frames (e.g. DLC wrong, or the odd 4 data bytes reading 0), but I am yet
to rule out SPI signal problems, nor Raspberry Pi SPI hardware problems.
In any case, these problems existed in my setup before this patch
series.

I would be grateful if someone were able to test these changes with a
different hardware setup, and also with non-peripheral M_CAN.

Many thanks,
Torin

----- Version changelog -----

v2
 - Use GENMASK, FIELD_PREP, FIELD_GET for new bitmasks
 - Retain existing skb handling for non-peripheral M_CAN as it already
   uses napi for RX
 - Add timestamp param to m_can_tx_update_stats


