Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A71057A1E8
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 16:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239574AbiGSOk2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 10:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239425AbiGSOkG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 10:40:06 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8E354AEB
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y15so7403643plp.10
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 07:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VLeoY0ShOgFSoBE8/x9DLMqL8kgDuqTRFcWSNcy7Xo=;
        b=QEA8cnNaXq93MZ+RDorFE1DXisytLuNt9lyw13d2REut8njTDw8O3D2ZohCp9hxgr4
         8NsvJ/hLnFI3Gdf3xPWDgl/51v+NuzJro2ia+Bo4W/J5o6PgfYAaY012EhR4dcuLqZQA
         cSipg5ZllNwz4OJEU7IWXzTJ52WV7hq4o8fLkEK3x1eStfFadRDghnfvRm95HRHnN47l
         Ejp00/UJy8JK0llTGKmwm2TPs5BWmb43BS0zxp73MqHOMlHNa7a7hkn196em8beX54AI
         fsbcPiqqk9wCzDqF7wU1M3WKaKFgDkNJ9LhmJoIyULKv0XckERUesfEuSP6FgjfmOaYX
         4Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+VLeoY0ShOgFSoBE8/x9DLMqL8kgDuqTRFcWSNcy7Xo=;
        b=W+BaOmroHHlBFinP1/LujH+ZzZjQF4y1zJ+32QO/TvNwF4gsHOe5LpIkCV8E96NXw3
         ov5KJehXk6ELk+QBSefHLOddSGzVQoMAj2z4hRiZiduj7IHokMgmELM0GdZwOJ8+TxmQ
         BopXtN11CdzzTVeWHwbXYFFcCbZ56Gphc4xZPlSX2XXpayRIu0K45f6GcAW6+nIJySZF
         YWChgpuGxDU6oWe1HNPXApjJl3pceHvcMXi6Dv0f4I47gSF9GP4ajkJUfWnv9bjJU+wO
         oQtbIPebAD22yqjvFS1SENv9V6s9VvQImVYlrt5emTe/LyrdSpIrcAswqBz93t5Jq0j7
         nl3Q==
X-Gm-Message-State: AJIora9zbX8hXLvNdnhOJ5zJHmyFoEGfgRGsmnLe/7m0OQhMBo+N3138
        tNmnOIE+AaZTAhfc6cmQHXYjPoX7L40=
X-Google-Smtp-Source: AGRyM1ujC56J3G23LOVioXCOg/sTx2pSir2FtPjV20lG9nMXhXnbMteYAmx6qYJUy47dkUcrxWd7fQ==
X-Received: by 2002:a17:902:ce81:b0:16c:4be6:2537 with SMTP id f1-20020a170902ce8100b0016c4be62537mr33522956plg.167.1658241363062;
        Tue, 19 Jul 2022 07:36:03 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d75-20020a621d4e000000b0052896629f66sm11562516pfd.208.2022.07.19.07.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:36:02 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 00/12] can: error: set of fixes and improvement on txerr and rxerr reporting
Date:   Tue, 19 Jul 2022 23:35:38 +0900
Message-Id: <20220719143550.3681-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
References: <20220712153157.83847-1-mailhol.vincent@wanadoo.fr>
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


** Changelog **

v1 -> v2:
  * Fix typo in patch #10: data[7] of CAN error frames is for the RX
    error counter, not the TX one (this is litteraly a one byte
    change).

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

