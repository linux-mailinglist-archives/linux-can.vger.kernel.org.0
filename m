Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D953627068
	for <lists+linux-can@lfdr.de>; Sun, 13 Nov 2022 17:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiKMQTA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Nov 2022 11:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMQS7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2022 11:18:59 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B91E005
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 08:18:58 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id y203so8978620pfb.4
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 08:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elNcTLrMJni37jF8i5c9P85PeSk740xd1fFGGqlKTyg=;
        b=TFYcdftx2ZTYOb1VZsSzstLn31qsSlpDbtB4ZX/5+GGaVEpvtWXzXaDzuIrEFa4oN+
         XTZjedraEJfpqUOD7z6Onew18m7GStzAcxU6Z59O8zqXf4E+5y+4GUotiEu293CNQlvI
         AcMIoHOfw+GCpML74tyda0uAN6arG5VAfqPwj2SrstKR0Eq0FDmGu0lveJdNTL5ut4fr
         5bAWCba2wlMDrG00qgzvBFwgjA97Ul5tSd5c7rCFXjCXNQ+6ALJ+aA0LGPzhtJyz52yP
         ULIepQFfqhxEg/o4KQCtOTVO+M8Pwo/3zGKEt1JyR6BbwyS6xK/W6/73h3T8RLWaanH5
         pxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=elNcTLrMJni37jF8i5c9P85PeSk740xd1fFGGqlKTyg=;
        b=uGCEvAAh4o8Dg161Sbg+5mp/8pP0P14SyGGT9iaWrIwYppkhw3ymDc8dB7UrQHRR3z
         gAEmXPZqw925/f4ur7yVi2XZ0R55X/JvfpF/1Sji/eJV24S9hx4+92O43eN/6mKUCZMW
         K3TrwLCefVNYbSIrj5TwWyTdIaj+1ZIiCqKFeNNBQ4ft/aAT80c/X2gnxXLGXTYegp1U
         D5lHKgr5T+ozYAXXfVxDklpDt84afUCFUn2Hv/8TrhgP2FE1SL/kAotndU0NKKo92N+d
         AZONNV5m6xnHncrIW99+kuvtCcZRTjPknMcPFFxT+p1dIyZlkgkv+kXCfdar2iE8fvGF
         2YxQ==
X-Gm-Message-State: ANoB5pn/Gm5kp5YZrsKyhO7uaZ2jYRVEeSUaOOpkzlIwZHzlSBHLzSyN
        irRFNvUBTkfXlkhyT1gurpfyt8xTsjWUVw==
X-Google-Smtp-Source: AA0mqf5uD4V2cPTlBqeS3fXdVFkA0Wve2f07/375uUy3iXE/+csw/ZzIaPHurXh0ixTCoaIjwiz+Hg==
X-Received: by 2002:a63:3241:0:b0:470:4522:f32f with SMTP id y62-20020a633241000000b004704522f32fmr9150970pgy.114.1668356337690;
        Sun, 13 Nov 2022 08:18:57 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id 192-20020a6217c9000000b0056c04dee930sm4863558pfx.120.2022.11.13.08.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 08:18:57 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-utils-dev v2 0/5] can-utils-dev: a set of cleanup patches
Date:   Mon, 14 Nov 2022 01:18:26 +0900
Message-Id: <20221113161831.16388-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series contain five cleanup patches. There is no real relation
between each patch so I will end the cover letter here and let you
refer to the short description.

* Changelog *

v1 -> v2:

  * patch 2/5: add a note in commit message to explain that slcanpty.c
    debug is deactivated by default.

  * patch 2/5: make the compiler check the pr_debug() syntax even if
    debug is off.

  * reorder the patches so that the lib.c and the candump.c patches
    are next to each other in the series.

Vincent Mailhol (5):
  slcanpty: remove redundant asc2nibble()
  lib: add pr_debug() macro
  lib: snprintf_can_error_frame: print counter errors if CAN_ERR_CNT is
    set
  candump: add global variable progname
  candump: use linux/net_tstamp.h instead of redefining values ourselves

 Makefile                           |  2 ++
 canbusload.c                       |  9 ++---
 candump.c                          | 58 +++++++++++++-----------------
 canlogserver.c                     | 12 +++----
 lib.c                              |  4 +++
 lib.h                              |  7 ++++
 mcp251xfd/mcp251xfd-dev-coredump.c | 10 +-----
 slcanpty.c                         | 27 +++-----------
 8 files changed, 51 insertions(+), 78 deletions(-)

-- 
2.37.4

