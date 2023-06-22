Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8541473A479
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 17:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjFVPMb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 11:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjFVPM2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 11:12:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBA71FE7
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:12:11 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so10122578e87.2
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1687446730; x=1690038730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rbon9YtnUngEVt8WM6MWN0uFjPLQzLnrfv32xQmhl0k=;
        b=DV5imsbDVzxy/zmUclR/y5yKJ5zHqUPanj/3FU/DQWibDADdsuvt/Kc9kGPuvvOOCs
         1ZSDnPlsllG6GtZqpkkjiRAo/Jww7HuxxIg/MVXOhjuY0QRzcNYEljS9Df3P2zbuJO6s
         Vz49RhoRhjutdyuu68S343M6crKmoE6dl61PdyJQAmYbKwgnDXMEr1VpJA5EPLmx7bJV
         Q/FUuFMK6pc/Xwzus1ncaAuY67iVrsXka9MaFh/nJMq53lZMuouDACOf8YaJMfo8+Y98
         mygEo5V+vwUAvh05rGMsinAL9+YQLL2xw6N4C3gmckbj5zX2cfOvyZxG3NkIQ7k4mw/7
         S3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687446730; x=1690038730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rbon9YtnUngEVt8WM6MWN0uFjPLQzLnrfv32xQmhl0k=;
        b=bPG+igyN+Xurau+XVkuCVHnN4w884qXuhQ+1hEuKKiZlRvha9/28SI0WLFkzaVMAUZ
         mv5dvQrxVw4J4ZYx4irwqyUQMqus0Atj9c70gRvNuIercLk4/0gyBP6wwhkWbnWDzh+k
         q56+crTUnqyM+t7/QsyzXU5fvStP9Ff2rZD4ASpc2dKGsvWCeffCBg/qNnquzhng899s
         ony6LqTm8PKYJLCGmRwaTeCYUslqHrWLzHVe1LWvB8q/x01yiO9dB9c+ZdWZJXYH/Z75
         S2f+5pi25fPobBu/NCiMfzpCZheYn2k4TnXBV7BDU9qi410fGUmUzlspVhNGG3Xblzh7
         yQHA==
X-Gm-Message-State: AC+VfDzKXnnZubkyBmyna0Cy0yoKOl4GM/EqDE9DuhpVNUIv4D7WJGFu
        4wIdED1QPkV4UPTXnUeZV7Kp+d67rnH6HxPut0g=
X-Google-Smtp-Source: ACHHUZ5OkE+q+OBYWn0Ol/SRnQP2lx0ZE2WOueqBxurkwDlB1uyrNoGE63r1/nbqfjuR+N1iguE94g==
X-Received: by 2002:a19:6d0e:0:b0:4f8:4240:5308 with SMTP id i14-20020a196d0e000000b004f842405308mr1418421lfc.42.1687446729548;
        Thu, 22 Jun 2023 08:12:09 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id p2-20020a19f002000000b004f85885cff1sm1117787lfc.134.2023.06.22.08.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 08:12:09 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 0/2] can: kvaser_pciefd: Add support for new Kvaser PCI Express devices
Date:   Thu, 22 Jun 2023 17:11:51 +0200
Message-Id: <20230622151153.294844-1-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
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

This patch series adds support for a range of new Kvaser PCI Express
devices based on the SmartFusion2 SoC, to the kvaser_pciefd driver.

In the first patch, the hardware specific constants and functions are
moved into a driver_data struct.

In the second patch, we add the new devices and their hardware specific
constants and functions.


Jimmy Assarsson (2):
  can: kvaser_pciefd: Move hardware specific constants and functions
    into a driver_data struct
  can: kvaser_pciefd: Add support for new Kvaser pciefd devices

 drivers/net/can/Kconfig         |   5 +
 drivers/net/can/kvaser_pciefd.c | 307 ++++++++++++++++++++++++--------
 2 files changed, 235 insertions(+), 77 deletions(-)

-- 
Changes in v2:
 - Rebased on
   can: kvaser_pciefd: Fixes and improvements [1]
 - Dropped
   can: kvaser_pciefd: Wrap register read and writes with macros [2]
   since the driver became a lot cleaner when using FIELD_{GET,PREP} and GENMASK.
   Moved some parts of the patch into
   can: kvaser_pciefd: Move hardware specific constants and functions into a driver_data struct
   Removed macros reading/writing registers.

[1] https://lore.kernel.org/all/20230529134248.752036-1-extja@kvaser.com
[2] https://lore.kernel.org/linux-can/20230523094354.83792-17-extja@kvaser.com

2.40.0

