Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF0D46D2D3
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 12:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhLHL75 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 06:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhLHL74 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 06:59:56 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE1FC0617A1
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 03:56:24 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id d10so5131737lfg.6
        for <linux-can@vger.kernel.org>; Wed, 08 Dec 2021 03:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2BzRq665P91EoWRliqyqzMJ/ecA8qf+Ptr/iz5xilo=;
        b=PRioz//B7kFP0/Xrncavl4f/rcHRQDeyUrp/J3EQb47kWD14hbS1DPp3bfCHtC6WdA
         Wp3rmDV+iH5bTD5wFSRCa+epuksE91awGf7/FKhXh6hdhEh81/tqh/ZMaYe6qVHpFW+r
         zAZrrKguIHYoQTSnD8Sj0Rx5/x7L+JSKImhywb0uPTIPZi4mmyN+wweEC/SF3dLzNUU7
         EZOTBMAcg9bvGKAQ8du0zso0/wvbxgzs4Lw0RPc7wvAqXXaiUhfK1+Lb3YelmouI/OA1
         28s8SGOOpk3HsmgAedvr6TgCVMqbJgum3U/KK4LgAUgwYa4C/vzk5fYy6Zgg74DhjqzD
         CVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2BzRq665P91EoWRliqyqzMJ/ecA8qf+Ptr/iz5xilo=;
        b=0tZZeRp2PBjQu25iq5pBDobM6/Ulz7fMUL+YNO5zhRcYJI6eb1KUx76SyzrXdsZKA6
         tpi/LJGxhw1rK1xX2FcLS/GKSl8vcJ0PDSBNRq5b5BFNrG2GsaaUt5ISKyJEnxRjR+dN
         BeUQUoLqtz+EwhtZatWqHjmTVoBHmREzIeGJvMYGqpQkrUrYXXN3ILdqLA30UDJ4nW95
         UkRCuJ5aJ1vppwWpXMrgGrpI2Y+2Bm29HLhkb89Fuq8g1MoEwOaetqPRDHD+kgMKyDXE
         LHVJ8xx8uZ5WCGci4k3VUOOGeLQheUGf3fzcpY+a8o7edf8UJVfduZcf7fmB+H/X4F1C
         0Hxg==
X-Gm-Message-State: AOAM53319Nua/IaKsKM7U3uUAGROicT+0wHasX3kbo8wSdMH+DmqUK69
        j/G1WUlv3BHHbNwtvIxzdjtr4MbC0NkXOvCc
X-Google-Smtp-Source: ABdhPJwsJsrJYAhqcNqqxYPXiWLCDPiYP0Tgu7PRkrORW3DzC58Ui3SefH769KJTZ1g+iVnBGLlWYQ==
X-Received: by 2002:a05:6512:31cd:: with SMTP id j13mr16050754lfe.586.1638964583285;
        Wed, 08 Dec 2021 03:56:23 -0800 (PST)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id c25sm256977lja.38.2021.12.08.03.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 03:56:22 -0800 (PST)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 0/4] kvaser_{pciefd,usb} fixes
Date:   Wed,  8 Dec 2021 12:56:03 +0100
Message-Id: <20211208115607.202859-1-extja@kvaser.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The first patch fix increase of the correct
net_device_stats {rx,tx}_errors counter, for kvaser_pciefd.
The last three patches fix the CAN clock frequency for Kvaser Leaf devices,
for kvaser_usb.

Note that this series contains patches for both kvaser_usb and
kvaser_pciefd driver.

Dropped patches;
[PATCH v1 1_5] can: kvaser_pciefd: Do not increase
stats->rx_{packets,bytes} for error frames
[PATCH v1 3_5] can: kvaser_usb: Do not increase
stats->rx_{packets,bytes} for error frames
and rebased on [PATCH v5 0/5] fix statistics and payload issues for
error [1] series.

[1]
https://lore.kernel.org/all/20211207121531.42941-1-mailhol.vincent@wanadoo.fr

Jimmy Assarsson (4):
  can: kvaser_pciefd: Increase correct stats->{rx,tx}_errors counter
  can: kvaser_usb: Use CAN_MHZ define in assignment of frequency
  can: kvaser_usb: Rearrange kvaser_usb_leaf_dev_cfg to avoid forward
    declaration
  can: kvaser_usb: Get CAN clock frequency from device

 drivers/net/can/kvaser_pciefd.c               |   8 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c |   7 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 102 +++++++++++++-----
 3 files changed, 85 insertions(+), 32 deletions(-)

-- 
2.34.1

