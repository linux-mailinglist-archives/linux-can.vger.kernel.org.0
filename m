Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F1B3349C8
	for <lists+linux-can@lfdr.de>; Wed, 10 Mar 2021 22:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhCJVXY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 Mar 2021 16:23:24 -0500
Received: from mx1.emlix.com ([136.243.223.33]:44246 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231207AbhCJVW4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 10 Mar 2021 16:22:56 -0500
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 91DCE60168;
        Wed, 10 Mar 2021 22:22:54 +0100 (CET)
Date:   Wed, 10 Mar 2021 22:22:54 +0100
From:   Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: Softirq error with mcp251xfd driver
Message-ID: <20210310212254.GA2050@homes.emlix.com>
References: <20210310064626.GA11893@homes.emlix.com>
 <20210310071351.rimo5qvp5t3hwjli@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210310071351.rimo5qvp5t3hwjli@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Mar 10, 2021 at 08:13:51AM +0100, Marc Kleine-Budde wrote:
> On 10.03.2021 07:46:26, Daniel Gl�ckner wrote:
> > the mcp251xfd driver uses a threaded irq handler to queue skbs with the
> > can_rx_offload_* helpers. I get the following error on every packet until
> > the rate limit kicks in:
> > 
> > NOHZ tick-stop error: Non-RCU local softirq work is pending, handler
> > #08!!!
> 
> That's a known problem. But I had no time to investigate it.
> 
> > Adding local_bh_disable/local_bh_enable around the can_rx_offload_* calls
> > gets rid of the error, but is that the correct way to fix this?
> > Internally the can_rx_offload code uses spin_lock_irqsave to safely
> > manipulate its queue.
> 
> The problem is not the queue handling inside of rx_offload, but the call
> to napi_schedule(). This boils down to raising a soft IRQ (the NAPI)
> from the threaded IRQ handler of the mcp251xfd driver.
> 
> The local_bh_enable() "fixes" the problem running the softirq if needed.
> 
> https://elixir.bootlin.com/linux/v5.11/source/kernel/softirq.c#L1913
> 
> I'm not sure how to properly fix the problem, yet.

If I understand correctly, the point of using can_rx_offload_* in the
mcp251xfd driver is that it sorts the rx, tx, and error frames according
to their timestamp. In that case calling local_bh_enable after each packet
is not correct because there will never be more than one packet in the
queue. We want to call local_bh_disable + can_rx_offload_schedule +
local_bh_enable only at the end of mcp251xfd_irq after intf_pending
indicated that there are no more packets inside the chip. How about adding
a flag to struct can_rx_offload that suppresses the automatic calls to
can_rx_offload_schedule?

If there is the risk that under high load we will never exit the loop in
mcp251xfd_irq or if can_rx_offload_napi_poll might run again while we add
more packets to the queue, a more complex scheme is needed. We could
extend can_rx_offload_napi_poll to process only packets with a timestamp
below a certain value. That value has to be read from the TBC register
before we read the INT register. Then the three functions can be run after
each iteration to empty the queue. We need to update that timestamp limit
one more time when we finally exit the loop to process those packets that
have arrived after the reading of the TBC register when the INT register
still had bits set. Using the timestamp of the tail of the queue is
probably the easiest way to set the final limit.

Best regards,

  Daniel
