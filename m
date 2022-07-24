Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1128C57F3CB
	for <lists+linux-can@lfdr.de>; Sun, 24 Jul 2022 09:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbiGXHoQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 24 Jul 2022 03:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbiGXHoP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 24 Jul 2022 03:44:15 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57D213F70
        for <linux-can@vger.kernel.org>; Sun, 24 Jul 2022 00:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658648649;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=l9UB7w+sWb9ImuZLpb/FeQICZx7QETuzgwOi5nDLUuw=;
    b=pVvm52FcY64uYT/T3UFgep/NBxtKZtqionorOPA6p7zSiJVmWDdDieKpHJP4nP/LxN
    eOwgVZx58wgfF//XqTn9mCwUAVx8uhADVMrwUYPKNzxg8ixbZaCFSnu+DgLEHt+q+/uw
    vtdCgmGIPVSfp6Iq64PgOMExbCyoA+fg440humA5q/rHPbiTYZvc5iNzHq/lmtS4U3CB
    N7s5pKFwww+8ldnVMrLWmnKIbzOoYmJUIbl/lqXwMe6h74mzKKfAmMbhyF0di13amIuR
    alYs/4pViY3UqH5rCQ5taeumBCWVLbC/ofk8YdK8ZvqtVn+kPcdgbCcXdCX3FCjDbz9w
    HCFQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXUKbZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id jdcffay6O7i886S
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 24 Jul 2022 09:44:08 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v6 0/7] can: support CAN XL
Date:   Sun, 24 Jul 2022 09:43:55 +0200
Message-Id: <20220724074402.117394-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

V3: Fix length for CAN XL frames inside the sk_buff

- extend the CAN_RAW sockopt to handle fixed/truncated read/write operations

V4: Fix patch 5 (can: raw: add CAN XL support)

- fix return value (move 'err = -EINVAL' in raw_sendmsg())
- add CAN XL frame handling in can_rcv()
- change comment for CAN_RAW_XL_[RT]X_DYN definition (allow -> enable)

V5: Remove CAN_RAW_XL_[RT]X_DYN definition again

- CAN_RAW_XL_[RT]X_DYN (truncated data) feature is now enabled by default
- use CANXL_MIN_DLEN instead of '1' in canxl_frame definition
- add missing 'err = -EINVAL' initialization in raw_sendmsg())

V6:

- rework an separate skb identification and length helpers
- add CANFD_FDF flag in all CAN FD frame structures
- simplify patches for infrastructure and raw sockets
- add vxcan support in virtual CAN interface patch

Oliver Hartkopp (7):
  can: skb: unify skb CAN frame identification helpers
  can: skb: add skb CAN frame data length helpers
  can: set CANFD_FDF flag in all CAN FD frame structures
  can: canxl: introduce CAN XL data structure
  can: canxl: update CAN infrastructure for CAN XL frames
  can: dev: add CAN XL support to virtual CAN
  can: raw: add CAN XL support

 drivers/net/can/ctucanfd/ctucanfd_base.c |   1 -
 drivers/net/can/dev/rx-offload.c         |   2 +-
 drivers/net/can/dev/skb.c                | 105 +++++++++++++++--------
 drivers/net/can/vcan.c                   |  11 ++-
 drivers/net/can/vxcan.c                  |   7 +-
 include/linux/can/skb.h                  |  57 +++++++++++-
 include/uapi/linux/can.h                 |  53 +++++++++++-
 include/uapi/linux/can/raw.h             |   1 +
 include/uapi/linux/if_ether.h            |   1 +
 net/can/af_can.c                         |  76 ++++++++--------
 net/can/bcm.c                            |   9 +-
 net/can/gw.c                             |   4 +-
 net/can/isotp.c                          |   2 +-
 net/can/j1939/main.c                     |   4 +
 net/can/raw.c                            |  54 +++++++++---
 15 files changed, 281 insertions(+), 106 deletions(-)

-- 
2.30.2

