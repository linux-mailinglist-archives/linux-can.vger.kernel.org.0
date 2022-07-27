Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A245824C8
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiG0Kt4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiG0Ktz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:49:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D2624F1B
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:49:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id jw17so3627750pjb.0
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWjB9iF8rHOEFcJ2OnG7dNmI0fvRfT27N3aQO0XcniE=;
        b=HSHLgxZE6RrYqfcdKJQzIqTF047sdTp/dWQPPAkmhxjEwtRUfNY3NOabOFrFHDW0da
         GzCHNQodwG2gsW8NZg06an9Wu63ssqRrZktcYsRqQXmH6zfTMxe/GKyNfnZ1x4UVBJXy
         CnBmxVOjc4oSQmeV+v8T7qf1IqU8nkMMyHt1HTBpE9dj7GGlLaIRFQjdegCSKa9//t4c
         n2cOlLs/79QXkaLnWbB1IAGfRibTVV8Y7pqJt3JowhwV3SloYHXG33trHBEB3nNDnuaY
         p7Ome5NYLg5ESbhcV6xAJ/HN8WR2d29jNgRQFDkFhclgB5INZjqx5BeECk7b8173uyM3
         7WYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=nWjB9iF8rHOEFcJ2OnG7dNmI0fvRfT27N3aQO0XcniE=;
        b=y8+YMs975Qg/6Go1xuIwdyTiSgGC+fLe3LV4c1AQF9AvDwSjhXYJIQVrnc/b7CZreR
         qpVtmNZo9DFzJopRtU04fwTkuRkxbBE7xDTq/ZnnaQZHDHs5BNMgdIuO8GEKt/zrjqDd
         cqByUPgPqlKq6T/N/7iCQSz1ALkmZQWsPO69TTZ6tLZ60TH8KsAXRwfPd6T4C+7wY+Ed
         6e0n53RcRwfrEDma47R11ehQXP55ht8TbKk7BiDasHIGv2krQuWDOtYkpYrKU1q5NaK6
         avDAR93M4piQeNuwfZiUJDQy1Hx2hq3QUykaSnBztxNOUw6vuBXgVP2bF0NZGwz/VdLQ
         wXwg==
X-Gm-Message-State: AJIora8PDm2VARPJlPcl6gWXzAEsKmrad6bGfDemz3AydsbNpp/OWMjg
        JYXzZp9a3uhD8MD3MXFG50hAh+XgVes=
X-Google-Smtp-Source: AGRyM1uZCRCIwxEm1rF95o5hKDwmVoJ6qSEVlUE0cukVh4IwxAPCDxrPRP2Bxp4XKhJcGfMa1MEGSg==
X-Received: by 2002:a17:902:d58c:b0:16c:fdb7:86e9 with SMTP id k12-20020a170902d58c00b0016cfdb786e9mr21251664plh.74.1658918993344;
        Wed, 27 Jul 2022 03:49:53 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id o19-20020aa79793000000b00525343b5047sm13526114pfp.76.2022.07.27.03.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:49:52 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 0/3] can: export export slcan_ethtool_ops and remove setter functions
Date:   Wed, 27 Jul 2022 19:49:36 +0900
Message-Id: <20220727104939.279022-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The c_can, flexcan and slcan use a setter function to populate
net_device::ethtool_ops. Using a setter here add one additional
function call and add some small bloat in the object file. Exporting
the structure allow to remove this setter.

The mcp251xfd uses a similar pattern except that it does some
additional initialization. As such, this driver is left untouched.


* Statistics *

For the slcan driver, this patch reduces the object file by 14 bytes
(details in the first patch). Although we did not conduct a benchmark
for the other drivers but we expect the exact same figures.


Vincent Mailhol (3):
  can: slcan: export slcan_ethtool_ops and remove
    slcan_set_ethtool_ops()
  can: c_can: export c_can_ethtool_ops and remove
    c_can_set_ethtool_ops()
  can: flexcan: export flexcan_ethtool_ops and remove
    flexcan_set_ethtool_ops()

 drivers/net/can/c_can/c_can.h             | 2 +-
 drivers/net/can/c_can/c_can_ethtool.c     | 7 +------
 drivers/net/can/c_can/c_can_main.c        | 2 +-
 drivers/net/can/flexcan/flexcan-core.c    | 2 +-
 drivers/net/can/flexcan/flexcan-ethtool.c | 7 +------
 drivers/net/can/flexcan/flexcan.h         | 2 +-
 drivers/net/can/slcan/slcan-core.c        | 2 +-
 drivers/net/can/slcan/slcan-ethtool.c     | 7 +------
 drivers/net/can/slcan/slcan.h             | 3 ++-
 9 files changed, 10 insertions(+), 24 deletions(-)

-- 
2.35.1

