Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58DE5870A4
	for <lists+linux-can@lfdr.de>; Mon,  1 Aug 2022 21:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiHATA2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Aug 2022 15:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiHATA1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Aug 2022 15:00:27 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768F1D13D
        for <linux-can@vger.kernel.org>; Mon,  1 Aug 2022 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1659380420;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=dDlSYdX8mucs3fhR/WRO82WheED/tW/u8xiYoGgafMo=;
    b=YCFjD2sK2pLdkXpaSQnSUMfROBfvwAfgBEmB91PZ7JpYFwcsw9O/O4tT4egSwKXuH6
    Ma4jWmuykoaM3I8lJ/Oi+ntXsGDtAPN8RSq7JEo4p3+Be4IQYrds8GGUNkecbuHHzUeu
    WyUUCZz4vmP64DMowWIH3hNnhjatdzx723Of/izZblvyKiXIylr9IEdzhe+AN/RXHCXv
    NqldFEQqqbhwSBSGwXUd73DfN0DKOJNbYeHVx8wcgM8X5nSi8K/hOnktecUsp6pE2pOr
    TvmuJrpQzk+oqyl6EdBtEq/htuwm63QoYbg0Ox0cXIcYWANuwMyo8Hhu7FlYs6IDOKho
    NeSg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXUKbZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id Icb1b0y71J0KHvt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 1 Aug 2022 21:00:20 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v8 0/7] can: support CAN XL
Date:   Mon,  1 Aug 2022 21:00:03 +0200
Message-Id: <20220801190010.3344-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

V7:

- fixed indention as remarked by Marc
- set CANFD_FDF flag when detecting CAN FD frames generated by PF_PACKET
- Allow to use variable CAN XL MTU sizes to enforce real time requirements
  on CAN XL segments (e.g. to support of CAN CiA segmentation concept)

V8:

- fixed typo as remarked by Vincent
- rebased to latest can-next/net-next tree

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
 drivers/net/can/dev/skb.c                | 113 ++++++++++++++++-------
 drivers/net/can/vcan.c                   |  12 +--
 drivers/net/can/vxcan.c                  |   8 +-
 include/linux/can/dev.h                  |   5 +
 include/linux/can/skb.h                  |  57 +++++++++++-
 include/uapi/linux/can.h                 |  55 ++++++++++-
 include/uapi/linux/can/raw.h             |   1 +
 include/uapi/linux/if_ether.h            |   1 +
 net/can/af_can.c                         |  76 ++++++++-------
 net/can/bcm.c                            |   9 +-
 net/can/gw.c                             |   4 +-
 net/can/isotp.c                          |   2 +-
 net/can/j1939/main.c                     |   4 +
 net/can/raw.c                            |  55 ++++++++---
 16 files changed, 299 insertions(+), 106 deletions(-)

-- 
2.30.2

