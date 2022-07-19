Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CCB579875
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 13:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbiGSL2F (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 07:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbiGSL2C (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 07:28:02 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBCE40BC6
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 04:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658230074;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=RHeHGsDSxulwCsZ+JFqkLcGWK9CWBctYHCp0DXwBmHg=;
    b=Fv4wQUQ6jee03SCRVntUcV9E2hennk8HhU/SMGvboY59CjihIE0JyGbzoRiXtzfC9x
    BMvNvnOUrCu5hbrBHJs1pbtZKOYPvuUdn5/RFHcMJ3L7MM6H1PzFugHm3vIZlvF2ZGyT
    3EYDvjQQjKXcWfSXOXIVxDTqzApIuhBHUbrU9pUV6zdIBX2xFqY89vOa0rA08Z5nnHgR
    RQyozDRTSlmrBNDdg5R95xYyHhrk72FIA3NNkTOz7Upc60h2pwSiJTXNgZ2BE0AlhtHU
    Z3Cpfpzl893SMdA43tWw2MlbBmQfiEEk9k27VkHZ2K3Wt1yi39YxTt2k7A0oAv3JAYtv
    B39w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYwXUKbZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6JBRsGeM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 19 Jul 2022 13:27:54 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v5 0/5] can: support CAN XL
Date:   Tue, 19 Jul 2022 13:27:43 +0200
Message-Id: <20220719112748.3281-1-socketcan@hartkopp.net>
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

Oliver Hartkopp (5):
  can: canxl: introduce CAN XL data structure
  can: canxl: introduce ETH_P_CANXL ethernet protocol handling
  can: dev: add CAN XL support
  can: vcan: add CAN XL support
  can: raw: add CAN XL support

 drivers/net/can/dev/rx-offload.c |  2 +-
 drivers/net/can/dev/skb.c        | 49 ++++++++++++++----
 drivers/net/can/vcan.c           | 11 ++--
 include/linux/can/skb.h          | 44 +++++++++++++++-
 include/uapi/linux/can.h         | 49 ++++++++++++++++++
 include/uapi/linux/can/raw.h     |  1 +
 include/uapi/linux/if_ether.h    |  1 +
 net/can/af_can.c                 | 32 ++++++++++--
 net/can/raw.c                    | 89 +++++++++++++++++++++++++++-----
 9 files changed, 242 insertions(+), 36 deletions(-)

-- 
2.30.2

