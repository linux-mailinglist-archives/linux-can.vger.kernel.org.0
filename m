Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058F7380954
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 14:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbhENMVI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 08:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbhENMVH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 08:21:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EEBC061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 05:19:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z17so10784638wrq.7
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 05:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCb8FyGw2lWvgk+xaJVfFoG1iF6XXMqJFH77tKjhdg0=;
        b=gTApXJnTy8Fv1ol4EDNx6i2jX4pOB25t+RiroHQc7jeyAshP2oQ5iIhzZKSj5jlWbT
         hBndQrfv/wbLW5GzwO3o0v9o1RbScjr73G5WL2l5oEKqOXyUuQYZqiOY9ysqkBMgBK7l
         heu2cIOXz3qFPviO2P3JFnCpPVHLFfWV636vVf/kSyYlv66f2ilW1Pz8LbE4jP7F8FQI
         M4h5xAaYO67bQDg0Ox7R9ZRTo84olsqlZ/sa5rGT9A9t40Xw0Wby1ZiJTMXWaBt7NJQU
         DS6DfSk27SJV87y2/N4PFQ73ND14g5PP6ekgTlrwo6iWFk4q1eVbGtU9zTrgCJpJPSvm
         0/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCb8FyGw2lWvgk+xaJVfFoG1iF6XXMqJFH77tKjhdg0=;
        b=WPPN+GAAUbQDHuiV0tTHTDrqn6dt+TEoHzbpgssrZFhNAkXi7ZKrJ09e6mWZA7C10N
         qWyyv/5zAnjh2Zw6YLhgRcPfCfQCee/U7iMUwBdzbJCb3dG4MnczBhTts6mIKMaim0hx
         RxyEdgKGotqitOShVZpEa09ApV3BvI6VL6W2A09jtBGRM/bjhIExJ/yyIpSjJhmp3zuU
         RbB/GEZIuLiT2Kv24w2KM685sIHatIC2Jz055+EGeQfTRroT+q2VBJvyPTJTCtZYtreI
         h7wuXMCUzM3MzQRtQ6uED8EGTpWz4LYIhomIBw3/fr6p50Rs5p1dObZDNZdPU/2OZ1nQ
         Yqsg==
X-Gm-Message-State: AOAM531WY4kXUwBCgiHTOGYr+V4lPDTsNuzH5kJg3ToKwaEAkHap65WG
        k2nk5iFUOK726cGdh+IDl2PXG5EW8AwW+w==
X-Google-Smtp-Source: ABdhPJxTsPG39D6CwDy8YaX/02VoUF4hfqI8rPGGEfHWQVs2J369wxW4/VqyGdCg9IIDjXwpfVhJ9g==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr5781440wrq.93.1620994794932;
        Fri, 14 May 2021 05:19:54 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.182.threembb.co.uk. [92.41.10.182])
        by smtp.gmail.com with ESMTPSA id r11sm15103wrp.46.2021.05.14.05.19.54
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:19:54 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Subject: [PATCH RFC can-next 0/3] m_can: support device-specific interrupt handling
Date:   Fri, 14 May 2021 13:19:43 +0100
Message-Id: <20210514121946.2344901-1-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Using the TCAN4550, I've had occasions where the m_can driver has fallen
over with the "nobody cared" message -- the ISR has returned IRQ_NONE
upon "99,900 of the previous 100,000 interrupts" (see
kernel/irq/spurious.c, __report_bad_irq()).

While such high numbers certainly indicate some kind of fault,
presently, device-specific interrupts are totally ignored -- it may be
that such a fault can be handled with a device-specific action.

Comments are welcome. One thing right off the bat: I'm not sure whether
the new callback should be added alongside clear_interrupts, or if it
should replace it.

I also need to replicate the fault observed with the TCAN4550 - it's
unlikely that the handling added in this patchset is effective by
itself.

Torin Cooper-Bennun (3):
  can: m_can: add handle_dev_interrupts callback to m_can_ops
  can: m_can: m_can_isr(): handle device-specific interrupts
  can: tcan4x5x: add handle_dev_interrupts callback to ops

 drivers/net/can/m_can/m_can.c         | 13 ++++++++++++-
 drivers/net/can/m_can/m_can.h         |  2 ++
 drivers/net/can/m_can/tcan4x5x-core.c | 25 +++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)


