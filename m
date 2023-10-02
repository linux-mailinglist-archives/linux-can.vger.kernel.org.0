Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC0D7B4D9B
	for <lists+linux-can@lfdr.de>; Mon,  2 Oct 2023 10:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbjJBIui (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 2 Oct 2023 04:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbjJBIue (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 Oct 2023 04:50:34 -0400
X-Greylist: delayed 564 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 Oct 2023 01:50:29 PDT
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071DEF2;
        Mon,  2 Oct 2023 01:50:28 -0700 (PDT)
Received: from localhost (styx2022 [192.168.200.17])
        by smtpx.fel.cvut.cz (Postfix) with ESMTP id 8B9BBBC51;
        Mon,  2 Oct 2023 10:40:45 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: styx2022.feld.cvut.cz (amavisd-new);
        dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
        by localhost (styx2022.feld.cvut.cz [192.168.200.17]) (amavisd-new, port 10060)
        with ESMTP id VeoQq_FYZ6hg; Mon,  2 Oct 2023 10:40:43 +0200 (CEST)
Received: from baree.pikron.com (ip-78-102-109-231.bb.vodafone.cz [78.102.109.231])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pisa)
        by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id D630ABC50;
        Mon,  2 Oct 2023 10:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
        s=felmail; t=1696236043;
        bh=So+n1rsgSozm5YSNGHfkXoo7rKyW0sz8qafJxc8NqIY=;
        h=From:To:Subject:Date:Cc:From;
        b=Ket0m0XZD5XZ/iKtFpltbope0HGY+XUEYZzDyjZF8nvPRJ/QQG2l7j60Md3+6zSfT
         ZqbSOcCJT5QbAc/m8Hr/g5GB30rqOq++1K1dMOojqmvGYlNItXI/OH9wB5B9pi6vIa
         wUX4ZkCJBZAU6oBJAJLHzoQgEKtwl68vyoxpeequCkipnw5U3pqyhzecXcPMzabXoF
         F+FA8qfmLfXyuwpC/hop01mimfBq0VSRr1N+6HYKCnxmhEMW9ObZdbP/InO1VGnKmn
         UdYrcNi6wyC0JjhNbdVYLFnLO22GruS72E3d9xAbBx7r4Ely1g5DfICfEiXVJzlL48
         lKrHAdDg3BFDw==
From:   Pavel Pisa <pisa@fel.cvut.cz>
To:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-rt-users@vger.kernel.org
Subject: Outstanding latency increase in kernel CAN gateway caught by CANlatester daily builds at 2023-10-02
Date:   Mon, 2 Oct 2023 10:40:49 +0200
User-Agent: KMail/1.9.10
Cc:     Ondrej Ille <ondrej.ille@gmail.com>,
        =?iso-8859-2?q?Mat=ECj_Vasilevski?= <matej.vasilevski@gmail.com>,
        Pavel Hronek <hronepa1@fel.cvut.cz>,
        =?iso-8859-2?q?Ji=F8=ED_Nov=E1k?= <jnovak@fel.cvut.cz>,
        Carsten Emde <c.emde@osadl.org>,
        Jan Altenberg <Jan.Altenberg@osadl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <202310021040.49367.pisa@fel.cvut.cz>
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Oliver and others,

two consecutive daily runs of our CAN latency system

  https://canbus.pages.fel.cvut.cz/#can-bus-channels-mutual-latency-testing

shows extreme increase in latency of the kernel CAN gateway under the load.
The first run with increased latency (run-DATE-TIME-KERNEL-OPTIONS)

  
run-231002-045216-hist+6.6.0-rc3-rt5-ge31516c1e553+flood-kern-prio-fd-load.jsonn

previous one consistent with daily runs form May

  
run-231001-045220-hist+6.6.0-rc3-rt5-ge31516c1e553+flood-kern-prio-fd-load.json

The history of the monitoring for kernel gateway under the load for latest RT 
kernels,
branch run on "linux-rt-devel/for-kbuild-bot/current-stable" branch

  
https://canbus.pages.fel.cvut.cz/can-latester/inspect.html?kernel=rt&load=1&flood=1&fd=1&prio=1&kern=1

Monitoring of latency when userspace application is used to forward
data from one to another CAN interface does not show similar excess

  
https://canbus.pages.fel.cvut.cz/can-latester/inspect.html?kernel=rt&load=1&flood=1&fd=1&prio=1&kern=0

It is interesting that when priority of CAN controller interrupt service 
routines
are not boosted then problem does not appear. Priority 90 is set for each 
irq/[0-9]+-can[0-9]
thread by

  chrt -f --pid 90 $pid

The device under the test as well as messages generation and monitoring
system are MZ_APO boards (AMD/XlinX Zynq XC7Z010) with CTU CAN FD IP core
CAN controller configured for 10 ns frames timestamping.

The problem can be in configuration of our system, CTU CAN FD IP core driver
or specific to Zynq ARM platform. But it is generally suspicious because
after initial tuning of the test system there has not been modifications
for long time. Monitoring system is running 6.2.0-rt3-00007-ge3a16816f987
kernel for all time and no problem with some Rx buffers overflow
on the tester side is reported for time covering all tests in the question.

Please, report if you have some idea which change between reported
versions from 2023-10-01 and 2023-10-02 could be reason for the change.
I plan to keep eye on results till end of the week and if the problem
continues then I start to investigate more by beginning of the next week
when I should find a little more time. I am quite busy by preparation for
conference and teaching this week so I do not expect to find much time.

Best wishes,

                Pavel
-- 
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home
