Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E5E571F40
	for <lists+linux-can@lfdr.de>; Tue, 12 Jul 2022 17:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiGLPcZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 12 Jul 2022 11:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiGLPcY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Jul 2022 11:32:24 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94A59FE06
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id l124so7761681pfl.8
        for <linux-can@vger.kernel.org>; Tue, 12 Jul 2022 08:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXsnbnM5i18NjSz7mIimMKCzrff5AGCHSIVU40hwcMo=;
        b=fuT1PczVNuBpa5e7hwU1Wkogl0fDP68I8+Y8B7RCzKSRPDEgGN3h2hixOQHRmrEmie
         HbUeHcHPjb4WvptAwpiHfgfikqFt/34IaCgZzpU27+2ou9i7JRy28dGirz1jULuOYbF8
         pCQJ+gQ52FJ64yiqLJgyoC6TKQVwdBYDvN+9KVtCs8u8ppMdqb5zoutsB4P6NW2WFPM8
         uOck46V1iUJ6ZlweAtYV8wz1Ina7+3skOln0Ic0A3jd8cJIG2MpUxWX/FjP5G6mlbfJW
         R8Pkgo+JEUYr09p5ygHuHE4P3/7zvj5ylXYmp6FNMvyxtLO8oEAQLir1hQy0dP8IVzGT
         aTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=lXsnbnM5i18NjSz7mIimMKCzrff5AGCHSIVU40hwcMo=;
        b=sjbFYS0L9RAuUXGoHc1CKCTWisYyp+PV3YkXCFSFDYEFOhQZLxtyDQ1mS5Twirqp1x
         zGiIo/QM43f1N8+y71tt1DgFyORMduzjrTnCkS4C549s/p6ZQyD3BaMSUMuRI/vJyxJE
         iwuv0PnLfpXPRFkF+MpUvj3l1JicLOxZk3BNT+l+i0lxG3q+4cAMA1/zQXH34odx8BRp
         i0+zs+NFQe9hhLOYYUFZSUet2f5xJJsOH2s0aZsjMbWgiGXJE2lCqvciKFJNZsrkI4dN
         1y/Hw2NYHjOlCiE3SQW3jKIvMwfrN1ddNoA+HNyoUWlGMo0ctcz9BepMUh3P0fGsoqUZ
         FnLg==
X-Gm-Message-State: AJIora+u/rbrt4SCYA/x5+TEc+GyA5j8/zUlGu7+sPv6hqYRAWm58lV5
        sYQEyccgK1DggavzZNe3VD91AL0q27LmOQ==
X-Google-Smtp-Source: AGRyM1u7SV4FwKNScjqxc/16K7JNkwYXH/WDB3S07ZYjxdZRGO+xTf9KMuY/g0xYZdXMEj07QrLWMg==
X-Received: by 2002:a63:65c2:0:b0:419:8146:b1a7 with SMTP id z185-20020a6365c2000000b004198146b1a7mr1056157pgb.210.1657639943210;
        Tue, 12 Jul 2022 08:32:23 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id c131-20020a621c89000000b005252defb016sm6891483pfc.122.2022.07.12.08.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:32:22 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 00/12] can: error: set of fixes and improvement on txerr and rxerr reporting
Date:   Wed, 13 Jul 2022 00:31:45 +0900
Message-Id: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series is a collection of patches targeting the CAN error
counter. The series is split in three blocks (with small relation to
each other).

Several drivers uses the data[6] and data[7] fields (both of type u8)
of the CAN error frame to report those values. However, the maximum
size an u8 can hold is 255 and the error counter can exceed this value
if bus-off status occurs. As such, the first nine patches of this
series make sure that no drivers try to report txerr or rxerr through
the CAN error frame when bus-off status is reached.

can_frame::data[5..7] are defined as being "controller
specific". Controller specific behaviors are not something desirable
(portability issue...) The tenth patch of this series specifies how
can_frame::data[5..7] should be use and remove any "controller
specific" freedom. The eleventh patch adds a flag to notify though
can_frame::can_id that data[6..7] were populated (in order to be
consistent with other fields).

Finally, the twelfth and last patch add three macro values to specify
the different error counter threshold with so far was hard-coded as
magic numbers in the drivers.

N.B.:
  * patches 1 to 10 are for net (stable).
  * patches 11 and 12 are for net-next (but depends on patches 1 to 10).

Vincent Mailhol (12):
  can: pch_can: do not report txerr and rxerr during bus-off
  can: rcar_can: do not report txerr and rxerr during bus-off
  can: sja1000: do not report txerr and rxerr during bus-off
  can: slcan: do not report txerr and rxerr during bus-off
  can: hi311x: do not report txerr and rxerr during bus-off
  can: sun4i_can: do not report txerr and rxerr during bus-off
  can: kvaser_usb_hydra: do not report txerr and rxerr during bus-off
  can: kvaser_usb_leaf: do not report txerr and rxerr during bus-off
  can: usb_8dev: do not report txerr and rxerr during bus-off
  can: error: specify the values of data[5..7] of CAN error frames
  can: add CAN_ERR_CNT flag to notify availability of error counter
  can: error: add definitions for the different CAN error thresholds

 drivers/net/can/c_can/c_can_main.c            |  6 +++---
 drivers/net/can/cc770/cc770.c                 |  1 +
 drivers/net/can/ctucanfd/ctucanfd_base.c      |  5 +++--
 drivers/net/can/grcan.c                       |  1 +
 drivers/net/can/ifi_canfd/ifi_canfd.c         |  4 ++--
 drivers/net/can/janz-ican3.c                  |  4 ++--
 drivers/net/can/kvaser_pciefd.c               |  2 +-
 drivers/net/can/m_can/m_can.c                 |  4 ++--
 drivers/net/can/pch_can.c                     |  7 ++++---
 drivers/net/can/peak_canfd/peak_canfd.c       |  6 +++---
 drivers/net/can/rcar/rcar_can.c               |  9 +++++----
 drivers/net/can/rcar/rcar_canfd.c             |  4 ++--
 drivers/net/can/sja1000/sja1000.c             |  8 +++++---
 drivers/net/can/slcan/slcan-core.c            | 13 ++++++------
 drivers/net/can/spi/hi311x.c                  |  6 ++++--
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    |  1 +
 drivers/net/can/sun4i_can.c                   | 10 +++++-----
 drivers/net/can/ti_hecc.c                     |  1 +
 drivers/net/can/usb/esd_usb.c                 |  3 ++-
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 14 +++++++++----
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  |  7 +++++--
 drivers/net/can/usb/peak_usb/pcan_usb.c       |  1 +
 drivers/net/can/usb/usb_8dev.c                |  8 +++++---
 drivers/net/can/xilinx_can.c                  |  1 +
 include/uapi/linux/can/error.h                | 20 ++++++++++++++++++-
 25 files changed, 94 insertions(+), 52 deletions(-)

-- 
2.35.1

