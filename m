Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D412064429C
	for <lists+linux-can@lfdr.de>; Tue,  6 Dec 2022 12:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbiLFL5l (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Dec 2022 06:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbiLFL5j (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Dec 2022 06:57:39 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7459E5FFE
        for <linux-can@vger.kernel.org>; Tue,  6 Dec 2022 03:57:37 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vp12so5582230ejc.8
        for <linux-can@vger.kernel.org>; Tue, 06 Dec 2022 03:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jN+SaF+zuxoUU81Nw24j+GhxhXHvVPtH9udHI+xrnjQ=;
        b=xTaTf2TBlJ0riAw3zVxcG64JhSxN9FcWFLIMmcX0wofkLtWC5FsleYIdwiEITwJ+Gv
         5Gei4HbvI6mEjtas3s5gFhjtdqKbB1Tf5+ZGEYVZihdtxMtgiLvqJsc5ulBwo7bLbZLw
         b2z+jFz/E+92taEGUrEehphYCmDlGCCmcMXmnQ5EST2xzIGI/VxEPqr2HqzNk6Ij2GP/
         lJPM8fuD0Renq0iiUZGQkeAnJzA+zZRKSFZZibmnfJeQlObM+lnmUPuM8v7crfCV+lxy
         pA00CBqGy759uIBV3CwywMBK3fZxakGrBpmilUsBbc7Tbh0f75UJOXxRK99JTrZ+/y20
         Hxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jN+SaF+zuxoUU81Nw24j+GhxhXHvVPtH9udHI+xrnjQ=;
        b=osglGkHnLX/rol+vNiHly9eNjvqsn8aRuTPvOr3U+E8Llzxvzz4Ybj9HFbxbKsz3xK
         ByY/CAbK0Do5e4UM4saY+Z86HSahZICLW8GaLQNaZ8uVThuu8bQkANZPKQYhjJuUfmHT
         AYX2vC+XYZY9NUBr1qqI8S00xYRG5YddxLh4D14MclkKvGXwVjA1dGnbga211wIkLzUE
         4dWTBTN6CiXvnFnLruLjx7MB+61n5p1d//bkDQI0qYzLwRff1M3vGL5AKFz27xM+d9DT
         HwgWewidjNFPzkmS8rfGOEML5H6OzhnjBCiykBQ3S4ZQV8PQxlnM2HzwWk0LZbbxiMQb
         XX0w==
X-Gm-Message-State: ANoB5pmSkvIPo0pMm64/gqFXqQXx/yZ8kuuwCUcSf3XgoygBHwF7ag/Q
        x9EOP0GFzFp0MLB3KzYGT25A8IcPJzqkHpsM
X-Google-Smtp-Source: AA0mqf4c4rvYDO6ZyFGDQehYMtvpEw9FwaavKBWmmlL1SnkiTa/RhiNiU//LHE7chlPl7o1++LsYEg==
X-Received: by 2002:a17:906:960f:b0:7c1:133a:37bd with SMTP id s15-20020a170906960f00b007c1133a37bdmr788393ejx.470.1670327855730;
        Tue, 06 Dec 2022 03:57:35 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:8713:84e4:2a9e:cbe8])
        by smtp.gmail.com with ESMTPSA id ky20-20020a170907779400b007c0ac4e6b6esm6472076ejc.143.2022.12.06.03.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 03:57:35 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 00/11] can: m_can: Optimizations for tcan and peripheral chips
Date:   Tue,  6 Dec 2022 12:57:17 +0100
Message-Id: <20221206115728.1056014-1-msp@baylibre.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc and everyone,

as requested I split the series into two parts. This is the first parts
with simple improvements to reduce the number of SPI transfers. The
second part will be the rest with coalescing support and more complex
optimizations.

Changes in v2:
- Fixed register ranges
- Added fixes: tag for two patches

Sorry that I am one day later than promised.

Best,
Markus

Markus Schneider-Pargmann (11):
  can: m_can: Eliminate double read of TXFQS in tx_handler
  can: m_can: Avoid reading irqstatus twice
  can: m_can: Read register PSR only on error
  can: m_can: Count TXE FIFO getidx in the driver
  can: m_can: Count read getindex in the driver
  can: m_can: Batch acknowledge transmit events
  can: m_can: Batch acknowledge rx fifo
  can: tcan4x5x: Remove invalid write in clear_interrupts
  can: tcan4x5x: Fix use of register error status mask
  can: tcan4x5x: Fix register range of first two blocks
  can: tcan4x5x: Specify separate read/write ranges

 drivers/net/can/m_can/m_can.c           | 90 +++++++++++++++----------
 drivers/net/can/m_can/tcan4x5x-core.c   | 19 ++----
 drivers/net/can/m_can/tcan4x5x-regmap.c | 47 ++++++++++---
 3 files changed, 100 insertions(+), 56 deletions(-)


base-commit: 76dcd734eca23168cb008912c0f69ff408905235
-- 
2.38.1

