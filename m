Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BDD58EB35
	for <lists+linux-can@lfdr.de>; Wed, 10 Aug 2022 13:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiHJLYJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 10 Aug 2022 07:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiHJLYI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 Aug 2022 07:24:08 -0400
Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E41274E02
        for <linux-can@vger.kernel.org>; Wed, 10 Aug 2022 04:24:07 -0700 (PDT)
Received: from genesis.baggywrinkle.co.uk ([31.125.18.98])
        by smtp with ESMTP
        id LjojofcqQHHF7Ljokos9QB; Wed, 10 Aug 2022 12:24:06
 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=GpdRR25C c=1 sm=1 tr=0 ts=62f39556
 a=86bM3K2DLQsQH5/1ktvscg==:117 a=86bM3K2DLQsQH5/1ktvscg==:17
 a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=bGNZPXyTAAAA:8 a=lneh_w3DiUngg6D-LXoA:9
 a=CjuIK1q_8ugA:10 a=yL4RfsBhuEsimFDS2qtJ:22
Received: from localhost (localhost [127.0.0.1])
        by genesis.baggywrinkle.co.uk (Postfix) with ESMTP id E5B7C9CF698B;
        Wed, 10 Aug 2022 12:24:03 +0100 (BST)
X-Virus-Scanned: amavisd-new at mydomain = baggywrinkle.co.uk
Received: from genesis.baggywrinkle.co.uk ([127.0.0.1])
        by localhost (genesis.baggywrinkle.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RH59XogFkVg8; Wed, 10 Aug 2022 12:24:01 +0100 (BST)
Received: from smtpclient.apple (bavaria.baggywrinkle.co.uk [10.0.10.194])
        by genesis.baggywrinkle.co.uk (Postfix) with ESMTPSA id 423629CF696C;
        Wed, 10 Aug 2022 12:24:00 +0100 (BST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: Raspberry PI running 5.10.x Kernel and issues with Daul channel
 Waveshare based 2.1 MCP251xFD CAN HAT
From:   Mark Bath <mark@baggywrinkle.co.uk>
In-Reply-To: <CD5C45C2-85DE-4105-B096-13FDA3FE1932@baggywrinkle.co.uk>
Date:   Wed, 10 Aug 2022 12:23:58 +0100
Cc:     linux-can@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1FF90807-2BB0-47A0-9F42-6AC048DD2B94@baggywrinkle.co.uk>
References: <9024B39B-CCDA-4E10-9A4E-70A4335F6304@baggywrinkle.co.uk>
 <20220810103605.nsh7r4pe6g7lzbvv@pengutronix.de>
 <CD5C45C2-85DE-4105-B096-13FDA3FE1932@baggywrinkle.co.uk>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-CMAE-Envelope: MS4xfKw90+I8T+VRgr/Cd4d/Tg7R7inq1EAKAJ5uXrQNYBQzvGtF62RYZt/Zy5tjX7KWt9Y3M7v2ZF9miFptiuvdz2tuiIX213aAGOSO8On2KQYxSSS2ShM1
 mesoEmpJ5EJwKzYSEg2J7lY8zumr+Mwbt66YO0jxP2Ke8yK2CwVGj7d+O3I36ZTGzOYlBfq3jpttRuPfa4scqhccogZk8+Pal/U=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> On 10 Aug 2022, at 11:36, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> 
>> The embedded Linux device
>> root@Venus:~# ip -details link show can0
>> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode DEFAULT group default qlen 100
>>    link/can  promiscuity 0 minmtu 0 maxmtu 0 
>>    can state ERROR-ACTIVE (berr-counter tx 0 rx 83) restart-ms 100 
>> 	  bitrate 250000 sample-point 0.875 
>> 	  tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
>                                         ^^^^^^^^^^^^^^^^^^
> 
> Here the sjw is 50% of phase-seg2.
> 
>> 	  sun4i_can: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
>> 	  clock 24000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 
>> 
>> 
>> RaspberryPI4 with the wave share dual can hat
>> root@Olaso-PI:~# ip -details link show can0
>> 5: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode DEFAULT group default qlen 100
>>    link/can  promiscuity 0 minmtu 0 maxmtu 0 
>>    can state ERROR-WARNING (berr-counter tx 0 rx 124) restart-ms 100 
>> 	  bitrate 250000 sample-point 0.875 
>> 	  tq 25 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 1
>                                          ^^^^^^^^^^^^^^^^^^^
> Can you try to configure sjw to 10 on the mcp251xfd for 250 kbit/s.

That did it. All stable and working great.

> Which tool are you using to configure the bitrate?

Ip command from iproute2

ip link set $dev up txqueuelen 100 type can bitrate $rate restart-ms 100

> 
>> 	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-inc 1
>> 	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-inc 1
>> 	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 
>> 
>> ip -details link show can1
>> 6: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode DEFAULT group default qlen 100
>>    link/can  promiscuity 0 minmtu 0 maxmtu 0 
>>    can state ERROR-WARNING (berr-counter tx 0 rx 125) restart-ms 100 
>> 	  bitrate 500000 sample-point 0.875 
>> 	  tq 25 prop-seg 34 phase-seg1 35 phase-seg2 10 sjw 1
>                                          ^^^^^^^^^^^^^^^^^^^
> 
> Try a sjw of 5 for 500 kbit/s.

That also worked.

Should I be manually setting the sow value or should it have been set automatically?

Thank you for the quick response, while it looks like an easy fix, the system has many different possible can hats that could be used so modifying the ip command could be challenging for just this HAT.

> 
> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
