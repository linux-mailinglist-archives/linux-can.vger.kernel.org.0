Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D10E57526B
	for <lists+linux-can@lfdr.de>; Thu, 14 Jul 2022 18:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbiGNQGA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Jul 2022 12:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbiGNQF7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Jul 2022 12:05:59 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4711B65598
        for <linux-can@vger.kernel.org>; Thu, 14 Jul 2022 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657814754;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=kjyjjvMVjYfUHi6HRW3AnGYdInej2VcMDUI/9Hkkz/8=;
    b=iSL0HXgZ3aj7lt4gWGemcsHc5uTJ/DbD6alUOUfHmXkbA4C3Arokzsw5sZB8rCRgPJ
    G7Yz0ryiiAjDNCDKbyGB84+kLM8AdO0GoQp1WuQL/qFK3gLzsiB0NcxBke4lraU+Te/E
    wu67cN2k19hKqCltTFsdmMMnWBW+p8ZTx1qoRwYlDeZsoEC3eYf58cZGcMn8A5xU5U+U
    ze8HQ7rc/Gpr6zptP8UQOnjrI8CxC8ko7QydxeFN04nDGE8dM+Btx1SqzGV4XdSDfwkg
    P6Af3oCvnoLKM8dgoAc5xFPx/V/sfxzSNSxiz+nRkQsq8G/bs9Z2N+z/RbuXIMMsGwiG
    PIGQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXDKPZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6EG5s6eu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 14 Jul 2022 18:05:54 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v2 0/5] can: support CAN XL
Date:   Thu, 14 Jul 2022 18:05:36 +0200
Message-Id: <20220714160541.2071-1-socketcan@hartkopp.net>
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

V2: Major rework after discussion and feedback on Linux-CAN ML

- rework of struct canxl_frame
- CANXL_XLF flag is now the switch between CAN XL and CAN/CANFD
- variable length in r/w operations for CAN XL frames
- write CAN XL frame to raw socket enforces size <-> canxl_frame.len sync

Oliver Hartkopp (5):
  can: canxl: introduce CAN XL data structure
  can: canxl: introduce ETH_P_CANXL ethernet protocol handling
  can: dev: add CAN XL support
  can: vcan: add CAN XL support
  can: raw: add CAN XL support

 drivers/net/can/dev/rx-offload.c |  2 +-
 drivers/net/can/dev/skb.c        | 55 ++++++++++++++++++++++++++------
 drivers/net/can/vcan.c           | 11 +++----
 include/linux/can/skb.h          | 45 +++++++++++++++++++++++++-
 include/uapi/linux/can.h         | 50 +++++++++++++++++++++++++++++
 include/uapi/linux/can/raw.h     |  1 +
 include/uapi/linux/if_ether.h    |  1 +
 net/can/af_can.c                 | 36 +++++++++++++++++----
 net/can/raw.c                    | 27 +++++++++++++++-
 9 files changed, 203 insertions(+), 25 deletions(-)

-- 
2.30.2

