Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B96626E97
	for <lists+linux-can@lfdr.de>; Sun, 13 Nov 2022 09:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiKMIxi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 13 Nov 2022 03:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiKMIxg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 13 Nov 2022 03:53:36 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74D82BC3
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 00:53:32 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id b62so7871929pgc.0
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 00:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ixdVuBr5zEDmq+mrDo6cWwg4EBSM6LXV3GjPeN74VNk=;
        b=gCP2JoubeZGbmUIl9cVQ4Wwc/wb9F6suFUrrPLMKhRww3cOF0vS3WwE6sJfJTroJHF
         W4hnqtWongwFBYUHXuqi5aRVzy2hy3UL0zSowBb4RLvWgU48+CcdB0YDNviunU0ie/KK
         YMHTWHeVmypM1Jj2UJ9i72AdfSgaROfrpOUVzHIEUX+aP26+4yU547sf/1RNBzMhnPjl
         CdKa0BL2Dn5taCBqjcqMGUK3Y5TalPVO+BfxRx2/k/t6+rE+AwbmAdHFu6DMEBKYTTFF
         njvaQLD5lvTHzlDUFBvbaEqScpFdRc0WPk+UWK7Nm1JGfNItnKhBDSxed0EJTJp4KCOA
         eS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixdVuBr5zEDmq+mrDo6cWwg4EBSM6LXV3GjPeN74VNk=;
        b=i/FDekQRAd0EJnbUeNZskGdQoZiKuxcm+90VK0JqDe2Pj3LUzK8VoJ5wkfhfdcSKNF
         /h1cc7ME46YMpMX6M2OkyHmr6UtWbMmUQQBC0yCqGV1JwJqUcOvOpPTModNmJCSVL9Uu
         Yue5D7FEy+/Kh1ZI1jo55mvcH3AWQpe1gUoL2/si4zlCopgHy3f5SrrIN6lxwfWX3S4a
         bY+Q7SD9fHrLlKWXDvEsj/JfnOR0TWk+5KPPURKriRuVWFi2r611lKn7lm5SCB5eScJp
         R6BuRCEHnT4aKU4hor0s91Ehw6Rd1gUVyJkX7g+punCK9oSQnzDpsJs/lPZb/cvOmJCf
         j9Yg==
X-Gm-Message-State: ANoB5pkbMgn2p63JV6BUegopzqHkusWjR5BNVB7Q/3xzJJ4VyAIwGFx2
        2Ps8JrR3EIuZIUwQ7+5EduO1DOugOVVJ2Q==
X-Google-Smtp-Source: AA0mqf5y/2EMnCHI3wC1TKhuaB8IBDU3tAdNUp8u0gwaesB2adOkgH74KwzixYYcOr2pSloe9HqacA==
X-Received: by 2002:a63:d143:0:b0:45c:5a74:9a92 with SMTP id c3-20020a63d143000000b0045c5a749a92mr8022405pgj.473.1668329611940;
        Sun, 13 Nov 2022 00:53:31 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y1-20020a626401000000b00528a097aeffsm4372391pfb.118.2022.11.13.00.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 00:53:31 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH can-utils-dev 0/5] can-utils-dev: a set of cleanup patches
Date:   Sun, 13 Nov 2022 17:53:16 +0900
Message-Id: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
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

Vincent Mailhol (5):
  slcanpty: remove redundant asc2nibble()
  lib: add pr_debug() macro
  candump: add global variable progname
  candump: use linux/net_tstamp.h instead of redefining values ourselves
  lib: snprintf_can_error_frame: print counter errors if CAN_ERR_CNT is
    set

 Makefile                           |  2 ++
 canbusload.c                       |  9 ++---
 candump.c                          | 58 +++++++++++++-----------------
 canlogserver.c                     | 12 +++----
 lib.c                              |  4 +++
 lib.h                              |  6 ++++
 mcp251xfd/mcp251xfd-dev-coredump.c | 10 +-----
 slcanpty.c                         | 27 +++-----------
 8 files changed, 50 insertions(+), 78 deletions(-)

-- 
2.37.4

