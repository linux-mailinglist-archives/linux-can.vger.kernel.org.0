Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E294372975
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 13:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhEDLPN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 07:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhEDLPM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 07:15:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81083C061574
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 04:14:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n2so8980958wrm.0
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 04:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ROpy9k41eP0rxCyIgW0tXyqsGXM1y0T6TDfKZjhlbW0=;
        b=ELrMfNW4P5M5gozxhiqNHsrtKwEclH/meET7aCYoQvRJY+B6+NZSKvZqYKIsL9hvqf
         clECZU6Lb/PPyKK3CQVnGuTTN19XD36X4FTd2hH9HC1N6PKLEgIvLKjZbM2gJl3y6GlD
         7k3zA4cPq5jURqhmR1/YYCOMxB4bfQSTH6aDnPb5tjQTK/fzUqrxUW5BUNFB8garQQb4
         MU6PhXnBXmzt9aWUcYIf8kD7+3MIDw5j5r93IPJRP4umAI8ZOksHuTi1+1plEFQdfqr0
         kxqB04DM5385Z7c0aK9fJQZha2fJWSY4imvv6MZYsCJu5chyrQGme79LwlOItT8Gfwbm
         +mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ROpy9k41eP0rxCyIgW0tXyqsGXM1y0T6TDfKZjhlbW0=;
        b=bHT3QX0QezbT3wBDJA+PiBoJWvci2KdG2+guYM7MF+vYDB2NuCb8FOpY1aPazvjfbM
         Vl6F4lmh/GXThNKCN7zKq4ANqgDztNkUs+vXK2yzz74kP8OWaIZOOLCUf4eNoT1OTrt4
         TtgL3VvgcvIljUgfM487QAeBOvt8kIWI3SsSFo+QYUBS9CSX8PT8tpb+zKOqJ0vBk3/R
         b/7vFQDagFxzcEI0PpGFgAYqN4SDKP//eoQPPGA37bMbv/HdILvlBvXbQowaUxDo+3hl
         NiTCls63uceOJ4ssg3sALBgpUwmo40i10+5A5E35U6VNlzh3kUslCCHfvGLV8otEyMah
         HduQ==
X-Gm-Message-State: AOAM5308u3glYz26CO8H3fpioeI3TBpHfxt06zolO4PCG5SdeqjRMWHw
        /N/JPXtQ4fXEQlzGOeQQgA/1xpGgZZFsu2L/
X-Google-Smtp-Source: ABdhPJzXEL9NJes4ZxtlFv6hpm0mbEPeLD9fs4FHhngbCYBKHexAyd0e0OKpnzABe4MSNhT3+CQCGw==
X-Received: by 2002:adf:8b02:: with SMTP id n2mr30295616wra.259.1620126855981;
        Tue, 04 May 2021 04:14:15 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id l14sm15927735wrv.94.2021.05.04.04.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:14:15 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Pankaj Sharma <pankj.sharma@samsung.com>
Subject: [PATCH 0/4] can: m_can: various regmask-related cleanup
Date:   Tue,  4 May 2021 12:13:53 +0100
Message-Id: <20210504111356.336259-1-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Dear all,

The first patch modernises m_can.c to use the proper masking macros
provided in bits.h (namely GENMASK, FIELD_{GET,PREP,MAX}) to make the
M_CAN driver more maintainable and readable.

We then clean up the CCCR regmask definitions, to make the differences
between M_CAN spec revisions clearer.

TX and RX buffer size configuration is made more explicit, rather than
just writing 0x777 to a register to set all buffer sizes to 64 bytes.

Finally, minor whitespace edits to a few comments.

Cheers,

Torin
maxiluxsystems.com


