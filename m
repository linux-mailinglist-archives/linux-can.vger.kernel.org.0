Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F2F577F18
	for <lists+linux-can@lfdr.de>; Mon, 18 Jul 2022 11:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiGRJzk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Jul 2022 05:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiGRJzj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 18 Jul 2022 05:55:39 -0400
Received: from mailgw.felk.cvut.cz (mailgw.felk.cvut.cz [147.32.82.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F1E19C29
        for <linux-can@vger.kernel.org>; Mon, 18 Jul 2022 02:55:36 -0700 (PDT)
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id 6725630B2951;
        Mon, 18 Jul 2022 11:55:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        cmp.felk.cvut.cz; h=cc:cc:content-transfer-encoding:date:from
        :from:message-id:mime-version:reply-to:subject:subject:to:to; s=
        felkmail; bh=0BPMuy4HATSP5/81x7ShLGQZp1u2U/wdMtfgQFgT7wY=; b=IMK
        7PtMUhcWWF4sZ20I1Eb8AHUNAa5nZ1s4lPdnKRQ3yS80624j7x5TOwMz1FJbQzXM
        V1GAsyWrwSwtVr/caFNIcMWZ8I05zPUeumdIrjCwu9ANCwD8ll8WwnVscmaOejDo
        UUxz21c9pPQT9ojFKkpjS+/+pHX5LnQfDAYRdZzkWIO3Yz2SpWN/qTFyk89go0vS
        8SYn4qmNwEbE3LR3B6ltFyJrf8RCqLNdWqvKQOdUGHuPCUl/79z0a1fkob+M8eS/
        vLbNjK4aonYN+GAGQK8VevBqGBmKkOwDTCd+bcuDSed2d+HoXWiQLma6x3vGNTlO
        Y4Zwb1H+izveQ3rfKGA==
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id E5F1130B294D;
        Mon, 18 Jul 2022 11:55:33 +0200 (CEST)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 26I9tXaB027923;
        Mon, 18 Jul 2022 11:55:33 +0200
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 26I9tWFJ027920;
        Mon, 18 Jul 2022 11:55:32 +0200
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     linux-can@vger.kernel.org,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        Matej Vasilevski <matej.vasilevski@seznam.cz>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        David Miller <davem@davemloft.net>,
        Carsten Emde <c.emde@osadl.org>,
        Marin Jerabek <martin.jerabek01@gmail.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Jiri Novak <jnovak@fel.cvut.cz>,
        Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: [PATCH v1 0/1] can: ctucanfd: Update CTU CAN FD IP core registers to match version 3.x.
Date:   Mon, 18 Jul 2022 11:55:17 +0200
Message-Id: <cover.1658136506.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The 3.x CTU CAN FD IP core version provides informative fields
with number of Tx registers count and most significant active
(toggling) timestamp base bit.

The fields are read as zero for older 2.x IP core version.
The 4 Tx buffers and bit 63 MSB can be considered in such
case and compatibility with 2.x core version is preserved.

This change allows to update Matej Vasilevski's patch series

  [RFC] can: ctucanfd: RX timestamping implementation

to work with the platform bus and PCIe core integration
without need of additional mandatory parameters.

Only optional one for timestamp clock frequency can be
used when bitrate base clock and timestamp clocks differ.

  ts-frequency:
    description: |
      Frequency of the timestamping counter. Set this if you want to get
      timestamps, but you didn't set the timestamping clock in clocks property.

The information about clocks frequencies on PCIe integration
has to be provided by other means but we expect that it can
be directly deduced from Vendor and Device IDs and corresponding
device table.

Pavel Pisa (1):
  can: ctucanfd: Update CTU CAN FD IP core registers to match version
    3.x.

This patch is intended for 5.20 kernel version but possible postpone
to 5.21 is not big problem.

It would be ideal to include even ctucanfd timestamping in 5.20
but timing for updates and reviews is probably quite tight.

 drivers/net/can/ctucanfd/ctucanfd_kregs.h | 32 ++++++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

-- 
2.20.1

