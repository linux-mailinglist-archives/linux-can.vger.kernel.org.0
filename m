Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5388157F9AF
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 08:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiGYGzT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 02:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiGYGy7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 02:54:59 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E31B13D10
        for <linux-can@vger.kernel.org>; Sun, 24 Jul 2022 23:54:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c72so9753087edf.8
        for <linux-can@vger.kernel.org>; Sun, 24 Jul 2022 23:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmGhl/O8vO8ecgOB3iZcnGm9OSQetL5QifZHl1Y9Jtw=;
        b=FAeAVr6QRCw/8bzHUBG1XiYiLv19tats5ZUtcxflqMKrLhDqXrwsauqpbE9CHPhtz8
         XVK9+Ek+uHyEGcyZuju2VbwnTn6WYnBE6ZbvUTbU6DJ62nodSoiAlGDjwHx/z2eT2DXw
         TPMBwSdedDMe4BSyS9Tp7uMnjIgTzHSl5NRoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmGhl/O8vO8ecgOB3iZcnGm9OSQetL5QifZHl1Y9Jtw=;
        b=O173W6CP1Ees8efaFgPAYx8wyvBHBYQhYeWwv2VyXa372JWR0/D3ja4LcuDreqpOTP
         s8dAj4t4R0ZTy0rQ0C1bXzpNyuxsJV206XkJfiVgxfQwJruFJNBXopwGBLQC1ncE0gTV
         TgnoWm9nLHoIhU2u82wu2ZHGKO6FAkwnTT0NePJHrzzwgzsFWuQr0gAmuuLHmdEQf8UF
         /0oz+X1wt3Sj8v0l4h3KySXQS9cF9JDH85fOauOZruHT3SAHNtQuOJm/fVIG45ttiXdn
         cN58vlptHUyL8qUAACA3BA6USIA3Wxw/4Wykj/wOC8m2+1jivI8HrmQ6F3/rDU4f/dhn
         CmVA==
X-Gm-Message-State: AJIora+kljFB7iXEkacyfIGJjM9FiOt+gC0at19hs/kWA3lperxIQLdX
        GC/m4I+OJv+Pwtl0bWqFpmIgHw==
X-Google-Smtp-Source: AGRyM1uDSHCns9IrLvdseRQpZO2sPS+rMNvDOjcBKR3tT9ujl69eIp3W7WHf4wv5Io6J1tBOXIzRgg==
X-Received: by 2002:a05:6402:5415:b0:43b:a888:fefe with SMTP id ev21-20020a056402541500b0043ba888fefemr11538643edb.302.1658732063862;
        Sun, 24 Jul 2022 23:54:23 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-14-98-67.retail.telecomitalia.it. [87.14.98.67])
        by smtp.gmail.com with ESMTPSA id r2-20020a1709060d4200b00722e57fa051sm4967711ejh.90.2022.07.24.23.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 23:54:23 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 0/6] can: slcan: extend supported features (step 2)
Date:   Mon, 25 Jul 2022 08:54:13 +0200
Message-Id: <20220725065419.3005015-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

With this series I try to finish the task, started with the series [1],
of completely removing the dependency of the slcan driver from the
userspace slcand/slcan_attach applications.

The series, however, still lacks a patch for sending the bitrate setting
command to the adapter:

slcan_attach -b <btr> <dev>

Without at least this patch the task cannot be considered truly completed.

The idea I got is that this can only happen through the ethtool API.
Among the various operations made available by this interface I would
have used the set_regs (but only the get_regs has been developed), or,
the set_eeprom, even if the setting would not be stored in an eeprom.
IMHO it would take a set_regs operation with a `struct ethtool_wregs'
parameter similar to `struct ethtool_eeprom' without the magic field:

struct ethtool_wregs {
	__u32	cmd;
	__u32	offset;
	__u32	len;
	__u8	data[0];
};

But I am not the expert and if there was an alternative solution already
usable, it would be welcome.

The series also contains patches that remove the legacy stuff (slcan_devs,
SLCAN_MAGIC, ...) and do some module cleanup.

The series has been created on top of the patches:

can: slcan: convert comments to network style comments
can: slcan: slcan_init() convert printk(LEVEL ...) to pr_level()
can: slcan: fix whitespace issues
can: slcan: convert comparison to NULL into !val
can: slcan: clean up if/else
can: slcan: use scnprintf() as a hardening measure
can: slcan: do not report txerr and rxerr during bus-off
can: slcan: do not sleep with a spin lock held

applied to linux-next.

[1] https://lore.kernel.org/all/20220628163137.413025-1-dario.binacchi@amarulasolutions.com/

Changes in v2:
- Re-add headers that export at least one symbol used by the module.
- Update the commit description.
- Drop the old "slcan" name to use the standard canX interface naming.
- Remove comment on listen-only command.
- Update the commit subject and description.
- Add the patch "MAINTAINERS: Add myself as maintainer of the SLCAN driver"
  to the series.

Dario Binacchi (6):
  can: slcan: remove useless header inclusions
  can: slcan: remove legacy infrastructure
  can: slcan: change every `slc' occurrence in `slcan'
  can: slcan: use the generic can_change_mtu()
  can: slcan: add support for listen-only mode
  MAINTAINERS: Add maintainer for the slcan driver

 MAINTAINERS                        |   6 +
 drivers/net/can/slcan/slcan-core.c | 451 +++++++++--------------------
 2 files changed, 139 insertions(+), 318 deletions(-)

-- 
2.32.0

