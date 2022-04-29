Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEA55144C1
	for <lists+linux-can@lfdr.de>; Fri, 29 Apr 2022 10:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355704AbiD2Iu3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 29 Apr 2022 04:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351315AbiD2Iu3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 29 Apr 2022 04:50:29 -0400
Received: from bin-mail-out-05.binero.net (bin-mail-out-05.binero.net [195.74.38.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2B3522F8
        for <linux-can@vger.kernel.org>; Fri, 29 Apr 2022 01:47:10 -0700 (PDT)
X-Halon-ID: ef0eff8a-c798-11ec-9627-0050569116f7
Authorized-sender: andreas@gaisler.com
Received: from andreas.got.gaisler.com (h-98-128-223-123.na.cust.bahnhof.se [98.128.223.123])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id ef0eff8a-c798-11ec-9627-0050569116f7;
        Fri, 29 Apr 2022 10:47:06 +0200 (CEST)
From:   Andreas Larsson <andreas@gaisler.com>
To:     linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-kernel@vger.kernel.org, software@gaisler.com
Subject: [PATCH v2 0/3] can: grcan: Bug fixes
Date:   Fri, 29 Apr 2022 10:46:53 +0200
Message-Id: <20220429084656.29788-1-andreas@gaisler.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

These patches:
* makes sure that DMA memory is allocated properly
* avoids the tx errata workaround needlessly being applied
* fixes a bug where the driver can be left hanging without interrupts
  enabled

Andreas Larsson (2):
  can: grcan: Fix broken system id check for errata workaround needs
  can: grcan: Only use the napi poll budget for rx

Daniel Hellstrom (1):
  can: grcan: use ofdev->dev when allocating DMA memory

 drivers/net/can/grcan.c | 45 +++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

---

Changes in v2:
* Added "Fixes:" tags to all patches
* Small langague tweaks in patch descriptions for patch 1 and 3

-- 
2.17.1

