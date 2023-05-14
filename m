Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6560B701DE3
	for <lists+linux-can@lfdr.de>; Sun, 14 May 2023 16:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjENOr7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 14 May 2023 10:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENOr7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 14 May 2023 10:47:59 -0400
Received: from mailgw.felk.cvut.cz (mailgw.felk.cvut.cz [147.32.82.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58931716
        for <linux-can@vger.kernel.org>; Sun, 14 May 2023 07:47:56 -0700 (PDT)
Received: from mailgw.felk.cvut.cz (localhost.localdomain [127.0.0.1])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTP id 6732C30AE007;
        Sun, 14 May 2023 16:47:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        cmp.felk.cvut.cz; h=cc:cc:content-transfer-encoding:content-type
        :content-type:date:from:from:message-id:mime-version:reply-to
        :subject:subject:to:to; s=felkmail; bh=aaSZEspUwMO++vVyx4tqr/lc3
        lymjs6YjmCwum6AmfE=; b=hc0+qCD6zqwtHMSo1O1D+v0w9Ta+5N8Gd0r/LqzhS
        91g38X8YwdjG8Cd3q0fnCLrwhafhBBUmuH0RZG5otU/cRez3dZ42xP0pPqSZNr1w
        5pI+JJKYHFUBedL+0JIW0b9teY2hh/m6E1l0NLuleLU2+YuCqMRMEm9TmD+2Dzqe
        UV/J7S1B9NE2MAAagdClJJ8nIIBvAvd8ojZ2vaeo22uXRg4ZpoEiJe7p/WIWGTFY
        DXXlRp6fHI6cVQEc3gOd2naatuRic1muVxRmcuCAhx67pfMWULYhs+9zTQF+YHax
        Kak77U4aQJpPF7rEejE63fMvYMM1U6UkRPYemMeCS9WiA==
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by mailgw.felk.cvut.cz (Proxmox) with ESMTPS id A27ED30AD9FF;
        Sun, 14 May 2023 16:47:54 +0200 (CEST)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 34EElsxJ031367;
        Sun, 14 May 2023 16:47:54 +0200
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 34EElstK031365;
        Sun, 14 May 2023 16:47:54 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Continuous CAN/CAN FD latency testing on mainline and RT kernels
Date:   Sun, 14 May 2023 16:47:49 +0200
User-Agent: KMail/1.9.10
Cc:     Pavel Hronek <hronepa1@fel.cvut.cz>,
        Carsten Emde <c.emde@osadl.org>,
        Jan Altenberg <Jan.Altenberg@osadl.org>,
        Martin =?iso-8859-2?q?Je=F8=E1bek?= <martin.jerabek01@gmail.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        =?iso-8859-2?q?Mat=ECj_Vasilevski?= <matej.vasilevski@gmail.com>,
        =?iso-8859-2?q?Ji=F8=ED_Nov=E1k?= <jnovak@fel.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202305141647.49359.pisa@cmp.felk.cvut.cz>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Oliver and Carsten and others,

we have reached state where we have running CAN
latester service automatically again.

We use the CTU CAN FD IP core for precise timestamps
of messages on a measurement and load generation device
and user-space or kernel-space CAN gateway on
the device under the tests (DUT, at this moment
Zynq based MZ_APO kit with CTU CAN FD as well).
But there are minimal requirements on DUT side,
device sends all frames received on one CAN interface
to another one. All systems supported by SocketCAN
can be tested easily and implementation of GW
for other systems is simple as well. We have even
variant for testing of device with single interface
but for flood load it is not ideal setup.

The actual results overview with detailed and compare
sub-pages

  https://canbus.pages.fel.cvut.cz/can-latester/

The project is part of CTU CAN/CAN FD projects
of FEE at Czech Technical University in Prague

  https://canbus.pages.fel.cvut.cz/

Our overview last year article about our CAN projects
in general and CAN latency testing results and plans
in little more details there

  https://can-newsletter.org/uploads/media/raw/a9abe317ae034be55d99fee4410ad70e.pdf

Consider the announced setup as experimental still but we
hope that it will mature to durable, long term solution.
The actual setup includes Debian x86 virtual dedicated
for CAN latency testing control and results processing,
a rack with MZ_APO Xilinx Zynq (Linux 6.2.0-rt3 SMP PREEMPT_RT)
as measurement/load device, the second MZ_APO Xilinx Zynq
as actual/current DUT (mainline and linux-rt-devel for-kbuild-bot/current-stable)
kernels and ARM64 sun50i-h5-orangepi-zero-plus (Linux
6.1.15 #5 SMP PREEMPT) PiKRON.com provided testbed controller
which controls 24V and 5V power supply and monitors serial
ports of the both MZ_APO boards.

We plan presentation about GNU/Linux CAN support in general
and then about CAN bus/SocketCAN and its realtime capabilities
testing at RedHat DevConf CZ (June 17 3:30pm - 4:05pm CEST)

  https://devconfcz2023.sched.com/event/1MYjG/can-bus-in-control-automotive-and-satellitelites

We will be happy for feedback and proposals for future
development directions. But be prepared, that we are slow,
I spent the most of my time with computer architectures
teaching these days and I have some new motion control project
at company related to minor contribution to the ground
experiments in the frame of LISA (concept of low-frequency
gravitational wave detection in space) project at company.
But CAN in Linux, NuttX and RTEMS kernels and in FPGAs
is area of my long term interrest. I hope that we
reach mainline with CTU CAN FD timestamping patches.

As for actual setup, we see problems with preemp RT
kernel on Zynq platform with 6.3+ kernels (6.2 and
previous versions has been stable for years), but
the issue seems to be unrelated to SocketCAN so it
is discussion for another list.   

I want to thanks to colleagues, our graduates and studnets
who have contributed to the project and made it possible.
The theses directly related to the project

  https://dspace.cvut.cz/bitstream/handle/10467/80366/F3-DP-2019-Jerabek-Martin-Jerabek-thesis-2019-canfd.pdf
  https://dspace.cvut.cz/bitstream/handle/10467/101450/F3-DP-2022-Vasilevski-Matej-vasilmat.pdf

Pavel Hronek is now finishing his own bachelor thesis
related mainly to the CAN latency testing automation
and web presentation, it will be available after submition
on the list our CAN theses at https://canbus.pages.fel.cvut.cz/
as well as the wider reach of theses of OTREES informal group

  https://gitlab.fel.cvut.cz/otrees/org/-/wikis/theses-defend

Best wishes,

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

