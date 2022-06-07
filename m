Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7276553FA25
	for <lists+linux-can@lfdr.de>; Tue,  7 Jun 2022 11:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbiFGJsT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Jun 2022 05:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239963AbiFGJsM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Jun 2022 05:48:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A573CD2444
        for <linux-can@vger.kernel.org>; Tue,  7 Jun 2022 02:48:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso9245353wmp.0
        for <linux-can@vger.kernel.org>; Tue, 07 Jun 2022 02:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=59RavXyEta5t8sr+YdZ4nWyDRUr5ofB/YBoSuRW6FK4=;
        b=jDESy8ofDeN1851pfvFKhws3saitHU8Qf68t0qnmzaOWDoMfXKcOHnQzvzjczJEKKZ
         Fk7VYNrCPa+zwFreDrShre8wL5TOeeGxZx7Jgjhi/tkgETCzZR6wY9pwOJ0Cvn21Oi0r
         J0DPDK9FV0VujnSZqhbB0rE7xysGVImHmw1XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=59RavXyEta5t8sr+YdZ4nWyDRUr5ofB/YBoSuRW6FK4=;
        b=mc24f7xfNWW444T73OtVtY2jlpIHnOZWm2Vk8IMPJQ18jfygQWRmoMUyu5/o5dwSrh
         GJXRleDr5Q8zXIu3yka0KerYCKICFih5dVojyLIYscDsqzxLDgyCGrW9cfi5vLlpDYV9
         cB7tTxY1BzykGJmo4KPRhf6Bc6EWri2yeD7LBDgWBG3etjgERshFkE4LrJsNzgIx9Ofc
         xSSAktdXe9mfWP+ExcW1lwMIHEXXnDOolrBMIcn40Pdvcf//ky/w/kObFwoMxyVfL7vX
         z5crHlHQrZycF5zB0Rn2cGgAzvgwX8HZvcuYGC/b6f9f59fcpMfF0eEw4TohBXuh6dic
         2PLg==
X-Gm-Message-State: AOAM530rt5/OQb0vlL0fa+0qfLLNJibNHTOl0q5b67WJX/cRiqnf9ful
        KFEW1HoRjpo2CjONvblVbpi0cw==
X-Google-Smtp-Source: ABdhPJzmUarD6xcJR6MJR4JZW3ID2U0oin8c9BF3fBnAIHou9QHkrFd9oZ6ewp6kcYr2QeCaAuIYJw==
X-Received: by 2002:a05:600c:2d88:b0:39c:3c07:2845 with SMTP id i8-20020a05600c2d8800b0039c3c072845mr23473258wmg.116.1654595289674;
        Tue, 07 Jun 2022 02:48:09 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (mob-5-90-137-51.net.vodafone.it. [5.90.137.51])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c510400b0039748be12dbsm23200547wms.47.2022.06.07.02.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:48:09 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC PATCH 00/13] can: slcan: extend supported features
Date:   Tue,  7 Jun 2022 11:47:39 +0200
Message-Id: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series originated as a result of CAN communication tests for an
application using the USBtin adapter (https://www.fischl.de/usbtin/).
The tests showed some errors but for the driver everything was ok.
Also, being the first time I used the slcan driver, I was amazed that
it was not possible to configure the bitrate via the ip tool.
For these two reasons, I started looking at the driver code and realized
that it didn't use the CAN network device driver interface.

Starting from these assumptions, I tried to:
- Use the CAN network device driver interface.
- Set the bitrate via the ip tool.
- Send the open/close command to the adapter from the driver.
- Add ethtool support to reset the adapter errors.
- Extend the protocol to forward the adapter CAN communication
  errors and the CAN state changes to the netdev upper layers.

Except for the protocol extension patches (i. e. forward the adapter CAN
communication errors and the CAN state changes to the netdev upper
layers), the whole series has been tested. Testing the extension
protocol patches requires updating the adapter firmware. Before modifying
the firmware I think it makes sense to know if these extensions can be
considered useful.

Before applying the series I used these commands:

slcan_attach -f -s6 -o /dev/ttyACM0
slcand ttyACM0 can0
ip link set can0 up

After applying the series I am using these commands:

slcan_attach /dev/ttyACM0
slcand ttyACM0 can0
ip link set dev can0 down
ip link set can0 type can bitrate 500000
ethtool --set-priv-flags can0 err-rst-on-open on
ip link set dev can0 up

Now there is a clearer separation between serial line and CAN,
but above all, it is possible to use the ip and ethtool commands
as it happens for any CAN device driver. The changes are backward
compatible, you can continue to use the slcand and slcan_attach
command options.



Dario Binacchi (13):
  can: slcan: use the BIT() helper
  can: slcan: use netdev helpers to print out messages
  can: slcan: use the alloc_can_skb() helper
  can: slcan: use CAN network device driver API
  can: slcan: simplify the device de-allocation
  can: slcan: allow to send commands to the adapter
  can: slcan: set bitrate by CAN device driver API
  can: slcan: send the open command to the adapter
  can: slcan: send the close command to the adapter
  can: slcan: move driver into separate sub directory
  can: slcan: add ethtool support to reset adapter errors
  can: slcan: extend the protocol with error info
  can: slcan: extend the protocol with CAN state info

 drivers/net/can/Makefile                      |   2 +-
 drivers/net/can/slcan/Makefile                |   7 +
 .../net/can/{slcan.c => slcan/slcan-core.c}   | 464 +++++++++++++++---
 drivers/net/can/slcan/slcan-ethtool.c         |  65 +++
 drivers/net/can/slcan/slcan.h                 |  18 +
 5 files changed, 480 insertions(+), 76 deletions(-)
 create mode 100644 drivers/net/can/slcan/Makefile
 rename drivers/net/can/{slcan.c => slcan/slcan-core.c} (67%)
 create mode 100644 drivers/net/can/slcan/slcan-ethtool.c
 create mode 100644 drivers/net/can/slcan/slcan.h

-- 
2.32.0

