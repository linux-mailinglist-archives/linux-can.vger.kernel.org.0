Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D9956C47D
	for <lists+linux-can@lfdr.de>; Sat,  9 Jul 2022 01:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239656AbiGHSqc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 14:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbiGHSq1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 14:46:27 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A627C196
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 11:46:25 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s14so26944975ljs.3
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 11:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y3gPXAEkv18xbXKqUBZx3ebsYNTyie97iCVskpJUSUA=;
        b=qRrDqp/pAbYlShyDBhh1V0jlAiv42A8ea4bAzGqlaow+34AdwboicBl8XvlQ4j5tKl
         bB9BPhc5COd0G7R1dxZv6Eirzx2lPQmPcZXGC4xqrro58FuIoTJ0up3bv1YMj6AN9Y4/
         W0VpkI/tZ/nerRSmKIT+0SaLbIjMYttvY8CjJ1CFYbhpPgEej6m+gTXK49XO64ZfgCKN
         YQZb6GeT1cijKdzDtGKcZy742M5pdyz+PEUNlVZ9pcFq745QnDpAQ0HWbFsnj7qFupHF
         BMuML1cgr3F1pDvlLa2b9O+IlTxD9L7wyELa3vtw9lEefeSnvsSkKOtdz+kb8lY8kIBP
         xI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y3gPXAEkv18xbXKqUBZx3ebsYNTyie97iCVskpJUSUA=;
        b=paBMVWl1h7cqXezFLq3szogu7I3m0vELNT/JQkvWUlNCymKikl9D7OciG08IyZq8AE
         IqDuzyydMkeYXuX4rt9taq3ewrI3Acyf552Ts/GNrTT6ZrpYF7i4d3bY9dvlwmH+b/CC
         CEHK18wE1X+Rq/Ggc8u5/r/oMwvx/bZIkyAjEcAjPKtHYJ0eNKnl8jNgIau2qxiXHMxp
         FdOfNNOjPY6qn/EUPZzuxK5lqQwl5QqBpc7AV846yhyx/Y6+yUQaFrClRxSoj4Ns1gF+
         77vXZJOPtIJ8rI3JkECZM5IYZaDFksRKosUySpZQuaAVzAiouME3xfg7bSO+NwotSL8Z
         ZzZA==
X-Gm-Message-State: AJIora88ddDrZsAku2F4doXe4gl9L4lyznudD4yzgN2RDQZfuTa0EtT7
        dfPHRmtx5KUaOC3KAG+rXwyyGA==
X-Google-Smtp-Source: AGRyM1smPgtVmmvQJY0zs950fbNLF2zTnIjE+k4suN9Ev8Mb/Hvjym1i64+pzo60/QpDUBqqtIiIpQ==
X-Received: by 2002:a2e:91d9:0:b0:25a:6fe6:cc15 with SMTP id u25-20020a2e91d9000000b0025a6fe6cc15mr2660534ljg.187.1657305983763;
        Fri, 08 Jul 2022 11:46:23 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id 23-20020a2e1557000000b0025d4d4b4edbsm1159917ljv.34.2022.07.08.11.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 11:46:23 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     stable@vger.kernel.org, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 4.9 0/4] can: kvaser_usb: CAN clock frequency regression
Date:   Fri,  8 Jul 2022 20:45:52 +0200
Message-Id: <20220708184556.280751-1-extja@kvaser.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Backport of upstream patch series [1].

Note: The patch "[PATCH 4.9 1/4] can: kvaser_usb: Add struct kvaser_usb_dev_cfg"
      is added for this backport, and was not part of the original series.

When fixing the CAN clock frequency,
fb12797ab1fe ("can: kvaser_usb: get CAN clock frequency from device"),
I introduced a regression.

For Leaf devices based on M32C, the firmware expects bittiming parameters
calculated for 16MHz clock. Regardless of the actual clock frequency.

This regression affects M32C based Leaf devices with non-16MHz clock.

Also correct the bittiming constants in kvaser_usb_leaf.c, where the
limits are different depending on which firmware/device being used.

[1]
https://lore.kernel.org/linux-can/20220603083820.800246-1-extja@kvaser.com/

Jimmy Assarsson (4):
  can: kvaser_usb: Add struct kvaser_usb_dev_cfg
  can: kvaser_usb: replace run-time checks with struct
    kvaser_usb_driver_info
  can: kvaser_usb: fix CAN clock frequency regression
  can: kvaser_usb: fix bittiming limits

 drivers/net/can/usb/kvaser_usb.c | 325 +++++++++++++++++++------------
 1 file changed, 201 insertions(+), 124 deletions(-)

-- 
2.36.1

