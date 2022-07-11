Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD545709FC
	for <lists+linux-can@lfdr.de>; Mon, 11 Jul 2022 20:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiGKSet (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jul 2022 14:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGKSes (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jul 2022 14:34:48 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889462250B
        for <linux-can@vger.kernel.org>; Mon, 11 Jul 2022 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657564480;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=GZOko4aqLkiMFBVpuu9TjRpZl7O6SzJppsdMNi4G7Nk=;
    b=Gc+4yR3mXn2y5jegkxcWEq2xRvkpwpDT4peXNWO2SvJAvZAPsyuRJjoq1/tul8tbBJ
    axgWt6bmRwioE1IIL8mUiIISNoq9m1fazbOFELq3qn+53FTxkGi1vhOY84sfQzc0pi04
    ARzig3wH5mRcCLSWf5qJj38DWQ7Rk2qUk0SDnnQfmlAOh3B3o9EuHO1+iRdbpQCeN1qo
    PWMlesBMPnNIRnV/GTJI86hkPW1ODVNFKzoxRCj7YNhtvkB19+/WUAwsGY7y2Dz/bawE
    OYf4NMxYel3dMRAzNlWwPC91ACHr/MX8cjVjL0eKFQTSqgfpUiFQ1Z6o8PntF5QEQqO7
    1oNA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXUKbZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.46.1 AUTH)
    with ESMTPSA id 398cccy6BIYeReK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 11 Jul 2022 20:34:40 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH 0/5] can: support CAN XL
Date:   Mon, 11 Jul 2022 20:34:21 +0200
Message-Id: <20220711183426.96446-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The CAN with eXtended data Length (CAN XL) is a new CAN protocol with a
10Mbit/s data transfer with a new physical layer transceiver (for this
data section). CAN XL allows up to 2048 byte of payload and shares the
arbitration principle (11 bit priority) known from Classical CAN and
CAN FD. RTR and 29 bit identifiers are not implemented in CAN XL.

A short introdution to CAN XL can be found here:
https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/can_xl_1/canxl_intro_20210225.pdf

Oliver Hartkopp (5):
  can: canxl: introduce CAN XL data structure
  can: canxl: introduce ETH_P_CANXL ethernet protocol handling
  can: dev: add CAN XL support
  can: vcan: add CAN XL support
  can: raw: add CAN XL support

 drivers/net/can/dev/rx-offload.c |  2 +-
 drivers/net/can/dev/skb.c        | 53 +++++++++++++++++++++++++++-----
 drivers/net/can/vcan.c           | 11 ++++---
 include/linux/can/skb.h          | 17 +++++++++-
 include/uapi/linux/can.h         | 38 +++++++++++++++++++++++
 include/uapi/linux/can/raw.h     |  1 +
 include/uapi/linux/if_ether.h    |  1 +
 net/can/af_can.c                 | 49 ++++++++++++++++++++++++-----
 net/can/raw.c                    | 26 +++++++++++++++-
 9 files changed, 174 insertions(+), 24 deletions(-)

-- 
2.30.2

