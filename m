Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D789A56B906
	for <lists+linux-can@lfdr.de>; Fri,  8 Jul 2022 13:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbiGHL5e (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 07:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbiGHL5Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 07:57:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426D49B180
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 04:57:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i18so35940331lfu.8
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 04:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jmp4o3/G91OIWIFWbrI5P0JmNsZ7xhaGPc5bWnp3LCA=;
        b=wgyepTX6YvHKE4Xxum9F9QhxUi+vbnbdfWqApbtOtddRPNgyCvocLWKTyyD4DWm0bt
         q82W6nHjAIdjiX+B/OwZIkVTg2AFC0YnyOkZ1b5Dy//h9zcAfHV6GVJqxnPBT0CgLxlV
         V3Cr+jVtD79SepPHJfCAOfSpFfiD6rrnBgDG29j90JHsa2paEyvkDtl5EpA+ee7iWLxV
         d9Jl6qElmRp9pMqawfXnlZE41fzxJnEri5goRuGtw0GaQf1oMZIQhr5c+nF+XuXp4RLR
         jQFEkA7ezflGiflIq8csMoOXj3tBH7HnMXEWlTR3E3YrUmfM0EifgXf7kwhZqa48kR6h
         W2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jmp4o3/G91OIWIFWbrI5P0JmNsZ7xhaGPc5bWnp3LCA=;
        b=hF0/38H57LBJPxj9FAJhNUmMzR0XQTjCDvGnkAUPInjH0rGAlEN6LNeKG0ysmvugK8
         Ocky+tHkuuVSdk0WLDEemMpQ7ULsQvdbf7y10pcU/NH70NK9j4vn58XzB3SWqY4JqCUC
         ZQyIm0gV7SFkvxIiWgCPyT8+xQX4VIzOBLEcV2n8rqSDVXunxvWUySEKTNqBEmbUINrw
         whJZADObZeeajvOcaiRtcMb5SQ/1tgeF/yQTr6eriph2Vah+l40ddyND+6SMGO0cz+Bz
         8kNKeZdP1sMp8y71txZm9Q0MDtpPidDjcTTRzDxYGkvUF8v8F3lp/T8kfTpReTTKxjhi
         NfDw==
X-Gm-Message-State: AJIora8eKnBCon6jC+CFfryM/DAcjzGfYAu7PFawtLf1Hd67hJWEyjMi
        cTpQA/YK9COnH0TM1TiiV34VpW/tK0ILZA==
X-Google-Smtp-Source: AGRyM1vViVG47RgSN8bqCvZPWr2sLlIpc+u2/IaiHmXDynCvyXKIA9VD3g9B/vGMaSUok2bTCOPqUQ==
X-Received: by 2002:a05:6512:3c99:b0:483:7dfc:931b with SMTP id h25-20020a0565123c9900b004837dfc931bmr2238007lfv.6.1657281441252;
        Fri, 08 Jul 2022 04:57:21 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id h7-20020a2e9ec7000000b0025a724f2935sm7336199ljk.137.2022.07.08.04.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:57:20 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 00/15] can: kvaser_usb: Various fixes
Date:   Fri,  8 Jul 2022 13:56:54 +0200
Message-Id: <20220708115709.232815-1-extja@kvaser.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch series was originally posted by Anssi Hannula [1].
Since v1 I've rebased the patches on top of commit
b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")
and replaced a couple of patches with new ones.

[1]
https://lore.kernel.org/linux-can/20220516134748.3724796-1-anssi.hannula@bitwise.fi

Anssi Hannula (10):
  can: kvaser_usb_leaf: Fix overread with an invalid command
  can: kvaser_usb: Fix use of uninitialized completion
  can: kvaser_usb: Fix possible completions during init_completion
  can: kvaser_usb_leaf: Set Warning state even without bus errors
  can: kvaser_usb_leaf: Fix TX queue out of sync after restart
  can: kvaser_usb_leaf: Fix CAN state after restart
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

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  32 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 167 ++++--
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 166 ++++--
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 543 ++++++++++++++++--
 4 files changed, 781 insertions(+), 127 deletions(-)

-- 
2.36.1

