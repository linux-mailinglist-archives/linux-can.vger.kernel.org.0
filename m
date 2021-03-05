Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820EF32F10B
	for <lists+linux-can@lfdr.de>; Fri,  5 Mar 2021 18:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhCERVu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Mar 2021 12:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCERVb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Mar 2021 12:21:31 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CD1C061574
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 09:21:30 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id h7so2121307wmf.3
        for <linux-can@vger.kernel.org>; Fri, 05 Mar 2021 09:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bA3sZ1iKiwFXADJLE0E7x4c/ocdTjI73bvH5osutgeg=;
        b=TpTFFBN6Ma72eNvwu7JHkDLnvofxnnhS7fN9mjYhhk3MlKfNepjHt/e5BsdkQ60oAI
         vz8gGe5IH2B/MX2WPcAGNguTArlE58zGIi7bwKHxL6/zP5B+qnJhlcVCTRXTwwRnsczy
         SfhG4oqk0GXdNs4qZog6Y4LXeAos4VYknzejw0ziFq2SKVbugTbBlwAUPrICIu7XqtEj
         RLsy4rAzwc7SpGwXVHpzTeHsHcSMBrrQxa4zcXY5yzLrPRJUleBGc8af0xSW8PDh/gZM
         tN1Pvk+F1g9jK/mZnuX0XTThfPvh9DvnKb2T2HOyTMI38V8bcXQiSHbxYkNdtlJT9frl
         t3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bA3sZ1iKiwFXADJLE0E7x4c/ocdTjI73bvH5osutgeg=;
        b=r4f3+mxLZ5g6uhv3RypLYiQGIhdJpaS+4D5w3lvk5rbq0lzF/DO2hGlmT87hmCEpK8
         AooEw9pN8FofAwWjuCpst12bzOP4dmuU2UhmuoJUrRDCjrkeLAwm8mpuecKGhhX02QAu
         wQf6VJjLJ8/wQbNFEUKu/1Hht/2bZVf576l5C/SKb9/2ZgrHBmAkxNFMOHbmLsHbygvF
         gC/y3jtwWhDzMccfWLIYviWdqMgB7/I8tIoywsIo+r5+49lczcNt0gUe/Yy/V0VEy1w7
         MqFAP9OtYHelYbTbOeTxT2OxN9z27Pjc4IXLV4l8wKg9nvAkWr1pGBimliiQo5/mLBbZ
         wWZA==
X-Gm-Message-State: AOAM533IkiO4z0N9gqaWnfvaoDUPArBSDKuc1Vw3HvWmedQZ8s06g5lA
        zWdSdZA/0d3ifLBq3At1jhu5z+yOlHinLQ==
X-Google-Smtp-Source: ABdhPJwx96Way9M+Glt8uj6enbuIUJAQjlDe3DF1VoDXFo6UFGPBscI+zVSbTTaJZDQMGYq2NoTjjg==
X-Received: by 2002:a1c:1fc6:: with SMTP id f189mr10038826wmf.68.1614964889312;
        Fri, 05 Mar 2021 09:21:29 -0800 (PST)
Received: from localhost.localdomain ([185.69.145.254])
        by smtp.gmail.com with ESMTPSA id c9sm5174926wmb.33.2021.03.05.09.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:21:29 -0800 (PST)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Pankaj Sharma <pankj.sharma@samsung.com>
Subject: [PATCH 0/3] can: m_can: stabilise peripheral m_can RX and TX
Date:   Fri,  5 Mar 2021 17:20:12 +0000
Message-Id: <20210305172015.1506525-1-torin@maxiluxsystems.com>
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



