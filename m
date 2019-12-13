Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 579D311E845
	for <lists+linux-can@lfdr.de>; Fri, 13 Dec 2019 17:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfLMQ1J (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 13 Dec 2019 11:27:09 -0500
Received: from smtpx.feld.cvut.cz ([147.32.192.33]:59101 "EHLO
        smtpx.feld.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfLMQ1J (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Dec 2019 11:27:09 -0500
Received: from localhost (styx [192.168.200.7])
        by smtpx.feld.cvut.cz (Postfix) with ESMTP id 788F5B7E0;
        Fri, 13 Dec 2019 17:27:07 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.feld.cvut.cz ([192.168.200.2])
        by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10060)
        with ESMTP id 4liwOk4R9rEJ; Fri, 13 Dec 2019 17:27:05 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
        by smtpx.feld.cvut.cz (Postfix) with ESMTP id 5CE70B47E;
        Fri, 13 Dec 2019 17:27:05 +0100 (CET)
Received: from wsh by steelpick.2x.cz with local (Exim 4.93)
        (envelope-from <michal.sojka@cvut.cz>)
        id 1ifnmS-0001fQ-TB; Fri, 13 Dec 2019 17:27:04 +0100
From:   Michal Sojka <michal.sojka@cvut.cz>
To:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc:     Bernd Krumboeck <b.krumboeck@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: usb_8dev - WARN_ON(in_irq())
In-Reply-To: <877e30a4kg.fsf@steelpick.2x.cz>
Date:   Fri, 13 Dec 2019 17:27:04 +0100
Message-ID: <87h8245gyv.fsf@steelpick.2x.cz>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Dec 13 2019, Michal Sojka wrote:
> Hi Oliver,
>
> On Fri, Dec 13 2019, Oliver Hartkopp wrote:
>> Did you do anything weird (e.g. pulling the USB plug on the run) to get 
>> this problem?
>
> No, I just connected it to an ECU and started sending messages on the
> bus. The behaviour was like if the messages were not acknowledged, i.e.,
> initially, candump on my laptop showed the messages sent, but after some
> time (perhaps after TX buffers were full), candump stopped. I was also
> not able to see any messages sent by the ECU (both before and after I
> sent my messages).
>
> When I used the same ECU and all the wiring with peak_usb, communication
> with the ECU was without any problems.

I did more investigation - I was able to fix the problem by adding a
terminator resistor to the bus.

However, the problem can be easily reproduced by the following sequence
of commands, when the USB2CAN is not connected to any bus:

    ip link set can0 up txqueuelen 1000 type can bitrate 500000
    candump can0
    cangen -v -g 50 can0

when candump stops printing the messages, run:

    ip link set down dev can0

and the warnings appear in dmesg. I was also trying this with latest
mainline kernel, which includes the fix for use-after-free, and the
warnings are still there.

-Michal
