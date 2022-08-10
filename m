Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139F458EA79
	for <lists+linux-can@lfdr.de>; Wed, 10 Aug 2022 12:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiHJKeH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 10 Aug 2022 06:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHJKeG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 Aug 2022 06:34:06 -0400
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 Aug 2022 03:34:03 PDT
Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E32753B1
        for <linux-can@vger.kernel.org>; Wed, 10 Aug 2022 03:34:03 -0700 (PDT)
Received: from genesis.baggywrinkle.co.uk ([31.125.18.98])
        by smtp with ESMTP
        id LizLofPPwHHF7LizMos7TN; Wed, 10 Aug 2022 11:31:00
 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=GpdRR25C c=1 sm=1 tr=0 ts=62f388e4
 a=86bM3K2DLQsQH5/1ktvscg==:117 a=86bM3K2DLQsQH5/1ktvscg==:17
 a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=ccRei-trmjVMO_n8gXYA:9 a=CjuIK1q_8ugA:10
Received: from localhost (localhost [127.0.0.1])
        by genesis.baggywrinkle.co.uk (Postfix) with ESMTP id 4CA769CF606B;
        Wed, 10 Aug 2022 11:30:58 +0100 (BST)
X-Virus-Scanned: amavisd-new at mydomain = baggywrinkle.co.uk
Received: from genesis.baggywrinkle.co.uk ([127.0.0.1])
        by localhost (genesis.baggywrinkle.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cBXcJCwEpvqH; Wed, 10 Aug 2022 11:30:55 +0100 (BST)
Received: from smtpclient.apple (bavaria.baggywrinkle.co.uk [10.0.10.194])
        by genesis.baggywrinkle.co.uk (Postfix) with ESMTPSA id 5C8349CF6055;
        Wed, 10 Aug 2022 11:30:55 +0100 (BST)
From:   Mark Bath <mark@baggywrinkle.co.uk>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Date:   Wed, 10 Aug 2022 11:30:53 +0100
Subject: Raspberry PI running 5.10.x Kernel and issues with Daul channel
 Waveshare based 2.1 MCP251xFD CAN HAT 
Cc:     mkl@pengutronix.de
To:     linux-can@vger.kernel.org
Message-Id: <9024B39B-CCDA-4E10-9A4E-70A4335F6304@baggywrinkle.co.uk>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-CMAE-Envelope: MS4xfIFqL7thgAZZzSamUbh+hqSftJs6Fk5Yd2HSYbpc7s857ft1sSsQRAsLx5XmkGeFoTsNHnhwf01pz1rh8sIN67SkZ5kS/RT1sI91GaMpge0GNF3Ndv5/
 C8ViTG6ReRDPVTohe2TqpQ5SYTrZEncQG3OGdy9cMUejxp34Rg7Lm7IvtaeVjQDXKToPzIZkKvjrWBr3+tpdJylg449VQ1N3/SI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Good morning,

I hope someone can give me some pointers on what might be causing my system an issue or how to debug the issue.

The revision 2 Waveshare Dual channel MCP251xFD CAN HAT was working fine in my LAB with 2 or 3 other can devices. Both can channels are using standard 29 bit CAN2.0 extended identifiers. The can0 interface was running at 250kb, and can1at 500Kb.

As soon as I moved the device into my live environment I have started to have issues.

The 250Kb segment has around 10-15 devices and a bus length of something in the order of 40m, properly terminated at each end with a 120ohm resistor. The 500kb segment has 2 devices and is maybe 10m in length and also properly terminated. Without the PI connected both segments are running fine with no reported BER counters. The following output is from an embedded linux based device on the network when my PI is not connected.

root@Venus:~# ip -details link show can0
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode DEFAULT group default qlen 100
    link/can  promiscuity 0 minmtu 0 maxmtu 0 
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 100 
	  bitrate 250000 sample-point 0.875 
	  tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
	  sun4i_can: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
	  clock 24000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 

The bus loading is very low.

root@Venus:~# canbusload can0@250000 
 can0@250000    84   13440   5376   5%
 can0@250000   133   21280   8512   8%
 can0@250000    95   15200   6080   6%
 can0@250000   114   18240   7296   7%
 can0@250000   105   16800   6720   6%
 can0@250000   132   21020   8368   8%
 can0@250000   104   16640   6656   6%


As soon as I attach the PI4 with the revision 2.1 waveshare 251xFD dual can hat I start getting BER errors on devices, and the PI is reporting RX BER errors. 

The embedded Linux device
root@Venus:~# ip -details link show can0
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode DEFAULT group default qlen 100
    link/can  promiscuity 0 minmtu 0 maxmtu 0 
    can state ERROR-ACTIVE (berr-counter tx 0 rx 83) restart-ms 100 
	  bitrate 250000 sample-point 0.875 
	  tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
	  sun4i_can: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
	  clock 24000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 


RaspberryPI4 with the wave share dual can hat
root@Olaso-PI:~# ip -details link show can0
5: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode DEFAULT group default qlen 100
    link/can  promiscuity 0 minmtu 0 maxmtu 0 
    can state ERROR-WARNING (berr-counter tx 0 rx 124) restart-ms 100 
	  bitrate 250000 sample-point 0.875 
	  tq 25 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 1
	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-inc 1
	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-inc 1
	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 

ip -details link show can1
6: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP mode DEFAULT group default qlen 100
    link/can  promiscuity 0 minmtu 0 maxmtu 0 
    can state ERROR-WARNING (berr-counter tx 0 rx 125) restart-ms 100 
	  bitrate 500000 sample-point 0.875 
	  tq 25 prop-seg 34 phase-seg1 35 phase-seg2 10 sjw 1
	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp-inc 1
	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp-inc 1
	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 

Do you have any idea what might be doing this. I have checked cables, termination, voltages, etc and all are OK. I have asked Waveshare and basically been given the not our issue, its the network.

I have even checked the cable drops between the backbone and PI, by plugging alternative devices in and they have behaved correctly. Moving the PI to an alternative drop has also not hanged anything.

It seems to me that there might be a timing issue, but have no idea how to check.


Thank you.

Regards

Mark



