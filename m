Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A943B6E774
	for <lists+linux-can@lfdr.de>; Fri, 19 Jul 2019 16:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfGSOga (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Jul 2019 10:36:30 -0400
Received: from enpas.org ([46.38.239.100]:58794 "EHLO mail.enpas.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbfGSOga (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 19 Jul 2019 10:36:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id ECEA010006E;
        Fri, 19 Jul 2019 14:36:27 +0000 (UTC)
Subject: Re: [PATCH] can: elmcan driver for ELM327 based OBD-II adapters
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
References: <20190711123608.5991-1-max-linux@enpas.org>
 <88c08b2c-aa4a-8858-6267-deeeac2796df@pengutronix.de>
From:   Max Staudt <max-linux@enpas.org>
Message-ID: <98d3e718-29a9-e872-3474-776b06bb2415@enpas.org>
Date:   Fri, 19 Jul 2019 16:36:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <88c08b2c-aa4a-8858-6267-deeeac2796df@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thanks Marc for your feedback!

On 07/19/2019 03:27 PM, Marc Kleine-Budde wrote:
> Can you convert the driver from a ldisc to a serdev driver?

I would have preferred that, but unfortunately this is not an option, because:

a) There is no way to autoprobe this driver. The serial ports it gets attached to are as generic as they come. Think "bog-standard PL2303 USB-serial converter that looks like any other", and next week it may be a CH340 instead.

b) The user may well want to initialise the device beforehand, e.g. to increase the baud rate.

For the above reasons, attachment needs to be initiated from userspace, using something like ldattach. I haven't found an equivalent for serdev, but please tell me if I've missed something. As I said, I'd prefer a serdev over an ldisc if it's feasible.


> There is also the problem of using netif_rx_ni(skb) to push the frames
> into networking stack. With this function the CAN frames might not end
> up in the user space in the correct order. You have to use
> netif_receive_skb(skb) to avoid this problem.

That's a very helpful hint, I didn't know that, and it must be a common mistake: There is a *ton* of CAN drivers using either netif_rx_ni or netif_rx(), and I built on their style.
Does that mean they are all wrong in this way, and this problem was only caught recently?


> However this is a bit more complicated, as you can only use this
> function from the NAPI context. You can setup a rx_offload, via
> can_rx_offload_add_fifo() and then use can_rx_offload_queue_tail() to
> push the CAN frames to the networking stack. See the flexcan driver as
> an example. Use this [1] version as a reference how to use
> can_rx_offload_queue_tail(). It's used here for error frames, but you
> can use it for normal frames as well.

Thanks for this help, I'll look into implementing this.


Max
