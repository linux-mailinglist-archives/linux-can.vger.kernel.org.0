Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A6F5FA3AC
	for <lists+linux-can@lfdr.de>; Mon, 10 Oct 2022 20:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJJSw7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Oct 2022 14:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJJSw7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Oct 2022 14:52:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B7F753BB
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 11:52:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f37so17839275lfv.8
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 11:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3cRxRSlS2mQMLaWclHW8xSm2vqvy6G9bHt9gKWVv2M=;
        b=nOSm2T69lfVdqNc/JUcKf0iG7kcsgWzBn+ULZM5Sk0Ue9SffBogdGSd87Dvr2zWUT1
         mYlAVAVQeMByjGfml6cZWBLbGLHexUDUcmPzfVUV+H8XNaXik3Lf6LS9FkEww33kiW+v
         aTCOFs31mQybibT5Ta64IPhTqtJfuPEIliUI9qvDkkrLAjtvvqpnW/N5x/lrHe63apXS
         DUAdrgWPyPKIGtUNdON2m8g/InZiMurFWv+6DdpOkhJHPz7YlqJUpU6nNauojh6a0oSu
         b2pqYXzxKkRGPZeydyIrnC84tcheycLkgxr12G5H1IfNUYHTfHQqEEMHqlQYZHIorn6R
         /w2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3cRxRSlS2mQMLaWclHW8xSm2vqvy6G9bHt9gKWVv2M=;
        b=J9KXidlHkuW+Y+iN9g7jsR14NO0gJ58EHJuCFDCyxixU7U5ngkXhcZZ0S5KyOs6lJq
         TaaScOtrUJ/ujcopnsokhPZr/F4gkCXW+QenwRoWMTbxegYV+qeSpILzu/+zEj0O7Gd1
         b30OXRHxcdeqlTISvwm1SGo5mTXGpqOX2Ar03gJNNE1f24Ep2VsALIRn/KnkQ36Wud1G
         ZjaYsJKkZt+tA5K8ZDyG9eoYJGeDhG47yPE0s+Y/+JMJJC3cdaTYA124W2/GRnqHLdnz
         sO1E2yYm4nelkgjIJ5yn7L6c6P0c4XPv3Te0edhjuZhKW4i0hDiDchAvWx5RHA9x4zf+
         N+qg==
X-Gm-Message-State: ACrzQf3nwFZsZEWu3Hfvh1s9akfZYtXbYsRwNtz6sVcgySsUe492EC3d
        NTPnRTDx+nhvUbg2OfELvAuvainJz+UfRw==
X-Google-Smtp-Source: AMsMyM6rFfNyfIhW4tv/p6iYTMXnN1xGoMWaj4MxQlFawweNyDIDZM6KEmWWrwCHRpm45z5l0MdLYA==
X-Received: by 2002:a05:6512:6ce:b0:4a2:530a:33d0 with SMTP id u14-20020a05651206ce00b004a2530a33d0mr7636293lff.270.1665427975989;
        Mon, 10 Oct 2022 11:52:55 -0700 (PDT)
Received: from archyz.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512070400b004a2386b8ce6sm1517769lfs.207.2022.10.10.11.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:52:55 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v5 00/11] can: kvaser_usb: Fixes and improvements
Date:   Mon, 10 Oct 2022 20:52:26 +0200
Message-Id: <20221010185237.319219-1-extja@kvaser.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Changes in v5:
 - Split series [1], since v4 got rejected [2].
   This part only contains non-critical fixes and improvements.

Note: This series depend on changes in [3]

[1]
https://lore.kernel.org/linux-can/20220903182344.139-1-extja@kvaser.com
[2]
https://lore.kernel.org/linux-can/20220920192708.jcvyph3ec7lscuqj@pengutronix.de
[3]
https://lore.kernel.org/linux-can/20221010150829.199676-1-extja@kvaser.com/T/#m77a503db16c46024601e0d41fed60a806b02c15f

Anssi Hannula (6):
  can: kvaser_usb: Fix possible completions during init_completion
  can: kvaser_usb_leaf: Set Warning state even without bus errors
  can: kvaser_usb_leaf: Fix improved state not being reported
  can: kvaser_usb_leaf: Fix wrong CAN state after stopping
  can: kvaser_usb_leaf: Ignore stale bus-off after start
  can: kvaser_usb_leaf: Fix bogus restart events

Jimmy Assarsson (5):
  can: kvaser_usb: kvaser_usb_leaf: Get capabilities from device
  can: kvaser_usb: kvaser_usb_leaf: Rename {leaf,usbcan}_cmd_error_event
    to {leaf,usbcan}_cmd_can_error_event
  can: kvaser_usb: kvaser_usb_leaf: Handle CMD_ERROR_EVENT
  can: kvaser_usb: Add struct kvaser_usb_busparams
  can: kvaser_usb: Compare requested bittiming parameters with actual
    parameters in do_set_{,data}_bittiming

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  30 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 115 ++++-
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 164 ++++--
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 468 ++++++++++++++++--
 4 files changed, 682 insertions(+), 95 deletions(-)

-- 
2.38.0

