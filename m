Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0558556422
	for <lists+linux-can@lfdr.de>; Wed, 26 Jun 2019 10:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbfFZINI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Jun 2019 04:13:08 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:41547 "EHLO protonic.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbfFZINH (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 26 Jun 2019 04:13:07 -0400
Received: from erd988 (erd988.prtnl [192.168.224.30])
        by sparta (Postfix) with ESMTP id AF3D944A00D3;
        Wed, 26 Jun 2019 10:14:50 +0200 (CEST)
Date:   Wed, 26 Jun 2019 10:13:06 +0200
From:   David Jander <david@protonic.nl>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        AVERMAETE Kristoff <kristoff.avermaete@vanhool.com>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: Linux J1939: built in-kernel vs. user space stack?
Message-ID: <20190626101306.164d36f9@erd988>
In-Reply-To: <79f5ed74-671a-4253-2628-7d9df58f3694@pengutronix.de>
References: <79f5ed74-671a-4253-2628-7d9df58f3694@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


Hello Kristoff,

Nice to have other people trying out this J1939 stack!

On Wed, 26 Jun 2019 09:35:02 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> Hello Kristoff,
> 
> as discussed, let's move this discussion to the linux-can mailing list.
> 
> regards,
> Marc
> 
> ---
> 
> Dear Marc,
> 
> Recently I started working with Van Hool, a Belgian touring car
> manufacturer that is using the J1939 stack for some of its intelligent
> devices.
> 
> I would like to introduce a test platform for internal application
> development. In search for a solution I discovered your major
> contribution to Linux for CAN and J1939.

I'd like to point out that this stack is the original work of Kurt van Dijck.
The company I work for develops ISObus software (which is based on J1939), and
I found out about Kurt's implementation a few years ago and asked why it
wasn't mainlined, and whether he would be ok if we tried to do so.
Marc and Oleksij took over that task now. It has become much more work than
initially expected, but I think we are close now :)

> As a pilot case, I merged your code to a recent Raspberry Pi kernel,
> which appears to be working fine at first glance.

Cool! Please keep us updated on how that goes...

> Now I have a little question: why was the J1939 stack built into the
> kernel? 

The idea behind having a kernel stack are more or less for the same reasons as
to have a TCP/IP stack in the kernel: To avoid having all user-space
applications receive all the network data duplicated and having to fish out
what is for them and what not.

In the case of J1939 it is an extension of the CAN bus. Imagine several J1939
applications running on the same host, connected to the CAN/J1939 bus.
Specially for (E)TP sessions it is a big advantage not having to receive all
the individual CAN frames on every user-space application, and instead just
receive the whole data blob once the kernel has assembled it and decided which
application is the destination.
On a 250kbaud CAN bus a TP burst can cause 100s or 1000s of messages being
sent at about 2000 messages/s. Duplicate that for each user-space application
that has a CAN socket open and things escalate quickly!

> Do you think it would be an interesting contribution if I isolated the
> functionality in user space?
> That way we could test our application code along with the isolated
> J1939 stack on whatever CAN-enabled Linux platform is provided to us.
> 
> Do you think this is a bad idea?

With "isolating" the functionality in user-space, you mean having a separate
user-space J1939 stack that can be used for testing the kernel-stack?
That would actually be a great idea.

There is J1939 support in the can-utils already:

https://github.com/linux-can/can-utils

But a full-blown alternative implementation that can be used for
regression-testing may be nice to have of course, if it can be GPL'ed

Best regards,

-- 
David Jander
Protonic Holland.
