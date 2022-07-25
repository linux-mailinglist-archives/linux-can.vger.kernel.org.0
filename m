Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C4F5801E6
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiGYPcH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiGYPcG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:32:06 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF13F60D2
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:05 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id w185so10771867pfb.4
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qmNpx/g8eOAMrYIIi7Ajy8VOql5zyhopFdJO0Vy6qRA=;
        b=Zs9O10iMJMMxF7AWPlYE7Ja0aA7TjS27DU/n7N296RDa2Q5gxQQRpecSJEEV/a2MFJ
         5yy1YFGMeTBUCKfhIA30wCnP8ltquFLrBN/J4/PruhenFn8apBN7P3dXppK8waALTHTL
         TMK3EzZGXxbhZjcXdj5HWhPiwSYMyw9kUZR2jX+JS2HXWBhCMlltWNMLGRcGvWCJYgGV
         bdVpFYru3Gbbp7Bs+CsH1VaDMy24hGiA9Pm6Yae0mMqPbrioIu5TocAe3eiYqmyuTe+8
         lBLoKaHg0EORHlcjsKIE7OsQEtqgbSJAxc5PKXvWRkTGNBvhHrjbBZckY05voQb+TMXY
         S8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qmNpx/g8eOAMrYIIi7Ajy8VOql5zyhopFdJO0Vy6qRA=;
        b=IqglGGyoMPxV/wk7lW/89D7J9DYu6rdM9ZqOLz046QUdTnYCNpcOIom6ygtAc0T4G6
         bmZgX9S3ru5sg2L/yPz9UX9yeneaGqjqrL+eNqKRoEv5XEXtwHt33bXgwvDGuY5oUDh+
         Yqdz1Y3PpILHBByJM+DLsanyRlXGkWYYZKLSUwtFm9TOR1drnQQXov50FFVCcGwzoMFh
         O+YOAXjzcciQN5NEebVWITO/4xMwY4fVShP+JPx60AIA06dM0F0osJBjwjZAnFQUl3De
         OSzMxvsrAcw9zYcg4UyFcjveSmjagMxtZ9u6M8qdhE8x9dZyzM02/uhQdBhRyQO4bPQt
         3lYQ==
X-Gm-Message-State: AJIora9h8tHRnvK5NdO3MEIM5vlo/EHrm4x6xyyI5eA7Op7877FsHofu
        UcaWUyDd3vkMQ9wW4DwfyAAXSbVA1rkfJA==
X-Google-Smtp-Source: AGRyM1tETg7MLks4Noizdf9gTEVrfLypFXm4NUV0bgL8AY1sCOv8Qz/5ChclcT09AMfWp/ktuQ+y6g==
X-Received: by 2002:a05:6a00:cc7:b0:52a:e51c:dc18 with SMTP id b7-20020a056a000cc700b0052ae51cdc18mr13450519pfv.56.1658763123963;
        Mon, 25 Jul 2022 08:32:03 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id m1-20020a62a201000000b005289ef6db79sm9745477pff.32.2022.07.25.08.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:32:03 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 0/9] can: remove litteral strings used for driver name and remove DRV_VERSION
Date:   Tue, 26 Jul 2022 00:31:15 +0900
Message-Id: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
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

This is a cleanup series.

The patches 1 to 8 get rid of any hardcoded strings and instead relies
on either KBUILD_MODNAME or DRV_NAME macros to get the device
name. Patch 9 removes the DRV_VERSION macro from etas_es58x driver so
that the module uses the default behavior and advertise the kernel
version instead of a custom version.

* Changelog *

This series are the first 9 patches of:
https://lore.kernel.org/linux-can/20220725133208.432176-1-mailhol.vincent@wanadoo.fr/T/

The initial intent of those 9 patches was to do so cleanup in order to
implement ethtool_ops::get_drvinfo but this appeared to be useless:
https://lore.kernel.org/linux-can/20220725140911.2djwxfrx3kdmjeuc@pengutronix.de/

Instead, those patch are send as a standalone series

Vincent Mailhol (9):
  can: can327: use KBUILD_MODNAME instead of hard coded name
  can: ems_ubs: use KBUILD_MODNAME instead of hard coded name
  can: slcan: add DRV_NAME and define pr_fmt to replace hardcoded names
  can: softing: add DRV_NAME to replace hardcoded names
  can: esd_usb: use KBUILD_MODNAME instead of hard coded name
  can: gs_ubs: use KBUILD_MODNAME instead of hard coded name
  can: softing: add DRV_NAME to replace hardcoded names
  can: ubs_8dev: use KBUILD_MODNAME instead of hard coded name
  can: etas_es58x: remove DRV_VERSION

 drivers/net/can/can327.c                         |  4 ++--
 drivers/net/can/slcan/slcan-core.c               | 15 +++++++++------
 drivers/net/can/softing/softing_main.c           |  5 +++--
 drivers/net/can/usb/ems_usb.c                    |  4 ++--
 drivers/net/can/usb/esd_usb.c                    |  2 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c      |  7 ++-----
 drivers/net/can/usb/gs_usb.c                     |  6 +++---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c |  4 +++-
 drivers/net/can/usb/usb_8dev.c                   |  4 ++--
 9 files changed, 27 insertions(+), 24 deletions(-)

-- 
2.35.1

