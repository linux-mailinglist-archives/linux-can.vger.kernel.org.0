Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E80748E6A
	for <lists+linux-can@lfdr.de>; Wed,  5 Jul 2023 21:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjGETy0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jul 2023 15:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjGETyY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jul 2023 15:54:24 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA041981;
        Wed,  5 Jul 2023 12:54:21 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 365JruRW029344;
        Wed, 5 Jul 2023 14:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1688586836;
        bh=JYEmsOFHbXgS5MxsHkWI4gJFbQZO7FxeLmm0d1G/I18=;
        h=From:To:CC:Subject:Date;
        b=Dtr3GvoLEH1+JV3O3xC2peTbniUUh/ZSq7Q9izsEuwludmzMUCn5n0sEuISQuHuly
         kwKid9WkcW3YLBQhPcA8BzLhPAD/fTrIxCADe4z4QlOLfmOUqK5nlgEchxFW1eJ3DK
         /crXLuuEVeUlM4dQqThHW3qsgJc8Ee1dLse8xWh8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 365Jru2k083979
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Jul 2023 14:53:56 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jul 2023 14:53:56 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jul 2023 14:53:56 -0500
Received: from uda0498204.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 365JrueS041658;
        Wed, 5 Jul 2023 14:53:56 -0500
From:   Judith Mendez <jm@ti.com>
To:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <linux-can@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Schuyler Patton <spatton@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH 0/2] Enable multiple MCAN on AM62x
Date:   Wed, 5 Jul 2023 14:53:54 -0500
Message-ID: <20230705195356.866774-1-jm@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On AM62x there are two MCANs in MCU domain. The MCANs in MCU domain
were not enabled since there is no hardware interrupt routed to A53
GIC interrupt controller. Therefore A53 Linux cannot be interrupted
by MCU MCANs.

This solution instantiates a hrtimer with 1 ms polling interval
for MCAN device when there is no hardware interrupt property in
DTB MCAN node. The hrtimer generates a recurring software interrupt
which allows to call the isr. The isr will check if there is pending
transaction by reading a register and proceed normally if there is.
MCANs with hardware interrupt routed to A53 Linux will continue to
use the hardware interrupt as expected.

Timer polling method was tested on both classic CAN and CAN-FD
at 125 KBPS, 250 KBPS, 1 MBPS and 2.5 MBPS with 4 MBPS bitrate
switching.

Letency and CPU load benchmarks were tested on 3x MCAN on AM62x.
1 MBPS timer polling interval is the better timer polling interval
since it has comparable latency to hardware interrupt with the worse
case being 1ms + CAN frame propagation time and CPU load is not
substantial. Latency can be improved further with less than 1 ms
polling intervals, howerver it is at the cost of CPU usage since CPU
load increases at 0.5 ms.

Note that in terms of power, enabling MCU MCANs with timer-polling
implementation might have negative impact since we will have to wake
up every 1 ms whether there are CAN packets pending in the RX FIFO or
not. This might prevent the CPU from entering into deeper idle states
for extended periods of time.

v8:
Link: https://lore.kernel.org/linux-can/20230530224820.303619-1-jm@ti.com/T/#t

v7:
Link: https://lore.kernel.org/linux-can/20230523023749.4526-1-jm@ti.com/T/#t

v6:
Link: https://lore.kernel.org/linux-can/20230518193613.15185-1-jm@ti.com/T/#t

v5:
Link: https://lore.kernel.org/linux-can/20230510202952.27111-1-jm@ti.com/T/#t

v4:
Link: https://lore.kernel.org/linux-can/c3395692-7dbf-19b2-bd3f-31ba86fa4ac9@linaro.org/T/#t

v2:
Link: https://lore.kernel.org/linux-can/20230424195402.516-1-jm@ti.com/T/#t

V1:
Link: https://lore.kernel.org/linux-can/19d8ae7f-7b74-a869-a818-93b74d106709@ti.com/T/#t

RFC:
Link: https://lore.kernel.org/linux-can/52a37e51-4143-9017-42ee-8d17c67028e3@ti.com/T/#t

v9:
- Change add MS to HRTIMER_POLL_INTERVAL
- Change syntax from "= 0" to "!"

v8:
- Cancel hrtimer after interrupts in m_can_stop
- Move assignment of hrtimer_callback to m_can_class_register()
- Initialize irq = 0 if polling mode is used

v7:
- Clean up m_can_platform.c after removing poll-interval

v6:
- Move hrtimer stop/start function calls to m_can_open and m_can_close to
support power suspend/resume

v5:
- Remove poll-interval in bindings
- Change dev_dbg to dev_info if hardware int exists and polling
is enabled

v4:
- Wrong patches sent

v3:
- Update binding poll-interval description
- Add oneOf to select either
interrupts/798d276b39e984345d52b933a900a71fa0815928

v2:
- Add poll-interval property to bindings and MCAN DTB node
- Add functionality to check for 'poll-interval' property in MCAN node 
- Bindings: add an example using poll-interval
- Add 'polling' flag in driver to check if device is using polling method
- Check for timer polling and hardware interrupt cases, default to
hardware interrupt method
- Change ns_to_ktime() to ms_to_ktime()

Judith Mendez (2):
  dt-bindings: net: can: Remove interrupt properties for MCAN
  can: m_can: Add hrtimer to generate software interrupt

 .../bindings/net/can/bosch,m_can.yaml         | 20 ++++++++++--
 drivers/net/can/m_can/m_can.c                 | 32 ++++++++++++++++++-
 drivers/net/can/m_can/m_can.h                 |  3 ++
 drivers/net/can/m_can/m_can_platform.c        | 23 +++++++++++--
 4 files changed, 72 insertions(+), 6 deletions(-)


base-commit: e1f6a8eaf1c271a0158114a03e3605f4fba059ad
-- 
2.34.1

