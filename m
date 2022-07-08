Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE95C56C40D
	for <lists+linux-can@lfdr.de>; Sat,  9 Jul 2022 01:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbiGHSrL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 14:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239678AbiGHSrK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 14:47:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0D25A2D9
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 11:47:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f39so37715049lfv.3
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 11:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XrpoZ2xyvOYqL5rcerQR2ySTzg49DWdmPhp2IQVVheY=;
        b=ov/W2AWXNvmw1KRjaj8dEbH0DPybIMCC9m8yMW4LVISBjzwwt5L4wudEzqUpHmWCK4
         6BKB4+TfD+wX0XbDHd9oX3o0AqW1zFZ2kJpMBDgAVfrcNu3eyVSNWSGTI1f4ITAQM812
         AXCPwpo5Uni11C4QCtU5geNmTQ7g7hXLKVS/lyjtkVOgs4GLgz1qwwaZfz+HkcXW/X1O
         RMAoVWrd4jg/RDhEa/rHHeYkPZ5EqtIaOCZAHYfHPpthz/9sVFin4BtTdU42+c8jnZ8m
         sfM1TyIF9iF75IRnQY7wjpvTUT3fk4CZ5CZ0jX+dz94SEfAdIeDrDNDtbTfMYMzjjSps
         o7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XrpoZ2xyvOYqL5rcerQR2ySTzg49DWdmPhp2IQVVheY=;
        b=jOFvrFyHNPn50E/UN2ein0LM7f9luGXPyLoyrKibbLDWpa2jwgRNHGlW4SvM2O0LdJ
         ZRfcbB4zFX95CkcoB2cXnOmrVwZ4r7VfmOyIFdMHE711CG5oOMhz2HPEt4lMb0GegiD/
         9jYIyAb5XV+OKB90/Rxwc67vc7abQX2s7jDLx2S56GMaWshDdPOwZjswFH9kQPm7wUOP
         l8yNHyZw/+pDRvCR6y5wdh2R0t4ivuZ1WE/+dxsLd4nktLylMYrC6JHMLun/6L/2lnVh
         dt4Ze1Wjr0+WBkxJ8GSvduWWfNsQSOXxx07p/vV+SW2jdOrQMD/cENqnLU5c4q5FrU4g
         9B3g==
X-Gm-Message-State: AJIora9NpuaGRQQ/a3PLXgsCMeZi32/gd7pZPKYgpuCn2sUGw5VP1kF8
        eB3RfplarIN1sMcIYx29vw40jw==
X-Google-Smtp-Source: AGRyM1tqSSNFoyRw8kLPRY8ZIwSO8FpZMiHvXtBXnVlaN4Hhi3jdDfOLzlKRuLSXyEXnVOHgfe7Pww==
X-Received: by 2002:a05:6512:39d5:b0:47f:6e9a:5bf with SMTP id k21-20020a05651239d500b0047f6e9a05bfmr3243699lfu.580.1657306027682;
        Fri, 08 Jul 2022 11:47:07 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id u22-20020a197916000000b0047fa941067fsm7558386lfc.29.2022.07.08.11.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 11:47:07 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     stable@vger.kernel.org, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 4.14 0/4] can: kvaser_usb: CAN clock frequency regression
Date:   Fri,  8 Jul 2022 20:46:49 +0200
Message-Id: <20220708184653.280882-1-extja@kvaser.com>
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

Note: The patch "[PATCH 4.14 1/4] can: kvaser_usb: Add struct kvaser_usb_dev_cfg"
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

