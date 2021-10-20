Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA58434A76
	for <lists+linux-can@lfdr.de>; Wed, 20 Oct 2021 13:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJTLvZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Oct 2021 07:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhJTLvY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Oct 2021 07:51:24 -0400
X-Greylist: delayed 1817 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Oct 2021 04:49:09 PDT
Received: from relay.felk.cvut.cz (relay.felk.cvut.cz [IPv6:2001:718:2:1611:0:1:0:70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35138C06161C
        for <linux-can@vger.kernel.org>; Wed, 20 Oct 2021 04:49:09 -0700 (PDT)
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 19K9UqnO088693;
        Wed, 20 Oct 2021 11:30:52 +0200 (CEST)
        (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 19KBHtMO030204;
        Wed, 20 Oct 2021 13:17:55 +0200
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 19KBHt4r030201;
        Wed, 20 Oct 2021 13:17:55 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to pisa@cmp.felk.cvut.cz using -f
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     "Marc Kleine-Budde" <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org
Subject: Query for status of timestamping for XCAN driver and possible project
Date:   Wed, 20 Oct 2021 13:17:50 +0200
User-Agent: KMail/1.9.10
Cc:     Matej Vasilevski <vasilmat@fel.cvut.cz>,
        Michal Simek <michal.simek@xilinx.com>,
        Martin =?iso-8859-2?q?Je=F8=E1bek?= <martin.jerabek01@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202110201317.50743.pisa@cmp.felk.cvut.cz>
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 19K9UqnO088693
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
        score=-0.099, required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.40,
        SPF_HELO_NONE 0.00, SPF_NONE 0.00, URIBL_BLOCKED 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1635327055.91186@9p01BAUFrSrDNv1WJtqS7A
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Oliver and Marc,

our student, Matej Vasilevski, has chosen to continue
on CAN latency tester which we done for Oliver years
ago.

We want to continue on the CAN-BENCH project started
by Martin Jerabek

  https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top/-/wikis/home

  https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top/-/wikis/uploads/56b4d27d8f81ae390fc98bdce803398f/F3-BP-2016-Jerabek-Martin-Jerabek-thesis-2016.pd

We want to use XCAN on Xilinx Zynq 7010 with timestamping
in the first iteration, then switch to our CTU CAN FD core
and add timestamping to its driver.

Is there some more recent attempt to add timestamping
to XCAN driver than that original work of Martin Jerabek?

Is there some suggestion which driver is the right
example to implement timestamping now?

Our intention is to implement feature in state ready
for mainlining and we hope that with your feedback
we succeed this time.

Best wishes,

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://dce.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/

