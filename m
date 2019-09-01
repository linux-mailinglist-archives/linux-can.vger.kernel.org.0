Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82F14A4C70
	for <lists+linux-can@lfdr.de>; Mon,  2 Sep 2019 00:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfIAWMF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 1 Sep 2019 18:12:05 -0400
Received: from smtp7.web4u.cz ([81.91.87.87]:32855 "EHLO mx-8.mail.web4u.cz"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728942AbfIAWMF (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sun, 1 Sep 2019 18:12:05 -0400
X-Greylist: delayed 410 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Sep 2019 18:12:02 EDT
Received: from mx-8.mail.web4u.cz (localhost [127.0.0.1])
        by mx-8.mail.web4u.cz (Postfix) with ESMTP id DD91A1FF1CD;
        Mon,  2 Sep 2019 00:05:07 +0200 (CEST)
Received: from baree.pikron.com (unknown [89.102.8.6])
        (Authenticated sender: ppisa@pikron.com)
        by mx-8.mail.web4u.cz (Postfix) with ESMTPA id 9E2081FF1C0;
        Mon,  2 Sep 2019 00:05:07 +0200 (CEST)
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: qemu can packet lost
Date:   Mon, 2 Sep 2019 00:05:07 +0200
User-Agent: KMail/1.9.10
Cc:     "Marc Kleine-Budde" <mkl@pengutronix.de>,
        linux-can@vger.kernel.org, kernel@pengutronix.de
References: <20190829124837.GA14689@pengutronix.de>
In-Reply-To: <20190829124837.GA14689@pengutronix.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201909020005.07414.pisa@cmp.felk.cvut.cz>
X-W4U-Auth: 19a8360822da03ff2c08761b6fb24aacf1a38046
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Oleksij,

thanks for report and suggestion.
I cannot promiss anything due to lack of financing
and people for this project. I am aware that QEMU CAN
bus support initial KISS design. I am happy that it
has some use in this form. I have invested my personal
time to mentor RTEMS CAN QEMU GSoC slot and then to
rewrite code to the mainline acceptable state.

There are much more to think about:
 - back pressure mechanism from CanBusClientState
   in real CAN network it is realized by real speed
   limits and overload frames. But overload frames are
   internal mechanism which is not exposed by SocketCAN
   interfaces.
 - more CAN interfaces, it would be great to have Zynq
   and i.MX6 support to emulate real automotive related
   targets
 - CAN FD support, without really well paid contract for university
   or my company or other consortium, I would not invest my personal time
   to any closed source CAN FD core or work. My life and time is too precious
   for me to work on and support project which could be closed/blocked/destroyed
   by random manager or professor (as happend already too much times to me).
   So my plan and hope is to find time, energy or even financing to continue
   work on opensource CAN FD core which design has started at our university
   and Mr. Ille and I invest our personal time into
       see http://canbus.pages.fel.cvut.cz/

   Actual progress from January is complete CAN protocol control
   redesign and cleanup up to the state that core passes basic real hardware
   tests (Zynq and PC+PCIe Altera/Intel) again. So it is time to start again
   with review process for open-firmare entry inclusion and then
   discussion about driver changes to make it ready for mainline.
   CAN FD for QEMU comes to the mind only after progress on this side.

Best wishes,

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://dce.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa (alternatively http://pikron.com/ )



On Thursday 29 of August 2019 14:48:37 Oleksij Rempel wrote:
> Hi all,
>
> Just in case some one has similar problem. Current QEMU with CAN support
> is not totally realistic when it comes to sending frames. When the QEMU
> is attached to a vcan, then it sends out the CAN frames as fast as it
> could. Another QEMU attached to the same vcan tends to drop frames
> during reception.
>
> One of the ways to fix it is to send packets from QEMU with proper
> packet rate. For example the hw/net/can/can_sja1000.c could delay the TX
> complete interrupt based on the configured CAN bit timing and CAN frame
> length.
>
> In case some one has time to do it:
>
> This function can be used to calculate the frame length:
>
>   https://github.com/linux-can/can-utils/blob/master/canframelen.c#L239
>
> I think CFL_WORSTCASE is good enough :)
>
> and this example shows how to properly delay and interrupt call in QEMU:
>
>   https://github.com/qemu/qemu/blob/master/hw/net/e1000.c#L270
>
> regards,
> Oleksij & Marc

