Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CDA4BDD74
	for <lists+linux-can@lfdr.de>; Mon, 21 Feb 2022 18:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240395AbiBUMGl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 21 Feb 2022 07:06:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiBUMGk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Feb 2022 07:06:40 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCFE201B5
        for <linux-can@vger.kernel.org>; Mon, 21 Feb 2022 04:06:17 -0800 (PST)
Received: from photo-meter.com ([62.157.68.154]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MG9Xu-1nTkeD3SSS-00GZ9T for <linux-can@vger.kernel.org>; Mon, 21 Feb 2022
 12:53:37 +0100
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id 5923C3B08B7
        for <linux-can@vger.kernel.org>; Mon, 21 Feb 2022 12:51:32 +0100 (CET)
Message-ID: <526e4899-3789-9130-ab34-6351e6b558b6@photo-meter.com>
Date:   Mon, 21 Feb 2022 12:53:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
To:     linux-can@vger.kernel.org
Reply-To: anochin@photo-meter.com
Content-Language: en-GB
From:   Michael Anochin <anochin@photo-meter.com>
Subject: can: tcan4x5x: LatchUp with errno 105 (NOBUFS), when using more than
 one can interface
Organization: Czibula und Grundmann GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Q4iz6INvNvAnlYjPgrx+U5C3bkESxEVr2FJLSINJUh5pEoRID32
 OIjQ2PHJ9MMsS3pVImuEIEHmjnyhIbRMLGGGqZm4HFoUb50d7PXnrq0sBEr9IEyghAM+Ygq
 Fug7O67+wc/Dknqez9abkhOOeh2l4t8UWVACVdf1CdZhvlMQWv10O2OBOLwu0uqUg2B8zg9
 Wz5aYyH08gYP5boKCPPRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CM9HVZEtLLc=:qp/iqyY1a0pRCMwJjjgXAF
 sgMho/2VNEkg7xNPWJ/aFoncsEaNRGXgVZM9U+BAPVWcufT9Ndv6rYB21PYIRxvmVmTyMDDiA
 uQMtQ7KoYkbkhOO4RRF0/Nqv6+P5uAjtbsAwBTExDyWxgC+yqxrC7DjeGNMg6UpkNlogk72pD
 +ZUx4/hkCusaiaW1HdLNGqZQCxrGTkLOQMCPlLwV4DEPgmu20dZZXjzSM1DwnlhZZI8vudyBE
 CrArgFk9aAd3IoKsFIcMN11xqp+SWx66SI+bu/7/vm+Ok8/vOeUQUBH9Qfe4LBMjwwS6d0KAF
 zGxSiw01Zxpj4K9fV++pa28dczbhBwmGb40uZiWIkf0S19WSOkXbjLr/5Ix/xKr3XJue10lbA
 L4KQjgyV8OEV2dgMXb0qbd45CiKudOMRwdR0D7gr6K6chFwxBUrWA/dPa746qfOT7yxbfQius
 iaWG5NHT8JHsIzi6TftqEAVKFxT0Q0pAuxAEjOUg50aS9/X56FvyKKuGVlZNe4EfDZDKRoYtQ
 wzxjCOtoVpwxXkOJrZ7pI7fQNNCJxBrA/Of4rVZcPtmbWwuQqitIK7GXeaVqYv0NArufoud/S
 lGZ+2uMckduIGG8Mtvlg/CfdYEqNmZSLjSepmGP0HD573HbPnIMHKUsN1+Ddp74PQJmHdWZyz
 mLIh4XbBU113S8umgAZkh1ZXMpHP1GkB3bm1m50QBtT5e/dR0NvZ9FErjTIa8RP9jNCANr9At
 nkmK/qIocknQeHkb90/XxdoHweYuaRYtzN+2xVJZtpq8QhGm99ZCfCvXtWM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

my Application runs on RaspberryPi4 and utilizes three can interfaces 
(can0-2), each has a tcan4550 chip on the spi0, spi4 and spi6 respectively.


This application communicate with up to 16 Nodes on each can-bus and 
sends in 10ms cycle a messages, i.e. with IDs 0x200..0x20F to each Node 
with no problem.

See a log from candump on pastebin (candump_any_only_tx):
https://pastebin.com/E9z6KGFu

I am using this overlay for it (tcan4x5x.dts)
https://pastebin.com/qtDzHqaL

Now, if I try to query a Status from each Node (one Query after the 
other in 5ms intervals), that leads to the error 105 by write to socket 
buffer. After that, buffer latchs up. A test with cansend on this 
interface, after killing the application, returns also "write: No buffer 
space available". This remains until ifdown.

Please see a log from candump with additional status query 
(candump_any_with_rx)
https://pastebin.com/rZNSnYEh

I have connected a logic analyzer to all SPI interfaces to view the 
traffic on SPI-Buses with sigrok / PulsView.
https://postimg.cc/QKtbS39q
https://postimg.cc/9zFJcG8q
https://postimg.cc/dDHn3LpN

If necessary, I can make dedicated capture and share diagrams.



$uname -a
Linux RPICAN-2 5.15.21-v7l+ #1 SMP PREEMPT Fri Feb 18 11:31:05 CET 2022 
armv7l GNU/Linux


$modinfo tcan4x5x:
filename: 
/lib/modules/5.15.21-v7l+/kernel/drivers/net/can/m_can/tcan4x5x.ko
license:        GPL v2
description:    Texas Instruments TCAN4x5x CAN driver
author:         Dan Murphy <dmurphy@ti.com>
srcversion:     DBF01ADB6B5CD83D778AAD9
alias:          spi:tcan4x5x
alias:          of:N*T*Cti,tcan4x5xC*
alias:          of:N*T*Cti,tcan4x5x
depends:        m_can
intree:         Y
name:           tcan4x5x
vermagic:       5.15.21-v7l+ SMP preempt mod_unload modversions ARMv7 p2v8

$modinfo m_can
filename: 
/lib/modules/5.15.21-v7l+/kernel/drivers/net/can/m_can/m_can.ko
description:    CAN bus driver for Bosch M_CAN controller
license:        GPL v2
author:         Dan Murphy <dmurphy@ti.com>
author:         Dong Aisheng <b29396@freescale.com>
srcversion:     8FD811EC24C8442A2AF6D65
depends:        can-dev
intree:         Y
name:           m_can
vermagic:       5.15.21-v7l+ SMP preempt mod_unload modversions ARMv7 p2v8




